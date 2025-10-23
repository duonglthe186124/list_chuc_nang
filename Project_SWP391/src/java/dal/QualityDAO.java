/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.QualityDTO;
import java.sql.*;
import java.util.*;
import util.DBContext;

public class QualityDAO extends DBContext {

    public List<QualityDTO> list() {
        List<QualityDTO> list = new ArrayList<>();
        String sql = """
            SELECT q.inspection_id, q.inspection_no, e.employee_code, 
                   u.fullname, q.status, q.result, q.note, q.inspected_at, l.code AS location_code
            FROM Quality_Inspections q
            LEFT JOIN Employees e ON q.inspected_by = e.employee_id
            LEFT JOIN Users u ON e.user_id = u.user_id
            LEFT JOIN Warehouse_locations l ON q.location_id = l.location_id
            ORDER BY q.inspected_at DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                QualityDTO q = new QualityDTO();
                q.setInspection_id(rs.getInt("inspection_id"));
                q.setInspection_no(rs.getString("inspection_no"));
                q.setEmployee_code(rs.getString("employee_code"));
                q.setFullname(rs.getString("fullname"));
                q.setStatus(rs.getString("status"));
                q.setResult(rs.getString("result"));
                q.setNote(rs.getString("note"));
                q.setInspected_at(rs.getTimestamp("inspected_at"));
                q.setLocation_code(rs.getString("location_code"));
                list.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
