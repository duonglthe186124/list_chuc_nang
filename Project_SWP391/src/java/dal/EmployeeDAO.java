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
    public EmployeeDAO() { super(); }

    public List<Employees> getAllEmployees() throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Employees> list = new ArrayList<>();
        String sql = "SELECT e.employee_id, e.user_id, e.employee_code, e.hire_date, e.position_id, e.bank_account, e.boss_id FROM Employees e";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Employees e = new Employees();
                e.setEmployee_id(rs.getInt("employee_id"));
                e.setUser_id(rs.getInt("user_id"));
                e.setEmployee_code(rs.getString("employee_code"));
                e.setHire_date(rs.getTimestamp("hire_date"));
                e.setPosition_id(rs.getInt("position_id"));
                e.setBank_account(rs.getString("bank_account"));
                e.setBoss_id(rs.getInt("boss_id"));
                list.add(e);
            }
        }
        return list;
    }
}