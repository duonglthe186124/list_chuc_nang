package service;

import dal.ShiftAssignmentDAO;
import dal.ShiftDAO;
import dal.WarehouseLocationDAO;
import dto.ShiftAssignmentDTO;
import model.Shifts;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class ShiftService {
    
    private ShiftDAO shiftDAO;
    private ShiftAssignmentDAO assignmentDAO;
    private WarehouseLocationDAO locationDAO;
    
    public ShiftService() {
        shiftDAO = new ShiftDAO();
        assignmentDAO = new ShiftAssignmentDAO();
        locationDAO = new WarehouseLocationDAO();
    }
    
    // Lấy tất cả ca làm việc
    public List<Shifts> getAllShifts() {
        return shiftDAO.getAllShifts();
    }
    
    // Lấy tất cả assignments
    public List<ShiftAssignmentDTO> getAllAssignments() {
        return assignmentDAO.getAllAssignments();
    }
    
    // Lấy assignments theo employee
    public List<ShiftAssignmentDTO> getAssignmentsByEmployee(int employee_id) {
        return assignmentDAO.getAssignmentsByEmployee(employee_id);
    }
    
    // Thêm assignment mới
    public int addAssignment(int shift_id, int employee_id, String assign_date, 
                            Integer location_id, String role_in_shift) {
        Date sqlDate = parseDate(assign_date);
        if (sqlDate == null) return -1;
        
        return assignmentDAO.addAssignment(shift_id, employee_id, sqlDate, location_id, role_in_shift);
    }
    
    // Cập nhật assignment
    public boolean updateAssignment(int assign_id, int shift_id, int employee_id, String assign_date,
                                    Integer location_id, String role_in_shift) {
        Date sqlDate = parseDate(assign_date);
        if (sqlDate == null) return false;
        
        return assignmentDAO.updateAssignment(assign_id, shift_id, employee_id, sqlDate, location_id, role_in_shift);
    }
    
    // Xóa assignment
    public boolean deleteAssignment(int assign_id) {
        return assignmentDAO.deleteAssignment(assign_id);
    }
    
    // Lấy assignment theo ID
    public ShiftAssignmentDTO getAssignmentById(int assign_id) {
        return assignmentDAO.getAssignmentById(assign_id);
    }
    
    // Kiểm tra employee đã có ca trong ngày
    public boolean hasAssignmentOnDate(int employee_id, String assign_date) {
        Date sqlDate = parseDate(assign_date);
        if (sqlDate == null) return false;
        
        return assignmentDAO.hasAssignmentOnDate(employee_id, sqlDate);
    }
    
    // Parse date từ String sang SQL Date
    private Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return new Date(System.currentTimeMillis());
        }
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(dateStr);
            return new Date(utilDate.getTime());
        } catch (ParseException e) {
            return new Date(System.currentTimeMillis());
        }
    }
}

