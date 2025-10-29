package controller;

import dal.EmployeeDAO;
import dal.PositionDAO;
import dal.RoleDAO;
import dto.EmployeeInfoDTO;
import dto.EmployeeFormDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.EmployeeService;

public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;
    private PositionDAO positionDAO;
    private RoleDAO roleDAO;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        employeeService = new EmployeeService();
        positionDAO = new PositionDAO();
        roleDAO = new RoleDAO();
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list"; // Mặc định hiển thị danh sách
        }

        try {
            switch (action) {
                case "list":
                    listEmployees(req, resp);
                    break;
                case "add":
                    showAddForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteEmployee(req, resp);
                    break;
                case "view":
                    viewEmployee(req, resp);
                    break;
                default:
                    listEmployees(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(EmployeeController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/employee_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addEmployee(req, resp);
                    break;
                case "edit":
                    updateEmployee(req, resp);
                    break;
                default:
                    listEmployees(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(EmployeeController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            
            if ("add".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/view/employee_add.jsp").forward(req, resp);
            } else if ("edit".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/view/employee_edit.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/WEB-INF/view/employee_list.jsp").forward(req, resp);
            }
        }
    }

    // Hiển thị danh sách nhân viên
    private void listEmployees(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy tham số trang từ request
        int pageIndex = 1;
        int pageSize = 5; // Mỗi trang 5 nhân viên
        
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                pageIndex = Integer.parseInt(pageParam);
                if (pageIndex < 1) pageIndex = 1;
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }
        
        // Lấy danh sách nhân viên theo trang
        List<EmployeeInfoDTO> employees = employeeService.getEmployeesByPage(pageIndex, pageSize);
        int totalPages = employeeService.getTotalPages(pageSize);
        int totalEmployees = employeeService.getTotalEmployees();
        
        // Gửi dữ liệu sang JSP
        req.setAttribute("employees", employees);
        req.setAttribute("pageIndex", pageIndex);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalEmployees", totalEmployees);
        
        req.getRequestDispatcher("/WEB-INF/view/employee_list.jsp").forward(req, resp);
    }

    // Hiển thị form thêm nhân viên
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách positions và roles để hiển thị trong form
        req.setAttribute("positions", positionDAO.getAllPositions());
        req.setAttribute("roles", roleDAO.getAllRoles());
        
        // Generate employee code
        String nextCode = employeeService.generateNextEmployeeCode();
        req.setAttribute("nextEmployeeCode", nextCode);
        
        // Lấy danh sách nhân viên hiện có để chọn boss
        req.setAttribute("existingEmployees", employeeService.getAllEmployees());
        
        req.getRequestDispatcher("/WEB-INF/view/employee_add.jsp").forward(req, resp);
    }

    // Hiển thị form sửa nhân viên
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int employee_id = Integer.parseInt(req.getParameter("id"));
        EmployeeInfoDTO employee = employeeService.getEmployeeById(employee_id);
        
        if (employee == null) {
            req.setAttribute("errorMessage", "Không tìm thấy nhân viên");
            listEmployees(req, resp);
            return;
        }
        
        req.setAttribute("employee", employee);
        req.setAttribute("positions", positionDAO.getAllPositions());
        req.setAttribute("roles", roleDAO.getAllRoles());
        req.setAttribute("existingEmployees", employeeService.getAllEmployees());
        
        req.getRequestDispatcher("/WEB-INF/view/employee_edit.jsp").forward(req, resp);
    }

    // Thêm nhân viên mới
    private void addEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin từ form
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String sec_address = req.getParameter("sec_address");
        int role_id = Integer.parseInt(req.getParameter("role_id"));
        String employee_code = req.getParameter("employee_code");
        String hire_date = req.getParameter("hire_date");
        int position_id = Integer.parseInt(req.getParameter("position_id"));
        String bank_account = req.getParameter("bank_account");
        String boss_id_param = req.getParameter("boss_id");
        Integer boss_id = null;
        if (boss_id_param != null && !boss_id_param.isEmpty() && !boss_id_param.equals("null")) {
            boss_id = Integer.parseInt(boss_id_param);
        }
        String is_actived_param = req.getParameter("is_actived");
        boolean is_actived = is_actived_param != null && is_actived_param.equals("true");

        // Validate
        String errorMessage = validateEmployee(email, password, employee_code, -1, -1);
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            showAddForm(req, resp);
            return;
        }

        // Thêm nhân viên
        int employee_id = employeeService.addEmployee(email, password, fullname, phone, address,
                sec_address, role_id, employee_code, hire_date, position_id, bank_account,
                boss_id, is_actived);

        if (employee_id > 0) {
            req.setAttribute("successMessage", "Thêm nhân viên thành công!");
        } else {
            req.setAttribute("errorMessage", "Thêm nhân viên thất bại!");
        }

        listEmployees(req, resp);
    }

    // Cập nhật thông tin nhân viên
    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int employee_id = Integer.parseInt(req.getParameter("employee_id"));
        int user_id = Integer.parseInt(req.getParameter("user_id"));
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String sec_address = req.getParameter("sec_address");
        int role_id = Integer.parseInt(req.getParameter("role_id"));
        String employee_code = req.getParameter("employee_code");
        String hire_date = req.getParameter("hire_date");
        int position_id = Integer.parseInt(req.getParameter("position_id"));
        String bank_account = req.getParameter("bank_account");
        String boss_id_param = req.getParameter("boss_id");
        Integer boss_id = null;
        if (boss_id_param != null && !boss_id_param.isEmpty() && !boss_id_param.equals("null")) {
            boss_id = Integer.parseInt(boss_id_param);
        }
        String is_actived_param = req.getParameter("is_actived");
        boolean is_actived = is_actived_param != null && is_actived_param.equals("true");

        // Validate (bỏ qua password vì có thể để trống khi sửa)
        String errorMessage = validateEmployeeForEdit(email, employee_code, employee_id, user_id);
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            showEditForm(req, resp);
            return;
        }

        // Cập nhật
        boolean success = employeeService.updateEmployee(employee_id, user_id, email, password,
                fullname, phone, address, sec_address, role_id, employee_code, hire_date,
                position_id, bank_account, boss_id, is_actived);

        if (success) {
            req.setAttribute("successMessage", "Cập nhật nhân viên thành công!");
        } else {
            req.setAttribute("errorMessage", "Cập nhật nhân viên thất bại!");
        }

        listEmployees(req, resp);
    }

    // Xóa nhân viên
    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int employee_id = Integer.parseInt(req.getParameter("id"));
        EmployeeInfoDTO employee = employeeService.getEmployeeById(employee_id);
        
        if (employee == null) {
            req.setAttribute("errorMessage", "Không tìm thấy nhân viên");
        } else {
            boolean success = employeeService.deleteEmployee(employee_id, employee.getUser_id());
            if (success) {
                req.setAttribute("successMessage", "Xóa nhân viên thành công!");
            } else {
                req.setAttribute("errorMessage", "Xóa nhân viên thất bại!");
            }
        }
        
        listEmployees(req, resp);
    }

    // Xem chi tiết nhân viên
    private void viewEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int employee_id = Integer.parseInt(req.getParameter("id"));
        EmployeeInfoDTO employee = employeeService.getEmployeeById(employee_id);
        
        if (employee == null) {
            req.setAttribute("errorMessage", "Không tìm thấy nhân viên");
            listEmployees(req, resp);
            return;
        }
        
        req.setAttribute("employee", employee);
        req.getRequestDispatcher("/WEB-INF/view/employee_view.jsp").forward(req, resp);
    }

    // Validate input
    private String validateEmployee(String email, String password, String employee_code, 
                                    int employee_id, int user_id) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        
        if (password == null || password.trim().isEmpty()) {
            return "Mật khẩu không được để trống";
        }
        
        if (employee_code == null || employee_code.trim().isEmpty()) {
            return "Mã nhân viên không được để trống";
        }
        
        // Kiểm tra email đã tồn tại chưa
        if (employee_id == -1) {
            // Thêm mới: kiểm tra email có tồn tại không
            if (employeeDAO.isEmailExists(email, 0)) {
                return "Email đã tồn tại";
            }
        } else {
            // Sửa: kiểm tra email có trùng với email khác không
            if (employeeDAO.isEmailExists(email, user_id)) {
                return "Email đã tồn tại";
            }
        }
        
        // Kiểm tra employee_code đã tồn tại chưa
        if (employee_id == -1) {
            // Thêm mới: kiểm tra mã có tồn tại không
            if (employeeDAO.isEmployeeCodeExists(employee_code, 0)) {
                return "Mã nhân viên đã tồn tại";
            }
        } else {
            // Sửa: kiểm tra mã có trùng với mã khác không
            if (employeeDAO.isEmployeeCodeExists(employee_code, employee_id)) {
                return "Mã nhân viên đã tồn tại";
            }
        }
        
        return null;
    }

    // Validate cho chức năng sửa (không bắt buộc password)
    private String validateEmployeeForEdit(String email, String employee_code, 
                                           int employee_id, int user_id) {
        if (email == null || email.trim().isEmpty()) {
            return "Email không được để trống";
        }
        
        if (employee_code == null || employee_code.trim().isEmpty()) {
            return "Mã nhân viên không được để trống";
        }
        
        // Kiểm tra email đã tồn tại chưa
        if (employeeDAO.isEmailExists(email, user_id)) {
            return "Email đã tồn tại";
        }
        
        // Kiểm tra employee_code đã tồn tại chưa
        if (employeeDAO.isEmployeeCodeExists(employee_code, employee_id)) {
            return "Mã nhân viên đã tồn tại";
        }
        
        return null;
    }
}

