package dal;

import model.Users;
import util.DBContext; 
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.ArrayList;
import java.util.List;
import model.Roles;
import java.sql.Timestamp;
import java.util.Random;

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
            // Sử dụng Base64 thay vì DatatypeConverter
            return Base64.getEncoder().encodeToString(digest);
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
            ps.setInt(7, user.getRole_id()); 
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
                Users user = new Users();
                user.setUser_id(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullname(rs.getString("fullname"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setSec_address(rs.getString("sec_address"));
                user.setRole_id(rs.getInt("role_id"));
                user.setIs_actived(rs.getBoolean("is_actived"));
                user.setIs_deleted(rs.getBoolean("is_deleted"));
                user.setAvatar_url(rs.getString("avatar_url"));
                
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Login check error: " + e.getMessage());
        }
        
        return null; 
    }
    
    public Users findUserWithRoleByEmail(String email) {
        // Sửa SQL: JOIN với bảng Roles để lấy role_name
        String sql = "SELECT u.*, r.role_name " +
                     "FROM Users u " +
                     "LEFT JOIN Roles r ON u.role_id = r.role_id " +
                     "WHERE u.email = ? AND u.is_deleted = 0";
        try {
            // Giả sử 'connection' đã được khởi tạo từ DBContext
            PreparedStatement ps = connection.prepareStatement(sql);

            // Sửa tham số: Chỉ cần set email
            ps.setString(1, email); 

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Users user = new Users();
                // Lấy tất cả thông tin user (quan trọng)
                user.setUser_id(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole_id(rs.getInt("role_id"));
                user.setAvatar_url(rs.getString("avatar_url"));

                // Đây là thông tin mới quan trọng
                user.setRoleName(rs.getString("role_name")); 

                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Bạn nên có một khối 'finally' ở đây để đóng 'ps' và 'rs'
        // (Giống như code tôi đã gửi ở tin nhắn trước)

        return null; // Không tìm thấy
    }
    
    public Users findUserByResetToken(String token) {
        String sql = "SELECT * FROM Users WHERE reset_token = ? AND is_deleted = 0";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users user = new Users();
                user.setUser_id(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
                user.setToken_expiry(rs.getTimestamp("token_expiry"));
                user.setReset_token(rs.getString("reset_token"));
                return user;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
    
    public boolean saveResetToken(String email, String token, Timestamp expiryDate) {
        String sql = "UPDATE Users SET reset_token = ?, token_expiry = ? WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, token);
            ps.setTimestamp(2, expiryDate);
            ps.setString(3, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
    
    public boolean updatePasswordByEmail(String email, String newPassword) {
        String hashedPassword = hashPassword(newPassword); 
        String sql = "UPDATE Users SET password = ?, reset_token = NULL, token_expiry = NULL WHERE email = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateUser(Users user) {
        String sql = "UPDATE Users SET fullname = ?, phone = ?, address = ?, avatar_url = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            
            // 2. Gán các giá trị
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getAddress());
            
            // 3. BẮT BUỘC phải gán giá trị cho avatar_url
            ps.setString(4, user.getAvatar_url()); 
            
            ps.setInt(5, user.getUser_id());
            
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

    public boolean updatePassword(int userId, String newPassword) {
        String hashedPassword = hashPassword(newPassword);
        String sql = "UPDATE Users SET password = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Users> getAllUsers() {
        List<Users> userList = new ArrayList<>();
        // Lấy cả role_name từ bảng Roles
        String sql = "SELECT u.*, r.role_name FROM Users u LEFT JOIN Roles r ON u.role_id = r.role_id";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Users user = new Users();
                user.setUser_id(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setFullname(rs.getString("fullname"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole_id(rs.getInt("role_id"));
                user.setIs_actived(rs.getBoolean("is_actived"));
                user.setIs_deleted(rs.getBoolean("is_deleted"));
                user.setAvatar_url(rs.getString("avatar_url"));
                user.setRoleName(rs.getString("role_name")); 
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }


    /**
     * Cập nhật vai trò của người dùng.
     */
    public boolean updateUserRole(int userId, int roleId) {
        String sql = "UPDATE Users SET role_id = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, roleId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Vô hiệu hóa (disable) hoặc Kích hoạt (enable) tài khoản.
     */
    public boolean setUserActiveStatus(int userId, boolean isActive) {
        String sql = "UPDATE Users SET is_actived = ? WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, isActive);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xóa vĩnh viễn người dùng.
     */
    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    public List<Roles> getAllRoles() {
        List<Roles> roleList = new ArrayList<>();
        String sql = "SELECT * FROM Roles";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Roles role = new Roles();
                role.setRole_id(rs.getInt("role_id"));
                role.setRole_name(rs.getString("role_name"));
                role.setDescription(rs.getString("description"));
                roleList.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return roleList;
    }
    
    public boolean check_role(int role_id, int feature_id) {
        boolean check = false;
        String sql = "SELECT * FROM Feature_role WHERE role_id = ? and feature_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, role_id);
            ps.setInt(2, feature_id);

            try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return true;
            }
        }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return check;
    }
    
//    public List<Roles> getManageableRoles() {
//        List<Roles> roleList = new ArrayList<>();
//        // Lấy các vai trò bạn muốn admin có thể gán
//        String sql = "SELECT * FROM Roles WHERE role_name IN ('Admin', 'Employee', 'Guest')"; 
//        try {
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Roles role = new Roles();
//                role.setRole_id(rs.getInt("role_id"));
//                role.setRole_name(rs.getString("role_name"));
//                roleList.add(role);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return roleList;
//    }
    
    
    public boolean isPhoneTaken(String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE phone = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu (COUNT(*) > 0)
            }
        } catch (SQLException e) {
            System.out.println("Error checking phone: " + e.getMessage());
        }
        return false;
    }
    
    public boolean verifyResetCode(String email, String resetCode) {
        // SỬA SQL: Đổi GETDATE() thành ?
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND reset_token = ? AND token_expiry > ?";

        java.sql.PreparedStatement ps = null;
        java.sql.ResultSet rs = null;

        try {
            // Dùng 'connection' được kế thừa
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, resetCode);

            // SỬA LOGIC: Gửi thời gian HIỆN TẠI của Java vào câu SQL
            ps.setTimestamp(3, new java.sql.Timestamp(System.currentTimeMillis()));

            rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Trả về true nếu (COUNT(*) > 0)
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Chỉ đóng ps và rs
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false; // Mặc định là false
    }
    
    public boolean createStaffAccount(String fullname, String email, int roleId) {

        // 1. Mật khẩu mặc định
        String defaultPassword = "@Abcde12345";

        // 2. Hash mật khẩu 
        String hashedPassword = hashPassword(defaultPassword);
        if (hashedPassword == null) {
            System.out.println("Error: Hashing default password failed.");
            return false; 
        }

        // 3. Câu lệnh SQL
        String sql = "INSERT INTO [Users] " +
                     "(email, password, fullname, phone, address, role_id, is_actived, is_deleted) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 1, 0)"; // Mặc định: is_actived=1, is_deleted=0

        java.sql.PreparedStatement ps = null;
        try {
            ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, hashedPassword); // Mật khẩu đã hash
            ps.setString(3, fullname);

            // Cung cấp giá trị mặc định cho các cột NOT NULL
            ps.setString(4, "N/A"); // Default Phone
            ps.setString(5, "N/A"); // Default Address

            ps.setInt(6, roleId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error creating staff account: " + e.getMessage());
            return false;
        } finally {
            // Chỉ đóng ps (không đóng connection)
            try {
                if (ps != null) ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}