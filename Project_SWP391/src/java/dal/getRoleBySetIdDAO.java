/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.UserToCheckTask;
import util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class getRoleBySetIdDAO extends DBContext {

    public UserToCheckTask getUserById(int userId) throws SQLException {
        String sql = """
            SELECT u.user_id, u.fullname, u.role_id, r.role_name
            FROM Users u
            JOIN Roles r ON u.role_id = r.role_id
            WHERE u.user_id = ? AND u.is_actived = 1
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, userId);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return new UserToCheckTask(
                            rs.getInt("user_id"),
                            rs.getInt("role_id"),
                            rs.getString("fullname"),
                            rs.getString("role_name")
                    );
                }
            }
        }
        return null;
    }

    public List<UserToCheckTask> getAllUsersWithRoles() throws SQLException {
        List<UserToCheckTask> list = new ArrayList<>();
        String sql = """
            SELECT u.user_id, u.fullname, u.role_id, r.role_name
            FROM Users u
            JOIN Roles r ON u.role_id = r.role_id
            WHERE u.is_actived = 1
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                UserToCheckTask u = new UserToCheckTask();
                u.setUserId(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setRoleId(rs.getInt("role_id"));
                u.setRolename(rs.getString("role_name"));
                list.add(u);
            }
        }
        return list;
    }
}
