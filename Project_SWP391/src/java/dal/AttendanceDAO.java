package dal;

import dto.AttendanceDTO;
import model.Attendances;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Timestamp;
import java.sql.Statement;
import util.DBContext;

public class AttendanceDAO extends DBContext {

    // Lấy tất cả attendances kèm thông tin đầy đủ
    public List<AttendanceDTO> getAllAttendances() {
        List<AttendanceDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "a.attendance_id, "
                + "a.assign_id, "
                + "a.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.assign_date, "
                + "a.check_in, "
                + "a.check_out, "
                + "a.hours_worked, "
                + "a.note, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Attendances a "
                + "INNER JOIN Shift_assignments sa ON a.assign_id = sa.assign_id "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON a.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "ORDER BY a.check_in DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AttendanceDTO att = new AttendanceDTO(
                            rs.getInt("attendance_id"),
                            rs.getInt("assign_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getDate("assign_date"),
                            rs.getTimestamp("check_in"),
                            rs.getTimestamp("check_out"),
                            rs.getFloat("hours_worked"),
                            rs.getString("note"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                    list.add(att);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy attendances theo employee_id
    public List<AttendanceDTO> getAttendancesByEmployee(int employee_id) {
        List<AttendanceDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "a.attendance_id, "
                + "a.assign_id, "
                + "a.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.assign_date, "
                + "a.check_in, "
                + "a.check_out, "
                + "a.hours_worked, "
                + "a.note, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Attendances a "
                + "INNER JOIN Shift_assignments sa ON a.assign_id = sa.assign_id "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON a.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE a.employee_id = ? "
                + "ORDER BY a.check_in DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, employee_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AttendanceDTO att = new AttendanceDTO(
                            rs.getInt("attendance_id"),
                            rs.getInt("assign_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getDate("assign_date"),
                            rs.getTimestamp("check_in"),
                            rs.getTimestamp("check_out"),
                            rs.getFloat("hours_worked"),
                            rs.getString("note"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                    list.add(att);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy attendance theo attendance_id
    public AttendanceDTO getAttendanceById(int attendance_id) {
        String sql = "SELECT "
                + "a.attendance_id, "
                + "a.assign_id, "
                + "a.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.assign_date, "
                + "a.check_in, "
                + "a.check_out, "
                + "a.hours_worked, "
                + "a.note, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Attendances a "
                + "INNER JOIN Shift_assignments sa ON a.assign_id = sa.assign_id "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON a.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE a.attendance_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, attendance_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new AttendanceDTO(
                            rs.getInt("attendance_id"),
                            rs.getInt("assign_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getDate("assign_date"),
                            rs.getTimestamp("check_in"),
                            rs.getTimestamp("check_out"),
                            rs.getFloat("hours_worked"),
                            rs.getString("note"),
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

    // Kiểm tra xem đã check in cho assignment này chưa
    public AttendanceDTO getAttendanceByAssignId(int assign_id) {
        String sql = "SELECT "
                + "a.attendance_id, "
                + "a.assign_id, "
                + "a.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.assign_date, "
                + "a.check_in, "
                + "a.check_out, "
                + "a.hours_worked, "
                + "a.note, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Attendances a "
                + "INNER JOIN Shift_assignments sa ON a.assign_id = sa.assign_id "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON a.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE a.assign_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, assign_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new AttendanceDTO(
                            rs.getInt("attendance_id"),
                            rs.getInt("assign_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getDate("assign_date"),
                            rs.getTimestamp("check_in"),
                            rs.getTimestamp("check_out"),
                            rs.getFloat("hours_worked"),
                            rs.getString("note"),
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

    // Check in - tạo attendance mới
    public int checkIn(int assign_id, int employee_id, Timestamp check_in_time, String note) {
        String sql = "INSERT INTO Attendances (assign_id, employee_id, check_in, note) "
                + "VALUES (?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, assign_id);
            ps.setInt(2, employee_id);
            ps.setTimestamp(3, check_in_time);
            ps.setString(4, note);
            
            ps.executeUpdate();
            
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Check out - cập nhật attendance
    public boolean checkOut(int attendance_id, Timestamp check_out_time, float hours_worked, String note) {
        String sql = "UPDATE Attendances SET check_out = ?, hours_worked = ?, note = ? "
                + "WHERE attendance_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, check_out_time);
            ps.setFloat(2, hours_worked);
            ps.setString(3, note);
            ps.setInt(4, attendance_id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật attendance
    public boolean updateAttendance(int attendance_id, Timestamp check_in, Timestamp check_out, 
                                   float hours_worked, String note) {
        String sql = "UPDATE Attendances SET check_in = ?, check_out = ?, hours_worked = ?, note = ? "
                + "WHERE attendance_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, check_in);
            ps.setTimestamp(2, check_out);
            ps.setFloat(3, hours_worked);
            ps.setString(4, note);
            ps.setInt(5, attendance_id);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa attendance
    public boolean deleteAttendance(int attendance_id) {
        String sql = "DELETE FROM Attendances WHERE attendance_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, attendance_id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tính số giờ làm việc
    public float calculateHoursWorked(Timestamp check_in, Timestamp check_out) {
        if (check_in == null || check_out == null) {
            return 0;
        }
        
        long diffInMilliseconds = check_out.getTime() - check_in.getTime();
        float hours = diffInMilliseconds / (1000f * 60f * 60f);
        return Math.round(hours * 100f) / 100f; // Làm tròn 2 chữ số
    }
    
    // Lấy attendances theo khoảng thời gian (startDate đến endDate)
    // Nếu employee_id > 0 thì filter theo employee_id, nếu <= 0 thì lấy tất cả
    public List<AttendanceDTO> getAttendancesByDateRange(java.util.Date startDate, java.util.Date endDate, int employee_id) {
        List<AttendanceDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "a.attendance_id, "
                + "a.assign_id, "
                + "a.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "s.name as shift_name, "
                + "CONVERT(VARCHAR, s.start_time, 108) as start_time, "
                + "CONVERT(VARCHAR, s.end_time, 108) as end_time, "
                + "sa.assign_date, "
                + "a.check_in, "
                + "a.check_out, "
                + "a.hours_worked, "
                + "a.note, "
                + "wl.code as location_code, "
                + "sa.role_in_shift "
                + "FROM Attendances a "
                + "INNER JOIN Shift_assignments sa ON a.assign_id = sa.assign_id "
                + "INNER JOIN Shifts s ON sa.shift_id = s.shift_id "
                + "INNER JOIN Employees e ON a.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "LEFT JOIN Warehouse_locations wl ON sa.location_id = wl.location_id "
                + "WHERE CONVERT(DATE, a.check_in) >= ? AND CONVERT(DATE, a.check_in) <= ?";
        
        if (employee_id > 0) {
            sql += " AND a.employee_id = ?";
        }
        sql += " ORDER BY a.check_in DESC";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            java.sql.Date sqlStartDate = new java.sql.Date(startDate.getTime());
            java.sql.Date sqlEndDate = new java.sql.Date(endDate.getTime());
            ps.setDate(1, sqlStartDate);
            ps.setDate(2, sqlEndDate);
            if (employee_id > 0) {
                ps.setInt(3, employee_id);
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AttendanceDTO att = new AttendanceDTO(
                            rs.getInt("attendance_id"),
                            rs.getInt("assign_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getString("shift_name"),
                            rs.getString("start_time"),
                            rs.getString("end_time"),
                            rs.getDate("assign_date"),
                            rs.getTimestamp("check_in"),
                            rs.getTimestamp("check_out"),
                            rs.getFloat("hours_worked"),
                            rs.getString("note"),
                            rs.getString("location_code"),
                            rs.getString("role_in_shift")
                    );
                    list.add(att);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}


