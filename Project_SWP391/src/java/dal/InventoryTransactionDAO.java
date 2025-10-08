/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */

import dal.DBContext;
import java.sql.*;

public class InventoryTransactionDAO extends DBContext {

    public void insertTx(String txType, int productId, Integer fromLoc, Integer toLoc, int qty, Integer employeeId, String note) throws SQLException {
        String sql = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, tx_date, note) VALUES (?, ?, NULL, ?, ?, ?, NULL, NULL, NULL, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, txType);
            ps.setInt(2, productId);
            ps.setInt(3, qty);
            if (fromLoc != null) ps.setInt(4, fromLoc); else ps.setNull(4, Types.INTEGER);
            if (toLoc != null) ps.setInt(5, toLoc); else ps.setNull(5, Types.INTEGER);
            ps.setObject(6, employeeId, Types.INTEGER);
            ps.setString(7, note);
            ps.executeUpdate();
        }
    }
}