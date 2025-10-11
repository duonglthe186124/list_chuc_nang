package dal;

import connection.DBContext;
import model.Users; // Sử dụng lớp Users của bạn
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO extends DBContext {

    /**
     * Kiểm tra xem Email đã tồn tại trong DB chưa.
     * @param email Email cần kiểm tra.
     * @return true nếu Email tồn tại.
     */
    public boolean isEmailExist(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi UserDAO -> isEmailExist: " + e.getMessage());
        }
        return false;
    }

    /**
     * Chèn người dùng mới vào DB.
     * @param user Đối tượng Users chứa thông tin đăng ký.
     * @return true nếu chèn thành công.
     */
    public boolean insertUser(Users user) {
        String sql = "INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());       // Mật khẩu đã băm
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getSec_address());     // Khớp với getter getSec_address()
            ps.setInt(7, user.getRole_id());            // Khớp với getter getRole_id()
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            System.err.println("Lỗi UserDAO -> insertUser: " + e.getMessage());
            return false;
        }
    }
}