/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.InboundDTO;
import java.sql.*;
import java.util.*;
import util.DBContext;

public class InboundDAO extends DBContext {

    public List<InboundDTO> list() {
        List<InboundDTO> list = new ArrayList<>();
        String sql = """
            SELECT r.receipts_id, r.receipts_no, s.supplier_name, e.employee_code,
                   r.status, r.note, r.received_at
            FROM Receipts r
            JOIN Purchase_orders po ON r.po_id = po.po_id
            JOIN Suppliers s ON po.supplier_id = s.supplier_id
            JOIN Employees e ON r.received_by = e.employee_id
            ORDER BY r.received_at DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InboundDTO i = new InboundDTO();
                i.setReceipts_id(rs.getInt("receipts_id"));
                i.setReceipts_no(rs.getString("receipts_no"));
                i.setSupplier_name(rs.getString("supplier_name"));
                i.setEmployee_code(rs.getString("employee_code"));
                i.setStatus(rs.getString("status"));
                i.setNote(rs.getString("note"));
                i.setReceived_at(rs.getTimestamp("received_at"));
                list.add(i);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
