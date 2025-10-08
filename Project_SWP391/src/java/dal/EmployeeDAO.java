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
import model.Employees;

public class EmployeeDAO extends DBContext {

    public List<Employees> listAll() throws SQLException {
        List<Employees> list = new ArrayList<>();
        String sql = "SELECT employee_id, user_id, employee_code, hire_date, position_id, bank_account, boss_id FROM Employees";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Employees e = new Employees(
                    rs.getInt("employee_id"),
                    rs.getInt("user_id"),
                    rs.getString("employee_code"),
                    rs.getTimestamp("hire_date"),
                    rs.getInt("position_id"),
                    rs.getString("bank_account"),
                    rs.getInt("boss_id")
                );
                list.add(e);
            }
        }
        return list;
    }
}