/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class UserCheckDAOTest {
    public static void main(String[] args) {
        CheckFormDAO db = new CheckFormDAO();
        
        try {
            Integer userId = db.getUserIdByDetails("John Admin", "admin@warehouse.com", "0123456789", "123 Main St");
            System.out.println("Test 1 - Valid data: user_id = " + userId); // Expected: 1
        } catch (SQLException e) {
            System.out.println("Test 1 - Error: " + e.getMessage());
        }
    }
}

