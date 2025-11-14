package dal;

import dto.EmployeeInfoDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import util.DBContext;

public class EmployeeDAO extends DBContext {

    // Lấy danh sách tất cả nhân viên kèm thông tin chi tiết
    public List<EmployeeInfoDTO> getAllEmployees() {
        return getEmployeesByPage(1, Integer.MAX_VALUE);
    }

    // Lấy danh sách nhân viên theo trang (pagination)
    public List<EmployeeInfoDTO> getEmployeesByPage(int pageIndex, int pageSize) {
        List<EmployeeInfoDTO> list = new ArrayList<>();
        int offset = (pageIndex - 1) * pageSize;
        
        String sql = "SELECT "
                + "e.employee_id, "
                + "e.user_id, "
                + "e.employee_code, "
                + "e.hire_date, "
                + "p.position_name, "
                + "e.bank_account, "
                + "CASE WHEN b.user_id IS NOT NULL THEN u_boss.fullname ELSE 'NULL' END as boss_name, "
                + "u.email, "
                + "u.fullname, "
                + "u.phone, "
                + "u.address, "
                + "u.role_id, "
                + "r.role_name, "
                + "u.is_actived "
                + "FROM Employees e "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "INNER JOIN Positions p ON e.position_id = p.position_id "
                + "LEFT JOIN Roles r ON u.role_id = r.role_id "
                + "LEFT JOIN Employees b ON e.boss_id = b.employee_id "
                + "LEFT JOIN Users u_boss ON b.user_id = u_boss.user_id "
                + "WHERE u.is_deleted = 0 "
                + "ORDER BY e.employee_id DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmployeeInfoDTO emp = new EmployeeInfoDTO(
                            rs.getInt("employee_id"),
                            rs.getInt("user_id"),
                            rs.getString("employee_code"),
                            rs.getDate("hire_date"),
                            rs.getString("position_name"),
                            rs.getString("bank_account"),
                            rs.getString("boss_name"),
                            rs.getString("email"),
                            rs.getString("fullname"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getInt("role_id"),
                            rs.getString("role_name"),
                            rs.getBoolean("is_actived")
                    );
                    list.add(emp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Đếm tổng số nhân viên
    public int getTotalEmployees() {
        String sql = "SELECT COUNT(*) as total "
                + "FROM Employees e "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "WHERE u.is_deleted = 0";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy employee_id từ user_id
    public int getEmployeeIdByUserId(int user_id) {
        String sql = "SELECT employee_id FROM Employees WHERE user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, user_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("employee_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Lấy thông tin chi tiết 1 nhân viên theo ID
    public EmployeeInfoDTO getEmployeeById(int employee_id) {
        String sql = "SELECT "
                + "e.employee_id, "
                + "e.user_id, "
                + "e.employee_code, "
                + "e.hire_date, "
                + "p.position_name, "
                + "e.bank_account, "
                + "CASE WHEN b.user_id IS NOT NULL THEN u_boss.fullname ELSE 'NULL' END as boss_name, "
                + "u.email, "
                + "u.fullname, "
                + "u.phone, "
                + "u.address, "
                + "u.role_id, "
                + "r.role_name, "
                + "u.is_actived "
                + "FROM Employees e "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "INNER JOIN Positions p ON e.position_id = p.position_id "
                + "LEFT JOIN Roles r ON u.role_id = r.role_id "
                + "LEFT JOIN Employees b ON e.boss_id = b.employee_id "
                + "LEFT JOIN Users u_boss ON b.user_id = u_boss.user_id "
                + "WHERE e.employee_id = ? AND u.is_deleted = 0";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employee_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new EmployeeInfoDTO(
                            rs.getInt("employee_id"),
                            rs.getInt("user_id"),
                            rs.getString("employee_code"),
                            rs.getDate("hire_date"),
                            rs.getString("position_name"),
                            rs.getString("bank_account"),
                            rs.getString("boss_name"),
                            rs.getString("email"),
                            rs.getString("fullname"),
                            rs.getString("phone"),
                            rs.getString("address"),
                            rs.getInt("role_id"),
                            rs.getString("role_name"),
                            rs.getBoolean("is_actived")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm nhân viên mới (tạo User trước, sau đó tạo Employee)
    public int addEmployee(String email, String password, String fullname, String phone, 
                          String address, String sec_address, int role_id, String employee_code, 
                          Date hire_date, int position_id, String bank_account, Integer boss_id, 
                          boolean is_actived) {
        try {
            connection.setAutoCommit(false);

            // Bước 1: Insert vào bảng Users
            String sqlUser = "INSERT INTO Users (email, password, fullname, phone, address, sec_address, role_id, is_actived, is_deleted) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)";
            
            PreparedStatement psUser = connection.prepareStatement(sqlUser, Statement.RETURN_GENERATED_KEYS);
            psUser.setString(1, email);
            psUser.setString(2, password);
            psUser.setString(3, fullname);
            psUser.setString(4, phone);
            psUser.setString(5, address);
            psUser.setString(6, sec_address);
            psUser.setInt(7, role_id);
            psUser.setBoolean(8, is_actived);
            
            psUser.executeUpdate();
            
            // Lấy user_id vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            int user_id = 0;
            if (rs.next()) {
                user_id = rs.getInt(1);
            }
            psUser.close();

            // Bước 2: Insert vào bảng Employees
            String sqlEmp = "INSERT INTO Employees (user_id, employee_code, hire_date, position_id, bank_account, boss_id) "
                    + "VALUES (?, ?, ?, ?, ?, ?)";
            
            PreparedStatement psEmp = connection.prepareStatement(sqlEmp, Statement.RETURN_GENERATED_KEYS);
            psEmp.setInt(1, user_id);
            psEmp.setString(2, employee_code);
            psEmp.setDate(3, hire_date);
            psEmp.setInt(4, position_id);
            psEmp.setString(5, bank_account);
            if (boss_id != null) {
                psEmp.setInt(6, boss_id);
            } else {
                psEmp.setNull(6, java.sql.Types.INTEGER);
            }
            
            psEmp.executeUpdate();
            
            // Lấy employee_id vừa tạo
            ResultSet rsEmp = psEmp.getGeneratedKeys();
            int employee_id = 0;
            if (rsEmp.next()) {
                employee_id = rsEmp.getInt(1);
            }
            psEmp.close();

            connection.commit();
            connection.setAutoCommit(true);
            
            return employee_id;

        } catch (SQLException e) {
            try {
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return -1;
        }
    }

    // Cập nhật thông tin nhân viên
    public boolean updateEmployee(int employee_id, int user_id, String email, String password, 
                                  String fullname, String phone, String address, String sec_address, 
                                  int role_id, String employee_code, Date hire_date, int position_id, 
                                  String bank_account, Integer boss_id, boolean is_actived) {
        try {
            connection.setAutoCommit(false);

            // Bước 1: Update bảng Users
            String sqlUser;
            if (password != null && !password.isEmpty()) {
                sqlUser = "UPDATE Users SET email=?, password=?, fullname=?, phone=?, address=?, sec_address=?, role_id=?, is_actived=? WHERE user_id=?";
            } else {
                sqlUser = "UPDATE Users SET email=?, fullname=?, phone=?, address=?, sec_address=?, role_id=?, is_actived=? WHERE user_id=?";
            }
            
            PreparedStatement psUser = connection.prepareStatement(sqlUser);
            int paramIndex = 1;
            psUser.setString(paramIndex++, email);
            if (password != null && !password.isEmpty()) {
                psUser.setString(paramIndex++, password);
            }
            psUser.setString(paramIndex++, fullname);
            psUser.setString(paramIndex++, phone);
            psUser.setString(paramIndex++, address);
            psUser.setString(paramIndex++, sec_address);
            psUser.setInt(paramIndex++, role_id);
            psUser.setBoolean(paramIndex++, is_actived);
            psUser.setInt(paramIndex++, user_id);
            
            psUser.executeUpdate();
            psUser.close();

            // Bước 2: Update bảng Employees
            String sqlEmp = "UPDATE Employees SET employee_code=?, hire_date=?, position_id=?, bank_account=?, boss_id=? WHERE employee_id=?";
            
            PreparedStatement psEmp = connection.prepareStatement(sqlEmp);
            psEmp.setString(1, employee_code);
            psEmp.setDate(2, hire_date);
            psEmp.setInt(3, position_id);
            psEmp.setString(4, bank_account);
            if (boss_id != null) {
                psEmp.setInt(5, boss_id);
            } else {
                psEmp.setNull(5, java.sql.Types.INTEGER);
            }
            psEmp.setInt(6, employee_id);
            
            psEmp.executeUpdate();
            psEmp.close();

            connection.commit();
            connection.setAutoCommit(true);
            
            return true;

        } catch (SQLException e) {
            try {
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        }
    }

    // Xóa (soft delete) nhân viên
    public boolean deleteEmployee(int employee_id, int user_id) {
        try {
            String sql = "UPDATE Users SET is_deleted = 1 WHERE user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, user_id);
            int rowsAffected = ps.executeUpdate();
            ps.close();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Kiểm tra xem employee_code đã tồn tại chưa
    public boolean isEmployeeCodeExists(String employee_code, int excludeEmployeeId) {
        String sql = "SELECT COUNT(*) FROM Employees WHERE employee_code = ? AND employee_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, employee_code);
            ps.setInt(2, excludeEmployeeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Kiểm tra xem email đã tồn tại chưa
    public boolean isEmailExists(String email, int excludeUserId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND user_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, excludeUserId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

