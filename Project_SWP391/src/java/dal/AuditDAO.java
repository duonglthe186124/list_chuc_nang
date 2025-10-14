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
import java.util.*;
import model.Inventory_records;

public class AuditDAO extends DBContext {
    public AuditDAO() { super(); }

    public List<Inventory_records> getAllAudit() throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Inventory_records> list = new ArrayList<>();
        String sql = "SELECT inventory_id, product_id, location_id, qty, last_updated FROM Inventory_records ORDER BY last_updated DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Inventory_records r = new Inventory_records(
                    rs.getInt("inventory_id"),
                    rs.getInt("product_id"),
                    rs.getInt("location_id"),
                    rs.getInt("qty"),
                    rs.getTimestamp("last_updated")
                );
                list.add(r);
            }
        }
        return list;
    }
}