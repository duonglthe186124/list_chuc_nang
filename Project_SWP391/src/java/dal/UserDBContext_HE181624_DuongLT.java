/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.AuthUser_HE186124_DuongLT;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author hoang
 */
public class UserDBContext_HE181624_DuongLT extends DBContext {

    public AuthUser_HE186124_DuongLT getLogin(String email, String password) {
        try {
            String sql = "SELECT \n"
                    + "    u.user_id, \n"
                    + "    u.fullname, \n"
                    + "    u.email, \n"
                    + "    r.role_id, \n"
                    + "    r.role_name,\n"
                    + "	r.[description]\n"
                    + "FROM Users u\n"
                    + "JOIN Roles r ON u.role_id = r.role_id\n"
                    + "WHERE u.email = ?  AND u.password = ? AND u.is_actived = 1;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, password);

            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                AuthUser_HE186124_DuongLT userLogin = new AuthUser_HE186124_DuongLT();
                userLogin.setUserId(rs.getInt("user_id"));
                userLogin.setFullname(rs.getString("fullname"));
                userLogin.setEmail(rs.getString("email"));
                userLogin.setRoleId(rs.getInt("role_id"));
                userLogin.setRoleName(rs.getString("role_name"));
                userLogin.setDescription_role(rs.getString("description"));

                rs.close();
                stm.close();

                return userLogin;
            }

        } catch (SQLException ex) {
            System.out.println("DB Error: " + ex.getMessage());
        }
        return null;
    }
}
