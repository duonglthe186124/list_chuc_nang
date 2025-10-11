package dal;

import model.Users;
import util.DBContext; // Import DBContext từ package util
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Kế thừa DBContext để sử dụng connection đã được khởi tạo
public class UserDAO extends DBContext {

    /**
     * @public
     * Kiểm tra xem Email đã tồn tại trong DB chưa.
     * @param email Email cần kiểm tra.
     * @return true nếu Email tồn tại.
     */
    public boolean isEmailExist(String email) {
        // Lưu ý: Dùng this.connection vì DBContext của bạn có thuộc tính protected connection
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi UserDAO -> isEmailExist: " + e.getMessage());
        }
        return false;
    }

    /**
     * @public
     * Chèn người dùng mới vào DB.
     * @param user Đối tượng Users chứa thông tin đăng ký.
     * @return true nếu chèn thành công.
     */
    public boolean insertUser(Users user) {
        // user_id, is_actived, is_deleted sẽ tự động được gán giá trị mặc định trong DB
        String sql = "INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());       // Mật khẩu đã băm
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getSec_address());    // Khớp với getter getSec_address()
            ps.setInt(7, user.getRole_id());           // Khớp với getter getRole_id()
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.err.println("Lỗi UserDAO -> insertUser: " + e.getMessage());
            return false;
        }
    }
}