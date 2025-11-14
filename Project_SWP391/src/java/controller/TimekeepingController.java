package controller;

import dto.AttendanceDTO;
import dto.ShiftAssignmentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;
import dal.EmployeeDAO;
import service.AttendanceService;
import service.ShiftService;

public class TimekeepingController extends HttpServlet {

    private AttendanceService attendanceService;
    private ShiftService shiftService;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        attendanceService = new AttendanceService();
        shiftService = new ShiftService();
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
                    showTimekeepingPage(req, resp);
                    break;
                case "history":
                    showHistoryPage(req, resp);
                    break;
                case "checkin":
                    doCheckIn(req, resp);
                    break;
                case "checkout":
                    doCheckOut(req, resp);
                    break;
                case "admin":
                    showAdminTimekeepingPage(req, resp);
                    break;
                case "admin-checkin":
                    doAdminCheckIn(req, resp);
                    break;
                case "admin-checkout":
                    doAdminCheckOut(req, resp);
                    break;
                default:
                    showTimekeepingPage(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            // Kiểm tra session trước khi hiển thị error
            HttpSession session = req.getSession();
            Users user = (Users) session.getAttribute("account");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/loginStaff");
                return;
            }
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            try {
                showTimekeepingPage(req, resp);
            } catch (Exception ex) {
                Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, ex);
                resp.sendRedirect(req.getContextPath() + "/loginStaff");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            switch (action) {
                case "checkin":
                    doCheckIn(req, resp);
                    break;
                case "checkout":
                    doCheckOut(req, resp);
                    break;
                case "admin-checkin":
                    doAdminCheckIn(req, resp);
                    break;
                case "admin-checkout":
                    doAdminCheckOut(req, resp);
                    break;
                default:
                    showTimekeepingPage(req, resp);
            }
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            // Kiểm tra session trước khi hiển thị error
            HttpSession session = req.getSession();
            Users user = (Users) session.getAttribute("account");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/loginStaff");
                return;
            }
            req.setAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            try {
                showTimekeepingPage(req, resp);
            } catch (Exception ex) {
                Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, ex);
                resp.sendRedirect(req.getContextPath() + "/loginStaff");
            }
        }
    }

    // Hiển thị trang chấm công
    private void showTimekeepingPage(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        // Kiểm tra user đã đăng nhập chưa - nếu đã đăng nhập thì session sẽ có "account"
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        // Lấy employee_id từ user_id
        int employee_id = employeeDAO.getEmployeeIdByUserId(user.getUser_id());
        if (employee_id == -1) {
            // Nếu không tìm thấy employee_id, có thể user không phải nhân viên
            // Hiển thị thông báo lỗi nhưng vẫn ở trang timekeeping
            req.setAttribute("errorMessage", "Bạn không có quyền truy cập chức năng chấm công. Vui lòng liên hệ quản trị viên.");
            // Vẫn forward đến trang timekeeping để hiển thị thông báo
            req.setAttribute("todayAssignments", new java.util.ArrayList<>());
            req.setAttribute("todayAttendances", new java.util.ArrayList<>());
            req.getRequestDispatcher("/WEB-INF/view/timekeeping.jsp").forward(req, resp);
            return;
        }
        
        // Lấy assignments hôm nay
        List<ShiftAssignmentDTO> todayAssignments = attendanceService.getTodayAssignments(employee_id);
        
        // Lấy tất cả attendances của employee để match với assignments hôm nay
        List<AttendanceDTO> allAttendances = attendanceService.getAttendancesByEmployee(employee_id);
        
        // Filter attendances hôm nay
        java.util.Date today = new java.util.Date();
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(today);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        java.util.Date startOfDay = cal.getTime();
        
        List<AttendanceDTO> todayAttendances = new java.util.ArrayList<>();
        for (AttendanceDTO att : allAttendances) {
            if (att.getCheck_in() != null) {
                java.util.Date checkInDate = new java.util.Date(att.getCheck_in().getTime());
                if (checkInDate.after(startOfDay) || checkInDate.equals(startOfDay)) {
                    todayAttendances.add(att);
                }
            }
        }
        
        // Lấy message từ session và xóa sau khi lấy
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
            req.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }
        
        req.setAttribute("todayAssignments", todayAssignments);
        req.setAttribute("todayAttendances", todayAttendances);
        req.setAttribute("employee_id", employee_id);
        req.setAttribute("user", user);
        
        req.getRequestDispatcher("/WEB-INF/view/timekeeping.jsp").forward(req, resp);
    }

    // Hiển thị lịch sử chấm công
    private void showHistoryPage(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        // Kiểm tra user đã đăng nhập chưa - nếu đã đăng nhập thì session sẽ có "account"
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        // Kiểm tra xem có phải admin không (role_id == 1)
        boolean isAdmin = (user.getRole_id() == 1);
        
        int employee_id = -1;
        if (!isAdmin) {
            // Nếu không phải admin thì chỉ lấy attendances của chính nhân viên đó
            employee_id = employeeDAO.getEmployeeIdByUserId(user.getUser_id());
            if (employee_id == -1) {
                req.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
                req.getRequestDispatcher("/WEB-INF/view/error_page.jsp").forward(req, resp);
                return;
            }
        }
        // Nếu là admin thì employee_id = -1, sẽ lấy tất cả attendances
        
        // Lấy filter từ request parameters
        String filterType = req.getParameter("filter"); // "week" hoặc "month"
        String weekParam = req.getParameter("week");
        String monthParam = req.getParameter("month");
        String yearParam = req.getParameter("year");
        
        List<AttendanceDTO> attendances;
        Calendar cal = Calendar.getInstance();
        int currentYear = cal.get(Calendar.YEAR);
        int currentWeek = cal.get(Calendar.WEEK_OF_YEAR);
        int currentMonth = cal.get(Calendar.MONTH) + 1;
        
        if (filterType != null && !filterType.isEmpty()) {
            if ("week".equals(filterType) && weekParam != null && yearParam != null) {
                // Filter theo tuần
                try {
                    int week = Integer.parseInt(weekParam);
                    int year = Integer.parseInt(yearParam);
                    attendances = attendanceService.getAttendancesByWeek(week, year, employee_id);
                    req.setAttribute("selectedWeek", week);
                    req.setAttribute("selectedYear", year);
                    req.setAttribute("filterType", "week");
                } catch (NumberFormatException e) {
                    // Nếu parse lỗi thì lấy tuần hiện tại
                    attendances = attendanceService.getAttendancesByWeek(currentWeek, currentYear, employee_id);
                    req.setAttribute("selectedWeek", currentWeek);
                    req.setAttribute("selectedYear", currentYear);
                    req.setAttribute("filterType", "week");
                }
            } else if ("month".equals(filterType) && monthParam != null && yearParam != null) {
                // Filter theo tháng
                try {
                    int month = Integer.parseInt(monthParam);
                    int year = Integer.parseInt(yearParam);
                    attendances = attendanceService.getAttendancesByMonth(month, year, employee_id);
                    req.setAttribute("selectedMonth", month);
                    req.setAttribute("selectedYear", year);
                    req.setAttribute("filterType", "month");
                } catch (NumberFormatException e) {
                    // Nếu parse lỗi thì lấy tháng hiện tại
                    attendances = attendanceService.getAttendancesByMonth(currentMonth, currentYear, employee_id);
                    req.setAttribute("selectedMonth", currentMonth);
                    req.setAttribute("selectedYear", currentYear);
                    req.setAttribute("filterType", "month");
                }
            } else {
                // Mặc định lấy tháng hiện tại
                attendances = attendanceService.getAttendancesByMonth(currentMonth, currentYear, employee_id);
                req.setAttribute("selectedMonth", currentMonth);
                req.setAttribute("selectedYear", currentYear);
                req.setAttribute("filterType", "month");
            }
        } else {
            // Mặc định lấy tháng hiện tại
            attendances = attendanceService.getAttendancesByMonth(currentMonth, currentYear, employee_id);
            req.setAttribute("selectedMonth", currentMonth);
            req.setAttribute("selectedYear", currentYear);
            req.setAttribute("filterType", "month");
        }
        
        req.setAttribute("attendances", attendances);
        req.setAttribute("employee_id", employee_id);
        req.setAttribute("isAdmin", isAdmin);
        req.setAttribute("user", user);
        req.setAttribute("currentWeek", currentWeek);
        req.setAttribute("currentMonth", currentMonth);
        req.setAttribute("currentYear", currentYear);
        
        req.getRequestDispatcher("/WEB-INF/view/attendance_history.jsp").forward(req, resp);
    }

    // Check in
    private void doCheckIn(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        // Kiểm tra user đã đăng nhập chưa - nếu đã đăng nhập thì session sẽ có "account"
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        int employee_id = employeeDAO.getEmployeeIdByUserId(user.getUser_id());
        if (employee_id == -1) {
            session.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
            resp.sendRedirect(req.getContextPath() + "/timekeeping");
            return;
        }
        
        try {
            int assign_id = Integer.parseInt(req.getParameter("assign_id"));
            String note = req.getParameter("note");
            
            if (note == null) {
                note = "";
            }
            
            int attendance_id = attendanceService.checkIn(assign_id, employee_id, note);
            
            if (attendance_id > 0) {
                session.setAttribute("successMessage", "Check in thành công!");
            } else {
                session.setAttribute("errorMessage", "Check in thất bại! Có thể bạn đã check in rồi.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi: Dữ liệu không hợp lệ.");
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi check in: " + e.getMessage());
        }
        
        // Redirect để reload lại trang với dữ liệu mới
        resp.sendRedirect(req.getContextPath() + "/timekeeping");
    }

    // Check out
    private void doCheckOut(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        // Kiểm tra user đã đăng nhập chưa - nếu đã đăng nhập thì session sẽ có "account"
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        int employee_id = employeeDAO.getEmployeeIdByUserId(user.getUser_id());
        if (employee_id == -1) {
            session.setAttribute("errorMessage", "Không tìm thấy thông tin nhân viên.");
            resp.sendRedirect(req.getContextPath() + "/timekeeping");
            return;
        }
        
        try {
            String attendance_id_param = req.getParameter("attendance_id");
            String assign_id_param = req.getParameter("assign_id");
            String note = req.getParameter("note");
            
            if (note == null) {
                note = "";
            }
            
            boolean success = false;
            
            if (attendance_id_param != null && !attendance_id_param.isEmpty()) {
                int attendance_id = Integer.parseInt(attendance_id_param);
                success = attendanceService.checkOut(attendance_id, note);
            } else if (assign_id_param != null && !assign_id_param.isEmpty()) {
                int assign_id = Integer.parseInt(assign_id_param);
                success = attendanceService.checkOutByAssignId(assign_id, note);
            } else {
                session.setAttribute("errorMessage", "Không tìm thấy thông tin chấm công để check out.");
                resp.sendRedirect(req.getContextPath() + "/timekeeping");
                return;
            }
            
            if (success) {
                session.setAttribute("successMessage", "Check out thành công!");
            } else {
                session.setAttribute("errorMessage", "Check out thất bại! Có thể bạn chưa check in hoặc đã check out rồi.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi: Dữ liệu không hợp lệ.");
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi check out: " + e.getMessage());
        }
        
        // Redirect để reload lại trang với dữ liệu mới
        resp.sendRedirect(req.getContextPath() + "/timekeeping");
    }
    
    // Hiển thị trang quản lý chấm công cho admin
    private void showAdminTimekeepingPage(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        // Lấy tất cả assignments hôm nay
        List<ShiftAssignmentDTO> todayAssignments = attendanceService.getTodayAllAssignments();
        
        // Lấy tất cả attendances hôm nay
        List<AttendanceDTO> todayAttendances = attendanceService.getTodayAllAttendances();
        
        // Lấy message từ session
        String successMessage = (String) session.getAttribute("successMessage");
        String errorMessage = (String) session.getAttribute("errorMessage");
        if (successMessage != null) {
            req.setAttribute("successMessage", successMessage);
            session.removeAttribute("successMessage");
        }
        if (errorMessage != null) {
            req.setAttribute("errorMessage", errorMessage);
            session.removeAttribute("errorMessage");
        }
        
        req.setAttribute("todayAssignments", todayAssignments);
        req.setAttribute("todayAttendances", todayAttendances);
        req.setAttribute("user", user);
        
        req.getRequestDispatcher("/WEB-INF/view/admin_timekeeping.jsp").forward(req, resp);
    }
    
    // Admin check in cho nhân viên
    private void doAdminCheckIn(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        try {
            int assign_id = Integer.parseInt(req.getParameter("assign_id"));
            String note = req.getParameter("note");
            
            if (note == null) {
                note = "";
            }
            
            // Lấy employee_id từ assign_id
            ShiftAssignmentDTO assignment = shiftService.getAssignmentById(assign_id);
            if (assignment == null) {
                session.setAttribute("errorMessage", "Không tìm thấy ca làm việc.");
                resp.sendRedirect(req.getContextPath() + "/timekeeping?action=admin");
                return;
            }
            
            int employee_id = assignment.getEmployee_id();
            Timestamp checkInTime = new Timestamp(System.currentTimeMillis());
            
            int attendance_id = attendanceService.checkInForEmployee(assign_id, employee_id, checkInTime, note);
            
            if (attendance_id > 0) {
                session.setAttribute("successMessage", "Check in thành công cho nhân viên " + assignment.getEmployee_name() + "!");
            } else {
                session.setAttribute("errorMessage", "Check in thất bại! Có thể nhân viên đã check in rồi.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi: Dữ liệu không hợp lệ.");
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi check in: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/timekeeping?action=admin");
    }
    
    // Admin check out cho nhân viên
    private void doAdminCheckOut(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        Users user = (Users) session.getAttribute("account");
        
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/loginStaff");
            return;
        }
        
        try {
            String attendance_id_param = req.getParameter("attendance_id");
            String note = req.getParameter("note");
            
            if (note == null) {
                note = "";
            }
            
            if (attendance_id_param == null || attendance_id_param.isEmpty()) {
                session.setAttribute("errorMessage", "Không tìm thấy thông tin chấm công để check out.");
                resp.sendRedirect(req.getContextPath() + "/timekeeping?action=admin");
                return;
            }
            
            int attendance_id = Integer.parseInt(attendance_id_param);
            AttendanceDTO attendance = attendanceService.getAttendanceById(attendance_id);
            
            if (attendance == null) {
                session.setAttribute("errorMessage", "Không tìm thấy bản ghi chấm công.");
                resp.sendRedirect(req.getContextPath() + "/timekeeping?action=admin");
                return;
            }
            
            boolean success = attendanceService.checkOut(attendance_id, note);
            
            if (success) {
                session.setAttribute("successMessage", "Check out thành công cho nhân viên " + attendance.getEmployee_name() + "!");
            } else {
                session.setAttribute("errorMessage", "Check out thất bại! Có thể nhân viên chưa check in hoặc đã check out rồi.");
            }
        } catch (NumberFormatException e) {
            session.setAttribute("errorMessage", "Lỗi: Dữ liệu không hợp lệ.");
        } catch (Exception e) {
            Logger.getLogger(TimekeepingController.class.getName()).log(Level.SEVERE, null, e);
            session.setAttribute("errorMessage", "Có lỗi xảy ra khi check out: " + e.getMessage());
        }
        
        resp.sendRedirect(req.getContextPath() + "/timekeeping?action=admin");
    }
}

