/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class CheckFormDAO extends DBContext{
    public Integer getUserIdByDetails(String fullname, String email, String phone, String address) throws SQLException {
        
        PreparedStatement stm = null; 
        ResultSet rs = null; 
        Integer userId = null; 

        try {
            
            String sql = "SELECT user_id FROM Users " +
                         "WHERE fullname = ? AND email = ? AND phone = ? AND address = ? AND is_actived = 1";
            stm = connection.prepareStatement(sql);

           
            stm.setString(1, fullname);
            stm.setString(2, email);
            stm.setString(3, phone);
            stm.setString(4, address);

            
            rs = stm.executeQuery();

            
            if (rs.next()) {
                userId = rs.getInt("user_id");
            } else {
                
                userId = null;
            }

        } catch (SQLException e) {
            
            throw new SQLException("Error checking user details: " + e.getMessage());
        } finally {
            
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.out.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {
                    System.out.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
        return userId;
    }
    
    
}
