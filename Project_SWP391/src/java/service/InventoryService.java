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
import java.sql.*;
import dal.ProductUnitDAO;

public class InventoryService extends DBContext {
    public InventoryService() { super(); }

    // simplified moveProductAtomic signature used by controllers earlier
    public boolean moveProductAtomic(int productId, int fromLocation, int toLocation, int qty, int unitId, int employeeId, String refCode, String note) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        boolean success = false;
        try {
            connection.setAutoCommit(false);

            String check = "SELECT qty FROM Inventory_records WHERE product_id=? AND location_id=?";
            try (PreparedStatement ps = connection.prepareStatement(check)) {
                ps.setInt(1, productId);
                ps.setInt(2, fromLocation);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next() || rs.getInt("qty") < qty) {
                        connection.rollback();
                        return false;
                    }
                }
            }

            String dec = "UPDATE Inventory_records SET qty = qty - ?, last_updated = GETDATE() WHERE product_id = ? AND location_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(dec)) {
                ps.setInt(1, qty);
                ps.setInt(2, productId);
                ps.setInt(3, fromLocation);
                ps.executeUpdate();
            }

            String selDest = "SELECT inventory_id FROM Inventory_records WHERE product_id = ? AND location_id = ?";
            Integer destId = null;
            try (PreparedStatement ps = connection.prepareStatement(selDest)) {
                ps.setInt(1, productId);
                ps.setInt(2, toLocation);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) destId = rs.getInt("inventory_id");
                }
            }
            if (destId != null) {
                String upd = "UPDATE Inventory_records SET qty = qty + ?, last_updated = GETDATE() WHERE inventory_id = ?";
                try (PreparedStatement ps = connection.prepareStatement(upd)) {
                    ps.setInt(1, qty);
                    ps.setInt(2, destId);
                    ps.executeUpdate();
                }
            } else {
                String ins = "INSERT INTO Inventory_records (product_id, location_id, qty, last_updated) VALUES (?, ?, ?, GETDATE())";
                try (PreparedStatement ps = connection.prepareStatement(ins)) {
                    ps.setInt(1, productId);
                    ps.setInt(2, toLocation);
                    ps.setInt(3, qty);
                    ps.executeUpdate();
                }
            }

            String insTx = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note) VALUES (?, ?, ?, ?, ?, ?, ?, NULL, NULL, ?, GETDATE(), ?)";
            try (PreparedStatement ps = connection.prepareStatement(insTx)) {
                ps.setString(1, "Moving");
                ps.setInt(2, productId);
                ps.setInt(3, unitId);
                ps.setInt(4, qty);
                ps.setInt(5, fromLocation);
                ps.setInt(6, toLocation);
                ps.setString(7, refCode != null ? refCode : "");
                ps.setInt(8, employeeId);
                ps.setString(9, note);
                ps.executeUpdate();
            }

            connection.commit();
            success = true;
        } catch (SQLException ex) {
            try { connection.rollback(); } catch (SQLException ignore) {}
            throw ex;
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException ignore) {}
        }
        return success;
    }

    public void auditAdjustAtomic(int inventoryId, int newQty, int employeeId, String note) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        try {
            connection.setAutoCommit(false);
            String sel = "SELECT product_id, location_id, qty FROM Inventory_records WHERE inventory_id = ?";
            int productId, locationId, oldQty;
            try (PreparedStatement ps = connection.prepareStatement(sel)) {
                ps.setInt(1, inventoryId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        connection.rollback();
                        throw new SQLException("Inventory not found id=" + inventoryId);
                    }
                    productId = rs.getInt("product_id");
                    locationId = rs.getInt("location_id");
                    oldQty = rs.getInt("qty");
                }
            }
            int diff = newQty - oldQty;
            if (diff != 0) {
                String upd = "UPDATE Inventory_records SET qty = ?, last_updated = GETDATE() WHERE inventory_id = ?";
                try (PreparedStatement ps = connection.prepareStatement(upd)) {
                    ps.setInt(1, newQty);
                    ps.setInt(2, inventoryId);
                    ps.executeUpdate();
                }
                String txType = diff > 0 ? "Inbound" : "Outbound";
                int absDiff = Math.abs(diff);
                ProductUnitDAO udao = new ProductUnitDAO();
                int unitId = udao.findFirstUnitIdByProduct(productId);
                if (unitId < 0) unitId = 1;
                String insTx = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note) VALUES (?, ?, ?, ?, ?, ?, ?, NULL, NULL, ?, GETDATE(), ?)";
                try (PreparedStatement ps = connection.prepareStatement(insTx)) {
                    ps.setString(1, txType);
                    ps.setInt(2, productId);
                    ps.setInt(3, unitId);
                    ps.setInt(4, absDiff);
                    ps.setInt(5, locationId);
                    ps.setInt(6, locationId);
                    ps.setInt(7, employeeId);
                    ps.setString(8, note);
                    ps.executeUpdate();
                }
            }
            connection.commit();
        } catch (SQLException ex) {
            try { connection.rollback(); } catch (SQLException ignore) {}
            throw ex;
        } finally {
            try { connection.setAutoCommit(true); } catch (SQLException ignore) {}
        }
    }
}