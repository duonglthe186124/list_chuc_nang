package dal;

import model.Users;
import util.DBContext; // Import your DBContext from the util package
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.xml.bind.DatatypeConverter;

public class UserDAO extends DBContext {

    /**
     * Checks if an email already exists in the database.
     * @param email The email to check.
     * @return true if the email exists, false otherwise.
     */
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

    /**
     * Hashes an input string using the SHA-256 algorithm.
     * @param password The original password.
     * @return The hashed string, or null if an error occurs.
     */
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
}