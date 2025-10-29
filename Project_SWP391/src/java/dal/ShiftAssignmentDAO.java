package dal;

import dto.ShiftAssignmentDTO;
import model.Shift_assignments;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import util.DBContext;

public class ShiftAssignmentDAO extends DBContext {

    // Lấy tất cả assignments kèm thông tin đầy đủ
    public List<ShiftAssignmentDTO> getAllAssignments() {
        List<ShiftAssignmentDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "sa.assign_id, "
                + "sa.shift_id, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "sa.assign_date, "
                + "sa.location_id, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Shift_assignments sa "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON sa.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "ORDER BY sa.assign_date DESC, s.start_time";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftAssignmentDTO assign = new ShiftAssignmentDTO(
                            rs.getInt("assign_id"),
                            rs.getInt("shift_id"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getDate("assign_date"),
                            rs.getInt("location_id"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                    list.add(assign);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy assignments theo employee_id
    public List<ShiftAssignmentDTO> getAssignmentsByEmployee(int employee_id) {
        List<ShiftAssignmentDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "sa.assign_id, "
                + "sa.shift_id, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "sa.assign_date, "
                + "sa.location_id, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Shift_assignments sa "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON sa.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE sa.employee_id = ? "
                + "ORDER BY sa.assign_date DESC, s.start_time";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employee_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ShiftAssignmentDTO assign = new ShiftAssignmentDTO(
                            rs.getInt("assign_id"),
                            rs.getInt("shift_id"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getDate("assign_date"),
                            rs.getInt("location_id"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                    list.add(assign);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm assignment mới
    public int addAssignment(int shift_id, int employee_id, Date assign_date, Integer location_id, String role_in_shift) {
        String sql = "INSERT INTO Shift_assignments (shift_id, employee_id, assign_date, location_id, role_in_shift) "
                + "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, shift_id);
            ps.setInt(2, employee_id);
            ps.setDate(3, assign_date);
            if (location_id != null) {
                ps.setInt(4, location_id);
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setString(5, role_in_shift);
            
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Cập nhật assignment
    public boolean updateAssignment(int assign_id, int shift_id, int employee_id, Date assign_date, 
                                    Integer location_id, String role_in_shift) {
        String sql = "UPDATE Shift_assignments SET shift_id=?, employee_id=?, assign_date=?, "
                + "location_id=?, role_in_shift=? WHERE assign_id=?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shift_id);
            ps.setInt(2, employee_id);
            ps.setDate(3, assign_date);
            if (location_id != null) {
                ps.setInt(4, location_id);
            } else {
                ps.setNull(4, java.sql.Types.INTEGER);
            }
            ps.setString(5, role_in_shift);
            ps.setInt(6, assign_id);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa assignment
    public boolean deleteAssignment(int assign_id) {
        String sql = "DELETE FROM Shift_assignments WHERE assign_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assign_id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy assignment theo ID
    public ShiftAssignmentDTO getAssignmentById(int assign_id) {
        String sql = "SELECT "
                + "sa.assign_id, "
                + "sa.shift_id, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "sa.assign_date, "
                + "sa.location_id, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Shift_assignments sa "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON sa.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE sa.assign_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assign_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new ShiftAssignmentDTO(
                            rs.getInt("assign_id"),
                            rs.getInt("shift_id"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getDate("assign_date"),
                            rs.getInt("location_id"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Kiểm tra xem employee đã có ca trong ngày đó chưa
    public boolean hasAssignmentOnDate(int employee_id, Date assign_date) {
        String sql = "SELECT COUNT(*) as count FROM Shift_assignments "
                + "WHERE employee_id = ? AND assign_date = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employee_id);
            ps.setDate(2, assign_date);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count") > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

