package service;

import dal.AttendanceDAO;
import dal.ShiftAssignmentDAO;
import dto.AttendanceDTO;
import dto.ShiftAssignmentDTO;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class AttendanceService {
    
    private AttendanceDAO attendanceDAO;
    private ShiftAssignmentDAO shiftAssignmentDAO;
    
    public AttendanceService() {
        attendanceDAO = new AttendanceDAO();
        shiftAssignmentDAO = new ShiftAssignmentDAO();
    }
    
    // Lấy tất cả attendances
    public List<AttendanceDTO> getAllAttendances() {
        return attendanceDAO.getAllAttendances();
    }
    
    // Lấy attendances theo employee_id
    public List<AttendanceDTO> getAttendancesByEmployee(int employee_id) {
        return attendanceDAO.getAttendancesByEmployee(employee_id);
    }
    
    // Lấy attendance theo ID
    public AttendanceDTO getAttendanceById(int attendance_id) {
        return attendanceDAO.getAttendanceById(attendance_id);
    }
    
    // Lấy shift assignments cho employee trong ngày hôm nay
    public List<ShiftAssignmentDTO> getTodayAssignments(int employee_id) {
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfDay = cal.getTime();
        
        java.sql.Date sqlDate = new java.sql.Date(startOfDay.getTime());
        
        List<ShiftAssignmentDTO> allAssignments = shiftAssignmentDAO.getAssignmentsByEmployee(employee_id);
        List<ShiftAssignmentDTO> todayAssignments = new java.util.ArrayList<>();
        
        // Filter by today
        for (ShiftAssignmentDTO assign : allAssignments) {
            if (assign.getAssign_date() != null) {
                java.sql.Date assignDate = new java.sql.Date(assign.getAssign_date().getTime());
                if (assignDate.equals(sqlDate)) {
                    todayAssignments.add(assign);
                }
            }
        }
        
        return todayAssignments;
    }
    
    // Check in
    public int checkIn(int assign_id, int employee_id, String note) {
        // Kiểm tra xem đã check in chưa
        AttendanceDTO existing = attendanceDAO.getAttendanceByAssignId(assign_id);
        if (existing != null && existing.getCheck_out() == null) {
            // Đã check in rồi nhưng chưa check out
            return existing.getAttendance_id();
        }
        
        if (existing != null) {
            // Đã có check in và check out rồi
            return -1; // Không thể check in lại
        }
        
        Timestamp checkInTime = new Timestamp(System.currentTimeMillis());
        return attendanceDAO.checkIn(assign_id, employee_id, checkInTime, note);
    }
    
    // Check in cho nhân viên khác (admin dùng)
    public int checkInForEmployee(int assign_id, int employee_id, Timestamp checkInTime, String note) {
        // Kiểm tra xem đã check in chưa
        AttendanceDTO existing = attendanceDAO.getAttendanceByAssignId(assign_id);
        if (existing != null && existing.getCheck_out() == null) {
            // Đã check in rồi nhưng chưa check out
            return existing.getAttendance_id();
        }
        
        if (existing != null) {
            // Đã có check in và check out rồi
            return -1; // Không thể check in lại
        }
        
        if (checkInTime == null) {
            checkInTime = new Timestamp(System.currentTimeMillis());
        }
        
        return attendanceDAO.checkIn(assign_id, employee_id, checkInTime, note);
    }
    
    // Check out
    public boolean checkOut(int attendance_id, String note) {
        AttendanceDTO attendance = attendanceDAO.getAttendanceById(attendance_id);
        if (attendance == null || attendance.getCheck_out() != null) {
            return false; // Đã check out rồi hoặc không tìm thấy
        }
        
        Timestamp checkOutTime = new Timestamp(System.currentTimeMillis());
        Timestamp checkInTime = new Timestamp(attendance.getCheck_in().getTime());
        
        float hoursWorked = attendanceDAO.calculateHoursWorked(checkInTime, checkOutTime);
        
        return attendanceDAO.checkOut(attendance_id, checkOutTime, hoursWorked, note);
    }
    
    // Check out theo assign_id
    public boolean checkOutByAssignId(int assign_id, String note) {
        AttendanceDTO attendance = attendanceDAO.getAttendanceByAssignId(assign_id);
        if (attendance == null || attendance.getCheck_out() != null) {
            return false;
        }
        
        return checkOut(attendance.getAttendance_id(), note);
    }
    
    // Cập nhật attendance
    public boolean updateAttendance(int attendance_id, Timestamp check_in, Timestamp check_out, 
                                    String note) {
        float hoursWorked = 0;
        if (check_in != null && check_out != null) {
            hoursWorked = attendanceDAO.calculateHoursWorked(check_in, check_out);
        }
        
        return attendanceDAO.updateAttendance(attendance_id, check_in, check_out, hoursWorked, note);
    }
    
    // Xóa attendance
    public boolean deleteAttendance(int attendance_id) {
        return attendanceDAO.deleteAttendance(attendance_id);
    }
    
    // Lấy tất cả shift assignments hôm nay (cho admin)
    public List<ShiftAssignmentDTO> getTodayAllAssignments() {
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfDay = cal.getTime();
        
        java.sql.Date sqlDate = new java.sql.Date(startOfDay.getTime());
        
        List<ShiftAssignmentDTO> allAssignments = shiftAssignmentDAO.getAllAssignments();
        List<ShiftAssignmentDTO> todayAssignments = new java.util.ArrayList<>();
        
        // Filter by today
        for (ShiftAssignmentDTO assign : allAssignments) {
            if (assign.getAssign_date() != null) {
                java.sql.Date assignDate = new java.sql.Date(assign.getAssign_date().getTime());
                if (assignDate.equals(sqlDate)) {
                    todayAssignments.add(assign);
                }
            }
        }
        
        return todayAssignments;
    }
    
    // Lấy tất cả attendances hôm nay (cho admin)
    public List<AttendanceDTO> getTodayAllAttendances() {
        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date startOfDay = cal.getTime();
        
        List<AttendanceDTO> allAttendances = attendanceDAO.getAllAttendances();
        List<AttendanceDTO> todayAttendances = new java.util.ArrayList<>();
        
        for (AttendanceDTO att : allAttendances) {
            if (att.getCheck_in() != null) {
                Date checkInDate = new Date(att.getCheck_in().getTime());
                if (checkInDate.after(startOfDay) || checkInDate.equals(startOfDay)) {
                    todayAttendances.add(att);
                }
            }
        }
        
        return todayAttendances;
    }
}

