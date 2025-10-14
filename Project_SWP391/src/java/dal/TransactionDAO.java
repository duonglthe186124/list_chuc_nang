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
import java.sql.Date;

public class TransactionDAO extends DBContext {
    public TransactionDAO() { super(); }

    public List<Inventory_transactions> getAllTransactions() throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Inventory_transactions> list = new ArrayList<>();
        String sql = "SELECT * FROM Inventory_transactions ORDER BY txdate DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapTransaction(rs));
            }
        }
        return list;
    }

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
    public List<Inventory_transactions> filter(String txType, Date from, Date to, Integer productId, Integer employeeId) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Inventory_transactions> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Inventory_transactions WHERE 1=1");
        if (txType != null && !txType.isBlank()) sql.append(" AND tx_type = ?");
        if (from != null) sql.append(" AND txdate >= ?");
        if (to != null) sql.append(" AND txdate <= ?");
        if (productId != null) sql.append(" AND product_id = ?");
        if (employeeId != null) sql.append(" AND employee_id = ?");
        sql.append(" ORDER BY txdate DESC");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            if (txType != null && !txType.isBlank()) ps.setString(idx++, txType);
            if (from != null) ps.setDate(idx++, from);
            if (to != null) ps.setDate(idx++, to);
            if (productId != null) ps.setInt(idx++, productId);
            if (employeeId != null) ps.setInt(idx++, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapTransaction(rs));
            }
        }
        return list;
    }

    private Inventory_transactions mapTransaction(ResultSet rs) throws SQLException {
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
        return tx;
    }

    public void insertTx(String txType, int productId, int unitId, Integer fromLoc, Integer toLoc, int qty, Integer relatedInboundId, Integer relatedOutboundId, int employeeId, String refCode, String note) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        String sql = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, txdate, note) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, txType);
            ps.setInt(2, productId);
            ps.setInt(3, unitId);
            ps.setInt(4, qty);
            if (fromLoc != null) ps.setInt(5, fromLoc); else ps.setNull(5, Types.INTEGER);
            if (toLoc != null) ps.setInt(6, toLoc); else ps.setNull(6, Types.INTEGER);
            ps.setString(7, refCode != null ? refCode : "");
            if (relatedInboundId != null) ps.setInt(8, relatedInboundId); else ps.setNull(8, Types.INTEGER);
            if (relatedOutboundId != null) ps.setInt(9, relatedOutboundId); else ps.setNull(9, Types.INTEGER);
            ps.setInt(10, employeeId);
            ps.setString(11, note);
            ps.executeUpdate();
        }
    }
}
