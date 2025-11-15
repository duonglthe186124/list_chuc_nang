/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.receipt_good;

import dal.UserDAO;
import dto.Response_LocationDTO;
import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import model.Users;
import service.ReceiptService;

/**
 *
 * @author ASUS
 */
public class createReceiptServlet extends HttpServlet {

    private static final ReceiptService service = new ReceiptService();
    private static List<Response_ReceiptOrderDTO> purchase_order_list;
    private static List<Response_ReceiptLineDTO> po_line_list;
    private static Response_ReceiptHeaderDTO po_header;
    private static List<Response_LocationDTO> locations;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 14)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        String raw_po_id = request.getParameter("po_id");
        String receipt_code = service.get_auto_receipt_code();

        int po_id = 0;
        if (raw_po_id != null && !raw_po_id.trim().isEmpty()) {
            po_id = Integer.parseInt(raw_po_id);
        }

        purchase_order_list = service.get_purchase_order_list();
        locations = service.get_location();
        if (po_id != 0) {
            po_line_list = service.get_po_line(po_id);
            po_header = service.get_receipt_header(po_id);
            request.setAttribute("poHeader", po_header);
            request.setAttribute("poLine", po_line_list);
        }
        request.setAttribute("selectedID", po_id);
        request.setAttribute("poList", purchase_order_list);
        request.setAttribute("receipt_code", receipt_code);
        request.setAttribute("locations", locations);
        request.getRequestDispatcher("/WEB-INF/view/create_receipt.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDAO user_dao = new UserDAO();

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        Users user = (Users) session.getAttribute("account");
        if (user == null || !user_dao.check_role(user.getRole_id(), 14)) {
            response.sendRedirect(request.getContextPath() + "/404");
            return;
        }

        String raw_po_id = request.getParameter("po_id");
        String receipt_code = request.getParameter("receipt_code");
        String[] raw_received_qty = request.getParameterValues("received_qty");
        String[] raw_location_id = request.getParameterValues("location");
        String[] note = request.getParameterValues("note");
        String[] imei = request.getParameterValues("imei");
        String[] serial_number = request.getParameterValues("serial_number");
        String[] raw_warranty_start = request.getParameterValues("warranty_start");
        String[] raw_warranty_end = request.getParameterValues("warranty_end");
        String receipt_note = request.getParameter("receipt_note");

        if (raw_po_id == null || raw_po_id.trim().isEmpty() || raw_po_id.equals("0")) {
            session.setAttribute("toast_error", "Thiếu thông tin Đơn mua hàng (PO ID).");
            doGet(request, response);
            return;
        }

        if (raw_received_qty == null || raw_location_id == null || raw_received_qty.length == 0 || raw_location_id.length == 0) {
            session.setAttribute("toast_error", "Phiếu nhập phải có ít nhất một mặt hàng với số lượng nhận và vị trí kho được chỉ định.");
            doGet(request, response);
            return;
        }

        int po_id = 0;
        try {
            po_id = Integer.parseInt(raw_po_id);
        } catch (NumberFormatException e) {
            session.setAttribute("toast_error", "Định dạng PO ID không hợp lệ.");
            doGet(request, response);
            return;
        }

        int length = raw_received_qty.length;
        int[] received_qty = new int[length],
                location_id = new int[length];
        int detailLength = imei != null ? imei.length : 0;
        Date[] warranty_start = new Date[detailLength],
                warranty_end = new Date[detailLength];

        if (raw_received_qty.length != raw_location_id.length) {
            session.setAttribute("toast_error", "Lỗi cấu trúc dữ liệu: Số lượng nhận và Vị trí kho không khớp số lượng dòng.");
            doGet(request, response);
            return;
        }

        try {
            for (int i = 0; i < length; i++) {
                String current_qty_str = raw_received_qty[i] != null ? raw_received_qty[i].trim() : "";
                String current_loc_str = raw_location_id[i] != null ? raw_location_id[i].trim() : "";

                if (current_qty_str.isEmpty()) {
                    throw new NumberFormatException("Số lượng nhận không được để trống cho dòng thứ " + (i + 1) + ".");
                }
                received_qty[i] = Integer.parseInt(current_qty_str);

                if (current_loc_str.isEmpty()) {
                    throw new NumberFormatException("Vị trí kho không được để trống cho dòng thứ " + (i + 1) + ".");
                }
                location_id[i] = Integer.parseInt(current_loc_str);
            }
        } catch (NumberFormatException e) {
            session.setAttribute("toast_error", "Lỗi định dạng số: " + e.getMessage());
            doGet(request, response);
            return;
        }

        try {
            for (int i = 0; i < detailLength; i++) {
                String startStr = (raw_warranty_start != null && i < raw_warranty_start.length) ? raw_warranty_start[i] : null;
                String endStr = (raw_warranty_end != null && i < raw_warranty_end.length) ? raw_warranty_end[i] : null;

                if (startStr == null || startStr.trim().isEmpty()) {
                    throw new DateTimeParseException("Ngày Bắt Đầu Bảo Hành không được để trống cho đơn vị thứ " + (i + 1) + ".", "", 0);
                }
                warranty_start[i] = java.sql.Date.valueOf(LocalDate.parse(startStr));
                
                if (endStr == null || endStr.trim().isEmpty()) {
                    throw new DateTimeParseException("Ngày Kết Thúc Bảo Hành không được để trống cho đơn vị thứ " + (i + 1) + ".", "", 0);
                }
                warranty_end[i] = java.sql.Date.valueOf(LocalDate.parse(endStr));
            }
        } catch (DateTimeParseException e) {
            session.setAttribute("toast_error", "Lỗi định dạng ngày tháng: " + e.getMessage());
            doGet(request, response);
            return;
        }

        String validationError = service.validateReceiptData(
                receipt_code,
                user.getUser_id(),
                received_qty,
                receipt_note,
                location_id,
                imei,
                serial_number,
                warranty_start,
                warranty_end);

        if (validationError != null) {
            session.setAttribute("toast_error", validationError);
            doGet(request, response);
            return;
        }

        service.create_receipt(po_id, receipt_code, user.getUser_id(), received_qty, receipt_note,
                location_id, imei, serial_number, warranty_start, warranty_end, note);
        response.sendRedirect(request.getContextPath() + "/inbound/transactions");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
