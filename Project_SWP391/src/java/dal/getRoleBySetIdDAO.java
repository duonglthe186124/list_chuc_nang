/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.UserToCheckTask;
import util.DBContext;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class getRoleBySetIdDAO extends DBContext {

    public UserToCheckTask getUserById(int userId) throws SQLException {
        String sql = "SELECT user_id, role_id FROM Users WHERE user_id = ? and is_actived = 1";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, userId);
        ResultSet rs = stm.executeQuery();

        try {
            if (rs.next()) {
                return new UserToCheckTask(rs.getInt("user_id"), rs.getInt("role_id"));
            }
            return null;
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
    }

}
