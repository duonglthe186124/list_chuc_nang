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
import model.Quality_controls;

public class QualityDAO extends DBContext {
    public QualityDAO() { super(); }

    public List<Quality_controls> getAllQC() throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Quality_controls> list = new ArrayList<>();
        String sql = "SELECT qc_id, unit_id, inbound_line_id, inspector_id, qc_date, state, error, remarks FROM Quality_controls ORDER BY qc_date DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Quality_controls qc = new Quality_controls(
                    rs.getInt("qc_id"),
                    rs.getInt("unit_id"),
                    rs.getInt("inbound_line_id"),
                    rs.getInt("inspector_id"),
                    rs.getTimestamp("qc_date"),
                    rs.getString("state"),
                    rs.getString("error"),
                    rs.getString("remarks")
                );
                list.add(qc);
            }
        }
        return list;
    }

    public void insertQualityControl(Integer unitId, Integer inboundLineId, int inspectorId, String state, String error, String remarks) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        String sql = "INSERT INTO Quality_controls (unit_id, inbound_line_id, inspector_id, qc_date, state, error, remarks) VALUES (?, ?, ?, GETDATE(), ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (unitId != null) ps.setInt(1, unitId); else ps.setNull(1, Types.INTEGER);
            if (inboundLineId != null) ps.setInt(2, inboundLineId); else ps.setNull(2, Types.INTEGER);
            ps.setInt(3, inspectorId);
            ps.setString(4, state);
            ps.setString(5, error);
            ps.setString(6, remarks);
            ps.executeUpdate();
        }
    }
}