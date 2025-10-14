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
import model.Inventory_transactions;
import java.util.Date;

public class FilterDAO extends DBContext {
    public FilterDAO() { super(); }

    /**
     *
     * @param txType
     * @param from
     * @param to
     * @param productId
     * @param employeeId
     * @return
     * @throws SQLException
     */
    public List<Inventory_transactions> filterTransactions(String txType, Date from, Date to, Integer productId, Integer employeeId) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Inventory_transactions> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT tx_id, tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note FROM Inventory_transactions WHERE 1=1");
        if (txType != null && !txType.isBlank()) sql.append(" AND tx_type = ?");
        if (from != null) sql.append(" AND txdate >= ?");
        if (to != null) sql.append(" AND txdate <= ?");
        if (productId != null) sql.append(" AND product_id = ?");
        if (employeeId != null) sql.append(" AND employee_id = ?");
        sql.append(" ORDER BY txdate DESC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int i = 1;
            if (txType != null && !txType.isBlank()) ps.setString(i++, txType);
            if (from != null) ps.setTimestamp(i++, new Timestamp(from.getTime()));
            if (to != null) ps.setTimestamp(i++, new Timestamp(to.getTime()));
            if (productId != null) ps.setInt(i++, productId);
            if (employeeId != null) ps.setInt(i++, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Inventory_transactions tx = new Inventory_transactions();
                    tx.setTx_id(rs.getInt("tx_id"));
                    tx.setTx_type(rs.getString("tx_type"));
                    tx.setProduct_id(rs.getInt("product_id"));
                    tx.setUnit_id(rs.getInt("unit_id"));
                    tx.setQty(rs.getInt("qty"));
                    tx.setFrom_location(rs.getInt("from_location"));
                    tx.setTo_location(rs.getInt("to_location"));
                    tx.setRef_code(rs.getString("ref_code"));
                    tx.setRelated_inbound_id(rs.getInt("related_inbound_id"));
                    tx.setRelated_outbound_id(rs.getInt("related_outbound_id"));
                    tx.setEmployee_id(rs.getInt("employee_id"));
                    tx.setTx_date(rs.getTimestamp("txdate"));
                    tx.setNote(rs.getString("note"));
                    list.add(tx);
                }
            }
        }
        return list;
    }
}