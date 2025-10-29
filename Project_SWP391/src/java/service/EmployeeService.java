package service;

import dal.EmployeeDAO;
import dal.PositionDAO;
import dal.RoleDAO;
import dto.EmployeeInfoDTO;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class EmployeeService {
    
    private EmployeeDAO employeeDAO;
    private PositionDAO positionDAO;
    private RoleDAO roleDAO;
    
    public EmployeeService() {
        employeeDAO = new EmployeeDAO();
        positionDAO = new PositionDAO();
        roleDAO = new RoleDAO();
    }
    
    // Lấy danh sách tất cả nhân viên
    public List<EmployeeInfoDTO> getAllEmployees() {
        return employeeDAO.getAllEmployees();
    }
    
    // Lấy danh sách nhân viên theo trang
    public List<EmployeeInfoDTO> getEmployeesByPage(int pageIndex, int pageSize) {
        return employeeDAO.getEmployeesByPage(pageIndex, pageSize);
    }
    
    // Lấy tổng số nhân viên
    public int getTotalEmployees() {
        return employeeDAO.getTotalEmployees();
    }
    
    // Tính tổng số trang
    public int getTotalPages(int pageSize) {
        int total = getTotalEmployees();
        return (int) Math.ceil((double) total / pageSize);
    }
    
    // Lấy thông tin chi tiết 1 nhân viên theo ID
    public EmployeeInfoDTO getEmployeeById(int employee_id) {
        return employeeDAO.getEmployeeById(employee_id);
    }
    
    // Thêm nhân viên mới
    public int addEmployee(String email, String password, String fullname, String phone,
                          String address, String sec_address, int role_id, String employee_code,
                          String hire_date, int position_id, String bank_account, Integer boss_id,
                          boolean is_actived) {
        
        // Chuyển đổi hire_date từ String sang Date
        Date sqlDate = null;
        try {
            if (hire_date != null && !hire_date.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(hire_date);
                sqlDate = new Date(utilDate.getTime());
            } else {
                sqlDate = new Date(System.currentTimeMillis()); // Ngày hiện tại nếu không có
            }
        } catch (ParseException e) {
            sqlDate = new Date(System.currentTimeMillis());
        }
        
        return employeeDAO.addEmployee(email, password, fullname, phone, address, sec_address,
                role_id, employee_code, sqlDate, position_id, bank_account, boss_id, is_actived);
    }
    
    // Cập nhật thông tin nhân viên
    public boolean updateEmployee(int employee_id, int user_id, String email, String password,
                                  String fullname, String phone, String address, String sec_address,
                                  int role_id, String employee_code, String hire_date, int position_id,
                                  String bank_account, Integer boss_id, boolean is_actived) {
        
        // Chuyển đổi hire_date từ String sang Date
        Date sqlDate = null;
        try {
            if (hire_date != null && !hire_date.isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date utilDate = sdf.parse(hire_date);
                sqlDate = new Date(utilDate.getTime());
            } else {
                sqlDate = new Date(System.currentTimeMillis());
            }
        } catch (ParseException e) {
            sqlDate = new Date(System.currentTimeMillis());
        }
        
        return employeeDAO.updateEmployee(employee_id, user_id, email, password, fullname, phone,
                address, sec_address, role_id, employee_code, sqlDate, position_id,
                bank_account, boss_id, is_actived);
    }
    
    // Xóa nhân viên
    public boolean deleteEmployee(int employee_id, int user_id) {
        return employeeDAO.deleteEmployee(employee_id, user_id);
    }
    
    // Kiểm tra employee_code đã tồn tại
    public boolean isEmployeeCodeExists(String employee_code, int excludeEmployeeId) {
        return employeeDAO.isEmployeeCodeExists(employee_code, excludeEmployeeId);
    }
    
    // Kiểm tra email đã tồn tại
    public boolean isEmailExists(String email, int excludeUserId) {
        return employeeDAO.isEmailExists(email, excludeUserId);
    }
    
    // Validate employee code format
    public boolean isValidEmployeeCode(String employee_code) {
        return employee_code != null && employee_code.matches("EMP\\d{3}");
    }
    
    // Generate next employee code
    public String generateNextEmployeeCode() {
        List<EmployeeInfoDTO> employees = getAllEmployees();
        if (employees.isEmpty()) {
            return "EMP001";
        }
        
        int maxNum = 0;
        for (EmployeeInfoDTO emp : employees) {
            String code = emp.getEmployee_code();
            if (code != null && code.startsWith("EMP")) {
                try {
                    int num = Integer.parseInt(code.substring(3));
                    if (num > maxNum) {
                        maxNum = num;
                    }
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        }
        
        int nextNum = maxNum + 1;
        return String.format("EMP%03d", nextNum);
    }
}

