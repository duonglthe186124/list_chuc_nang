/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */

import java.sql.*;
import java.util.*;
import model.Inventory_transactions;
import util.DBContext;

public class FilterDAO extends DBContext {

    public List<Inventory_transactions> filter(String txType, java.util.Date from, java.util.Date to, Integer productId, Integer employeeId) throws SQLException {
        List<Inventory_transactions> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Inventory_transactions WHERE 1=1");
        if (txType != null && !txType.isBlank()) sql.append(" AND tx_type = ?");
        if (from != null) sql.append(" AND tx_date >= ?");
        if (to != null) sql.append(" AND tx_date <= ?");
        if (productId != null) sql.append(" AND product_id = ?");
        if (employeeId != null) sql.append(" AND employee_id = ?");
        sql.append(" ORDER BY tx_date DESC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;
            if (txType != null && !txType.isBlank()) ps.setString(i++, txType);
            if (from != null) ps.setTimestamp(i++, new Timestamp(from.getTime()));
            if (to != null) ps.setTimestamp(i++, new Timestamp(to.getTime()));
            if (productId != null) ps.setInt(i++, productId);
            if (employeeId != null) ps.setInt(i++, employeeId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Inventory_transactions tx = new Inventory_transactions(
                        rs.getInt("tx_id"),
                        rs.getString("tx_type"),
                        rs.getInt("product_id"),
                        rs.getInt("unit_id"),
                        rs.getInt("qty"),
                        rs.getInt("from_location"),
                        rs.getInt("to_location"),
                        rs.getString("ref_code"),
                        rs.getInt("related_inbound_id"),
                        rs.getInt("related_outbound_id"),
                        rs.getInt("employee_id"),
                        rs.getTimestamp("tx_date"),
                        rs.getString("note")
                    );
                    list.add(tx);
                }
            }
        }
        return list;
    }
}
