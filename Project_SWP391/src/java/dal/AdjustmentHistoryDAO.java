/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dto.AdjustmentHistoryDTO;
import model.Employees;
import util.DBContext;

public class AdjustmentHistoryDAO extends DBContext {

    public AdjustmentHistoryDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi: AdjustmentHistoryDAO không thể kết nối CSDL.");
        }
    }

    /**
     * HÀM 1: Đếm tổng số Log khớp với bộ lọc
     */
    public int getHistoryCount(int employeeId, String reasonType, String dateStart, String dateEnd) throws Exception {
        List<Object> params = new ArrayList<>();
        int total = 0;

        String query = "SELECT COUNT(sa.adjustment_id) "
                + "FROM Stock_adjustments sa "
                + "JOIN Employees e ON sa.created_by = e.employee_id "
                + "JOIN Users u_emp ON e.user_id = u_emp.user_id "
                + "WHERE 1=1 ";

        // Thêm các bộ lọc
        addFilterConditions(query, params, employeeId, reasonType, dateStart, dateEnd);

        // Gắn query mới vào
        String finalQuery = query;

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = this.connection.prepareStatement(finalQuery);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi đếm History: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return total;
    }

    /**
     * HÀM 2: Lấy Lịch sử Điều chỉnh (CÓ LỌC và PHÂN TRANG)
     */
    public List<AdjustmentHistoryDTO> getHistoryPaginated(int employeeId, String reasonType, String dateStart, String dateEnd, int pageIndex, int pageSize) throws Exception {
        List<AdjustmentHistoryDTO> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        // Câu truy vấn JOIN 6 bảng (giữ nguyên)
        String query = "SELECT "
                + "    sa.adjustment_id, sa.created_at, sa.reason, "
                + "    u_emp.fullname AS employeeName, "
                + "    pu.imei, pu.status AS currentStatus, "
                + "    p.name AS productName, "
                + "    wl.code AS currentLocation "
                + "FROM Stock_adjustments sa "
                + "JOIN Employees e ON sa.created_by = e.employee_id "
                + "JOIN Users u_emp ON e.user_id = u_emp.user_id "
                + "JOIN Product_units pu ON sa.unit_id = pu.unit_id "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "LEFT JOIN Containers c ON pu.container_id = c.container_id "
                + "LEFT JOIN Warehouse_locations wl ON c.location_id = wl.location_id "
                + "WHERE 1=1 ";

        // Thêm các bộ lọc
        addFilterConditions(query, params, employeeId, reasonType, dateStart, dateEnd);

        // Gắn query mới vào
        String finalQuery = query;

        // Thêm Phân trang
        finalQuery += " ORDER BY sa.created_at DESC "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((pageIndex - 1) * pageSize);
        params.add(pageSize);

        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = this.connection.prepareStatement(finalQuery);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                AdjustmentHistoryDTO dto = new AdjustmentHistoryDTO();
                dto.setAdjustmentId(rs.getInt("adjustment_id"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                dto.setEmployeeName(rs.getString("employeeName"));
                dto.setImei(rs.getString("imei"));
                dto.setProductName(rs.getString("productName"));
                dto.setReason(rs.getString("reason"));
                dto.setCurrentLocation(rs.getString("currentLocation"));
                dto.setCurrentStatus(rs.getString("currentStatus"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi lấy History: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    /**
     * HÀM PHỤ: Dùng chung để thêm điều kiện WHERE
     */
    private void addFilterConditions(String query, List<Object> params, int employeeId, String reasonType, String dateStart, String dateEnd) {
        // Lọc theo Nhân viên
        if (employeeId > 0) {
            query += " AND sa.created_by = ? ";
            params.add(employeeId);
        }

        // Lọc theo Loại (LIKE)
        if (reasonType != null && !reasonType.isEmpty()) {
            if (reasonType.equals("STATUS_CHANGE")) {
                query += " AND sa.reason LIKE 'Status changed:%' ";
            } else if (reasonType.equals("TRANSFER")) {
                query += " AND sa.reason LIKE 'Internal Transfer.%' ";
            }
        }

        // Lọc theo Ngày Bắt đầu
        if (dateStart != null && !dateStart.isEmpty()) {
            query += " AND sa.created_at >= ? ";
            params.add(dateStart);
        }

        // Lọc theo Ngày Kết thúc (phải +1 ngày)
        if (dateEnd != null && !dateEnd.isEmpty()) {
            query += " AND sa.created_at <= ? ";
            params.add(dateEnd + " 23:59:59"); // Lấy đến cuối ngày
        }
    }

    /**
     * HÀM 3: Lấy danh sách Nhân viên (cho dropdown)
     */
    public List<Employees> getAllEmployees() throws Exception {
        List<Employees> list = new ArrayList<>();
        String query = "SELECT e.employee_id, u.fullname "
                + "FROM Employees e JOIN Users u ON e.user_id = u.user_id";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Employees e = new Employees();
                e.setEmployee_id(rs.getInt("employee_id"));
                // Chúng ta "lợi dụng" trường bank_account để lưu fullname
                e.setBank_account(rs.getString("fullname"));
                list.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    /**
     * HÀM 3: Đóng kết nối
     */
    public void closeConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed()) {
                this.connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
