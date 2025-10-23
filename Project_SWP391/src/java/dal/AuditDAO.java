/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.AuditDTO;
import java.sql.*;
import java.util.*;
import util.DBContext;

public class AuditDAO extends DBContext {

    public List<AuditDTO> list() {
        List<AuditDTO> list = new ArrayList<>();
        String sql = """
            SELECT a.audit_id, a.event_time, u.fullname, a.event_type, 
                   a.reference_table, a.reference_id, a.monetary_value, a.detail, a.note
            FROM Stock_audit_logs a
            LEFT JOIN Users u ON a.user_id = u.user_id
            ORDER BY a.event_time DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                AuditDTO a = new AuditDTO();
                a.setAudit_id(rs.getLong("audit_id"));
                a.setEvent_time(rs.getTimestamp("event_time"));
                a.setUser_fullname(rs.getString("fullname"));
                a.setEvent_type(rs.getString("event_type"));
                a.setReference_table(rs.getString("reference_table"));
                a.setReference_id(rs.getLong("reference_id"));
                a.setMonetary_value(rs.getBigDecimal("monetary_value"));
                a.setDetail(rs.getString("detail"));
                a.setNote(rs.getString("note"));
                list.add(a);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
