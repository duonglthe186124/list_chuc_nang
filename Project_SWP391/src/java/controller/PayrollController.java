package controller;

import dal.EmployeeDAO;
import dto.PayrollDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import service.PayrollService;
import service.PayrollService.ComponentInput;

public class PayrollController extends HttpServlet {

    private PayrollService payrollService;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        payrollService = new PayrollService();
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listPayrolls(req, resp);
                    break;
                case "add":
                    showAddForm(req, resp);
                    break;
                case "view":
                    viewPayroll(req, resp);
                    break;
                case "delete":
                    deletePayroll(req, resp);
                    break;
                default:
                    listPayrolls(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(PayrollController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/payroll_list.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addPayroll(req, resp);
                    break;
                default:
                    listPayrolls(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(PayrollController.class.getName()).log(Level.SEVERE, null, e);
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/view/payroll_add.jsp").forward(req, resp);
        }
    }

    // Hiển thị danh sách payrolls
    private void listPayrolls(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<PayrollDTO> payrolls = payrollService.getAllPayrolls();
        req.setAttribute("payrolls", payrolls);
        req.getRequestDispatcher("/WEB-INF/view/payroll_list.jsp").forward(req, resp);
    }

    // Hiển thị form thêm payroll
    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("employees", employeeDAO.getAllEmployees());
        req.getRequestDispatcher("/WEB-INF/view/payroll_add.jsp").forward(req, resp);
    }

    // Xem chi tiết payroll
    private void viewPayroll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int payroll_id = Integer.parseInt(req.getParameter("id"));
        PayrollDTO payroll = payrollService.getPayrollById(payroll_id);
        
        if (payroll == null) {
            req.setAttribute("errorMessage", "Không tìm thấy bảng lương");
            listPayrolls(req, resp);
            return;
        }
        
        req.setAttribute("payroll", payroll);
        req.getRequestDispatcher("/WEB-INF/view/payroll_view.jsp").forward(req, resp);
    }

    // Thêm payroll mới
    private void addPayroll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int employee_id = Integer.parseInt(req.getParameter("employee_id"));
        String period_start = req.getParameter("period_start");
        String period_end = req.getParameter("period_end");
        
        // Lấy các components từ form
        List<ComponentInput> components = new ArrayList<>();
        
        // Lương cơ bản
        String basicSalary = req.getParameter("basic_salary");
        if (basicSalary != null && !basicSalary.isEmpty()) {
            components.add(new ComponentInput("Lương cơ bản", new BigDecimal(basicSalary)));
        }
        
        // Phụ cấp ăn trưa
        String lunchAllowance = req.getParameter("lunch_allowance");
        if (lunchAllowance != null && !lunchAllowance.isEmpty()) {
            components.add(new ComponentInput("Phụ cấp ăn trưa", new BigDecimal(lunchAllowance)));
        }
        
        // Phụ cấp xăng xe
        String travelAllowance = req.getParameter("travel_allowance");
        if (travelAllowance != null && !travelAllowance.isEmpty()) {
            components.add(new ComponentInput("Phụ cấp xăng xe", new BigDecimal(travelAllowance)));
        }
        
        // Thưởng
        String bonus = req.getParameter("bonus");
        if (bonus != null && !bonus.isEmpty()) {
            components.add(new ComponentInput("Thưởng", new BigDecimal(bonus)));
        }
        
        // Bảo hiểm xã hội
        String socialInsurance = req.getParameter("social_insurance");
        if (socialInsurance != null && !socialInsurance.isEmpty()) {
            components.add(new ComponentInput("Bảo hiểm xã hội", new BigDecimal(socialInsurance)));
        }
        
        // Bảo hiểm y tế
        String healthInsurance = req.getParameter("health_insurance");
        if (healthInsurance != null && !healthInsurance.isEmpty()) {
            components.add(new ComponentInput("Bảo hiểm y tế", new BigDecimal(healthInsurance)));
        }
        
        // Bảo hiểm thất nghiệp
        String unemploymentInsurance = req.getParameter("unemployment_insurance");
        if (unemploymentInsurance != null && !unemploymentInsurance.isEmpty()) {
            components.add(new ComponentInput("Bảo hiểm thất nghiệp", new BigDecimal(unemploymentInsurance)));
        }
        
        // Thuế thu nhập cá nhân
        String personalIncomeTax = req.getParameter("personal_income_tax");
        if (personalIncomeTax != null && !personalIncomeTax.isEmpty()) {
            components.add(new ComponentInput("Thuế thu nhập cá nhân", new BigDecimal(personalIncomeTax)));
        }

        int payroll_id = payrollService.addPayroll(employee_id, period_start, period_end, components);

        if (payroll_id > 0) {
            req.setAttribute("successMessage", "Tạo bảng lương thành công!");
        } else {
            req.setAttribute("errorMessage", "Tạo bảng lương thất bại!");
        }

        listPayrolls(req, resp);
    }

    // Xóa payroll
    private void deletePayroll(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int payroll_id = Integer.parseInt(req.getParameter("id"));
        
        boolean success = payrollService.deletePayroll(payroll_id);
        if (success) {
            req.setAttribute("successMessage", "Xóa bảng lương thành công!");
        } else {
            req.setAttribute("errorMessage", "Xóa bảng lương thất bại!");
        }
        
        listPayrolls(req, resp);
    }
}

