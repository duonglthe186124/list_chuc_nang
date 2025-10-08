/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */

import util.DBContext;
import java.sql.*;
import model.Inventory_records;
public class AuditDAO extends DBContext {

    public Inventory_records getByInventoryId(int inventoryId) throws SQLException {
        String sql = "SELECT * FROM Inventory_records WHERE inventory_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, inventoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Inventory_records(rs.getInt("inventory_id"), rs.getInt("product_id"), rs.getInt("location_id"), rs.getInt("qty"), rs.getTimestamp("last_update"));
                }
            }
        }
        return null;
    }

    public void adjustInventory(int inventoryId, int newQty) throws SQLException {
        String sql = "UPDATE Inventory_records SET qty=?, last_update=GETDATE() WHERE inventory_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newQty);
            ps.setInt(2, inventoryId);
            ps.executeUpdate();
        }
    }

    public void insertAuditTransaction(int productId, int locationId, int diff, int employeeId, String note) throws SQLException {
        String txType = diff > 0 ? "ADJUST_IN" : "ADJUST_OUT";
        String sql = "INSERT INTO Inventory_transactions (tx_type, product_id, qty, from_location, to_location, employee_id, tx_date, note) VALUES (?, ?, ?, ?, NULL, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, txType);
            ps.setInt(2, productId);
            ps.setInt(3, Math.abs(diff));
            ps.setInt(4, locationId);
            ps.setInt(5, employeeId);
            ps.setString(6, note);
            ps.executeUpdate();
        }
    }
}