package dal;

import model.Users;
import util.DBContext; 
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.xml.bind.DatatypeConverter;

public class UserDAO extends DBContext {

    public boolean checkEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println("Error checking email: " + e.getMessage());
        }
        return false;
    }


    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes());
            byte[] digest = md.digest();
            return DatatypeConverter.printHexBinary(digest).toUpperCase();
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error hashing password: " + e.getMessage());
            return null;
        }
    }

    /**
     * Adds a new user to the database.
     * @param user The Users object containing the new user's information.
     * @return true if the user was added successfully, false otherwise.
     */
    public boolean addUser(Users user) {
        String hashedPassword = hashPassword(user.getPassword());
        if (hashedPassword == null) {
            return false; // Hashing failed
        }

        String sql = "INSERT INTO [Users] (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, hashedPassword); 
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getSec_address());
            ps.setInt(7, 3); 
            ps.setBoolean(8, true); 
            ps.setBoolean(9, false); 

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error adding user: " + e.getMessage());
            return false;
        }
    }
    
    public Users checkLogin(String email, String password) {
        String hashedPassword = hashPassword(password);
        if (hashedPassword == null) {
            return null;
        }
        
        String sql = "SELECT * FROM Users WHERE email = ? AND password = ? AND is_actived = 1 AND is_deleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                Users user = new Users(
                    rs.getInt("user_id"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("fullname"),
                    rs.getString("phone"),
                    rs.getString("address"),
                    rs.getString("sec_address"),
                    rs.getInt("role_id"),
                    rs.getBoolean("is_actived"),
                    rs.getBoolean("is_deleted")
                );
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Login check error: " + e.getMessage());
        }
        
        return null; 
    }
    
    public Users findUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Users();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    
    
    
    public void updatePassword(String email, String newPassword) {
        String hashedPassword = hashPassword(newPassword);
        String sql = "UPDATE Users SET password = ?, reset_token = NULL, token_expiry = NULL WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public boolean updateUser(Users user) {
        String sql = "UPDATE Users SET fullname = ?, phone = ?, address = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            ps.setInt(4, user.getUser_id());
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; 
            
        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean verifyOldPassword(int userId, String oldPassword) {
        String hashedPassword = hashPassword(oldPassword); 
        String sql = "SELECT password FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return storedPassword.equals(hashedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updatePassword(int userId, String newPassword) {
        String hashedPassword = hashPassword(newPassword);
        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}