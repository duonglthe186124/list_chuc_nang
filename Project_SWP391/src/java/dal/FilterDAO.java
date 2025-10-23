/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.FilterDTO;
import java.sql.*;
import java.util.*;
import util.DBContext;

public class FilterDAO extends DBContext {

    public List<FilterDTO> filter(String employee, String type) {
        List<FilterDTO> list = new ArrayList<>();
        String sql = """
            SELECT TOP 100 t.tx_id, t.tx_type, p.name AS product_name, e.employee_code, 
                   u.fullname, t.tx_date
            FROM Inventory_transactions t
            JOIN Products p ON t.product_id = p.product_id
            JOIN Employees e ON t.employee_id = e.employee_id
            JOIN Users u ON e.user_id = u.user_id
            WHERE ( ? IS NULL OR e.employee_code = ? )
              AND ( ? IS NULL OR t.tx_type = ? )
            ORDER BY t.tx_date DESC
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, employee);
            ps.setString(2, employee);
            ps.setString(3, type);
            ps.setString(4, type);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    FilterDTO f = new FilterDTO();
                    f.setTx_id(rs.getInt("tx_id"));
                    f.setTx_type(rs.getString("tx_type"));
                    f.setProduct_name(rs.getString("product_name"));
                    f.setEmployee_code(rs.getString("employee_code"));
                    f.setFullname(rs.getString("fullname"));
                    f.setTx_date(rs.getTimestamp("tx_date"));
                    list.add(f);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
