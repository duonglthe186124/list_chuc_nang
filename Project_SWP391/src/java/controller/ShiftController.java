package controller;

import dal.EmployeeDAO;
import dal.ShiftDAO;
import dal.ShiftAssignmentDAO;
import dal.UserDAO;
import dal.WarehouseLocationDAO;
import dto.EmployeeInfoDTO;
import dto.ShiftAssignmentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.ShiftService;
import model.Shifts;
import model.Users;

public class ShiftController extends HttpServlet {

    private ShiftService shiftService;
    private ShiftDAO shiftDAO;
    private EmployeeDAO employeeDAO;
    private WarehouseLocationDAO locationDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        shiftService = new ShiftService();
        shiftDAO = new ShiftDAO();
        employeeDAO = new EmployeeDAO();
        locationDAO = new WarehouseLocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            resp.sendRedirect(req.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 16)) {
            resp.sendRedirect(req.getContextPath() + "/404");
            return;
        }
        
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listAssignments(req, resp);
                    break;
                case "add":
                    showAddForm(req, resp);
                    break;
                case "edit":
                    showEditForm(req, resp);
                    break;
                case "delete":
                    deleteAssignment(req, resp);
                    break;
                default:
                    listAssignments(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(ShiftController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/shift_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addAssignment(req, resp);
                    break;
                case "edit":
                    updateAssignment(req, resp);
                    break;
                default:
                    listAssignments(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(ShiftController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            
            if ("add".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/view/shift_add.jsp").forward(req, resp);
            } else if ("edit".equals(action)) {
                req.getRequestDispatcher("/WEB-INF/view/shift_edit.jsp").forward(req, resp);
            } else {
                req.getRequestDispatcher("/WEB-INF/view/shift_list.jsp").forward(req, resp);
            }
        }
    }

    // Hiển thị danh sách assignments
    private void listAssignments(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ShiftAssignmentDTO> assignments = shiftService.getAllAssignments();
        req.setAttribute("assignments", assignments);
        req.getRequestDispatcher("/WEB-INF/view/shift_list.jsp").forward(req, resp);
    }

    // Hiển thị form thêm assignment
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("shifts", shiftDAO.getAllShifts());
        req.setAttribute("employees", employeeDAO.getAllEmployees());
        req.setAttribute("locations", locationDAO.getAllLocations());
        req.getRequestDispatcher("/WEB-INF/view/shift_add.jsp").forward(req, resp);
    }

    // Hiển thị form sửa assignment
    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int assign_id = Integer.parseInt(req.getParameter("id"));
        ShiftAssignmentDTO assignment = shiftService.getAssignmentById(assign_id);
        
        if (assignment == null) {
            req.setAttribute("errorMessage", "Không tìm thấy phân công ca làm việc");
            listAssignments(req, resp);
            return;
        }
        
        req.setAttribute("assignment", assignment);
        req.setAttribute("shifts", shiftDAO.getAllShifts());
        req.setAttribute("employees", employeeDAO.getAllEmployees());
        req.setAttribute("locations", locationDAO.getAllLocations());
        
        req.getRequestDispatcher("/WEB-INF/view/shift_edit.jsp").forward(req, resp);
    }

    // Thêm assignment mới
    private void addAssignment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int shift_id = Integer.parseInt(req.getParameter("shift_id"));
        int employee_id = Integer.parseInt(req.getParameter("employee_id"));
        String assign_date = req.getParameter("assign_date");
        String location_id_param = req.getParameter("location_id");
        Integer location_id = null;
        if (location_id_param != null && !location_id_param.isEmpty() && !location_id_param.equals("null")) {
            location_id = Integer.parseInt(location_id_param);
        }
        String role_in_shift = req.getParameter("role_in_shift");

        // Validate: Kiểm tra employee đã có ca trong ngày chưa
        if (shiftService.hasAssignmentOnDate(employee_id, assign_date)) {
            req.setAttribute("errorMessage", "Nhân viên này đã có ca làm việc trong ngày " + assign_date);
            showAddForm(req, resp);
            return;
        }

        int assign_id = shiftService.addAssignment(shift_id, employee_id, assign_date, location_id, role_in_shift);

        if (assign_id > 0) {
            req.setAttribute("successMessage", "Phân công ca làm việc thành công!");
        } else {
            req.setAttribute("errorMessage", "Phân công ca làm việc thất bại!");
        }

        listAssignments(req, resp);
    }

    // Cập nhật assignment
    private void updateAssignment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int assign_id = Integer.parseInt(req.getParameter("assign_id"));
        int shift_id = Integer.parseInt(req.getParameter("shift_id"));
        int employee_id = Integer.parseInt(req.getParameter("employee_id"));
        String assign_date = req.getParameter("assign_date");
        String location_id_param = req.getParameter("location_id");
        Integer location_id = null;
        if (location_id_param != null && !location_id_param.isEmpty() && !location_id_param.equals("null")) {
            location_id = Integer.parseInt(location_id_param);
        }
        String role_in_shift = req.getParameter("role_in_shift");

        boolean success = shiftService.updateAssignment(assign_id, shift_id, employee_id, assign_date, location_id, role_in_shift);

        if (success) {
            req.setAttribute("successMessage", "Cập nhật phân công ca làm việc thành công!");
        } else {
            req.setAttribute("errorMessage", "Cập nhật phân công ca làm việc thất bại!");
        }

        listAssignments(req, resp);
    }

    // Xóa assignment
    private void deleteAssignment(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int assign_id = Integer.parseInt(req.getParameter("id"));
        
        boolean success = shiftService.deleteAssignment(assign_id);
        if (success) {
            req.setAttribute("successMessage", "Xóa phân công ca làm việc thành công!");
        } else {
            req.setAttribute("errorMessage", "Xóa phân công ca làm việc thất bại!");
        }
        
        listAssignments(req, resp);
    }
}

