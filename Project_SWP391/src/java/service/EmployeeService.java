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
    // Format: Prefix (2-4 letters) + 3 digits (e.g., HRMA001, IS003, ES001, AD002)
    public boolean isValidEmployeeCode(String employee_code) {
        if (employee_code == null || employee_code.trim().isEmpty()) {
            return false;
        }
        // Pattern: 2-4 uppercase letters followed by 3 digits
        return employee_code.matches("^[A-Z]{2,4}\\d{3}$");
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
    
    // Get role prefix code from role name
    private String getRolePrefix(String roleName) {
        if (roleName == null) {
            return "EMP";
        }
        
        // Map role names to prefixes
        String role = roleName.toUpperCase();
        if (role.contains("HRMANAGER") || role.equals("HR MANAGER")) {
            return "HRMA";
        } else if (role.contains("IMPORTSTAFF") || role.equals("IMPORT STAFF")) {
            return "IS";
        } else if (role.contains("EXPORTSTAFF") || role.equals("EXPORT STAFF")) {
            return "ES";
        } else if (role.contains("ADMIN")) {
            return "AD";
        } else if (role.contains("WAREHOUSESTAFF") || role.equals("WAREHOUSE STAFF")) {
            return "WS";
        } else if (role.contains("QUALITYCONTROL") || role.equals("QUALITY CONTROL") || role.equals("QC")) {
            return "QC";
        } else if (role.contains("ACCOUNTANT")) {
            return "AC";
        } else if (role.contains("MANAGER")) {
            return "MGR";
        } else {
            // Default: take first 2-4 letters from role name
            String cleaned = role.replaceAll("[^A-Z]", "");
            if (cleaned.length() >= 4) {
                return cleaned.substring(0, 4);
            } else if (cleaned.length() >= 2) {
                return cleaned.substring(0, 2);
            } else {
                return "EMP";
            }
        }
    }
    
    // Generate next employee code by role
    public String generateNextEmployeeCodeByRole(String roleName) {
        String prefix = getRolePrefix(roleName);
        List<EmployeeInfoDTO> employees = getAllEmployees();
        
        int maxNum = 0;
        for (EmployeeInfoDTO emp : employees) {
            String code = emp.getEmployee_code();
            if (code != null && code.startsWith(prefix)) {
                try {
                    // Extract number from code (e.g., HRMA001 -> 1, IS003 -> 3)
                    String numStr = code.substring(prefix.length());
                    int num = Integer.parseInt(numStr);
                    if (num > maxNum) {
                        maxNum = num;
                    }
                } catch (NumberFormatException e) {
                    // ignore invalid formats
                }
            }
        }
        
        int nextNum = maxNum + 1;
        return String.format("%s%03d", prefix, nextNum);
    }
    
    // Generate next employee code by role_id
    public String generateNextEmployeeCodeByRoleId(int role_id) {
        String roleName = roleDAO.getRoleNameById(role_id);
        if (roleName == null) {
            return generateNextEmployeeCode();
        }
        return generateNextEmployeeCodeByRole(roleName);
    }
}

