/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

/**
 *
 * @author Ha Trung KI
 */
import util.DBContext;
import dal.InventoryTransactionDAO;
import dal.InventoryDAO;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * InventoryService - thực thi các thao tác phức tạp theo transaction
 * Sử dụng DBContext để lấy connection (shared) và tự commit/rollback
 */
public class InventoryService extends DBContext {

    private final InventoryDAO inventoryDAO;
    private final InventoryTransactionDAO txDAO;

    public InventoryService() {
        super(); // mở connection từ DBContext
        this.inventoryDAO = new InventoryDAO(); // Note: these DAOs open their own connection normally,
        this.txDAO = new InventoryTransactionDAO();
        // BUT for transactional ops we will use the connection from this class directly
        // (we will not call inventoryDAO methods that open separate connections)
    }

    /**
     * Move: giảm kho nguồn, tăng kho đích, ghi transaction MOVE
     * All in one DB transaction using this.connection
     *
     * @param productId
     * @param fromLocation
     * @param toLocation
     * @param qty
     * @param employeeId
     * @param note
     * @return true nếu thành công
     * @throws java.sql.SQLException
     */
    public boolean moveProductAtomic(int productId, int fromLocation, int toLocation, int qty, int employeeId, String note) throws SQLException {
        boolean success = false;
        try {
            connection.setAutoCommit(false);

            // 1) check source qty
            String checkSql = "SELECT qty, inventory_id FROM Inventory_records WHERE product_id = ? AND location_id = ?";
            try (var ps = connection.prepareStatement(checkSql)) {
                ps.setInt(1, productId);
                ps.setInt(2, fromLocation);
                try (var rs = ps.executeQuery()) {
                    if (!rs.next() || rs.getInt("qty") < qty) {
                        connection.rollback();
                        return false; // not enough stock
                    }
                }
            }

            // 2) decrease source
            String decSql = "UPDATE Inventory_records SET qty = qty - ?, last_update = GETDATE() WHERE product_id = ? AND location_id = ?";
            try (var ps = connection.prepareStatement(decSql)) {
                ps.setInt(1, qty);
                ps.setInt(2, productId);
                ps.setInt(3, fromLocation);
                ps.executeUpdate();
            }

            // 3) add to destination (if exists update, else insert)
            String findDest = "SELECT inventory_id FROM Inventory_records WHERE product_id = ? AND location_id = ?";
            Integer destInventoryId = null;
            try (var ps = connection.prepareStatement(findDest)) {
                ps.setInt(1, productId);
                ps.setInt(2, toLocation);
                try (var rs = ps.executeQuery()) {
                    if (rs.next()) {
                        destInventoryId = rs.getInt("inventory_id");
                    }
                }
            }

            if (destInventoryId != null) {
                String updDest = "UPDATE Inventory_records SET qty = qty + ?, last_update = GETDATE() WHERE inventory_id = ?";
                try (var ps = connection.prepareStatement(updDest)) {
                    ps.setInt(1, qty);
                    ps.setInt(2, destInventoryId);
                    ps.executeUpdate();
                }
            } else {
                String insDest = "INSERT INTO Inventory_records (product_id, location_id, qty, last_update) VALUES (?, ?, ?, GETDATE())";
                try (var ps = connection.prepareStatement(insDest)) {
                    ps.setInt(1, productId);
                    ps.setInt(2, toLocation);
                    ps.setInt(3, qty);
                    ps.executeUpdate();
                }
            }

            // 4) ghi transaction vào Inventory_transactions (dùng connection này)
            String insertTx = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, tx_date, note) VALUES (?, ?, NULL, ?, ?, ?, NULL, NULL, NULL, ?, GETDATE(), ?)";
            try (var ps = connection.prepareStatement(insertTx)) {
                ps.setString(1, "MOVE");
                ps.setInt(2, productId);
                ps.setInt(3, qty);
                ps.setInt(4, fromLocation);
                ps.setInt(5, toLocation);
                ps.setObject(6, employeeId);
                ps.setString(7, note);
                ps.executeUpdate();
            }

            connection.commit();
            success = true;
        } catch (SQLException ex) {
            try { connection.rollback(); } catch (SQLException e) { /* ignore */ }
            throw ex;
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException e) { /* ignore */ }
            // Do not close connection here because DBContext holds it; but if you want to close, be consistent.
        }
        return success;
    }

    /**
     * Audit: cập nhật tồn theo inventory_id, ghi transaction ADJUST_IN/ADJUST_OUT
     * @param inventoryId
     * @param newQty
     * @param employeeId
     * @param note
     * @throws java.sql.SQLException
     */
    public void auditAdjustAtomic(int inventoryId, int newQty, int employeeId, String note) throws SQLException {
        try {
            connection.setAutoCommit(false);

            // get current record
            String sel = "SELECT product_id, location_id, qty FROM Inventory_records WHERE inventory_id = ?";
            int productId, locationId, oldQty;
            try (var ps = connection.prepareStatement(sel)) {
                ps.setInt(1, inventoryId);
                try (var rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        connection.rollback();
                        throw new SQLException("Inventory record not found id=" + inventoryId);
                    }
                    productId = rs.getInt("product_id");
                    locationId = rs.getInt("location_id");
                    oldQty = rs.getInt("qty");
                }
            }

            int diff = newQty - oldQty;
            if (diff != 0) {
                String update = "UPDATE Inventory_records SET qty = ?, last_update = GETDATE() WHERE inventory_id = ?";
                try (var ps = connection.prepareStatement(update)) {
                    ps.setInt(1, newQty);
                    ps.setInt(2, inventoryId);
                    ps.executeUpdate();
                }

                String txType = diff > 0 ? "ADJUST_IN" : "ADJUST_OUT";
                String insertTx = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, tx_date, note) VALUES (?, ?, NULL, ?, ?, NULL, NULL, NULL, NULL, ?, GETDATE(), ?)";
                try (var ps = connection.prepareStatement(insertTx)) {
                    ps.setString(1, txType);
                    ps.setInt(2, productId);
                    ps.setInt(3, Math.abs(diff));
                    ps.setInt(4, locationId); // use from_location to indicate where adjustment happened
                    ps.setObject(5, employeeId);
                    ps.setString(6, note);
                    ps.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException ex) {
            try { connection.rollback(); } catch (SQLException e) { /* ignore */ }
            throw ex;
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException e) { /* ignore */ }
        }
    }
}
