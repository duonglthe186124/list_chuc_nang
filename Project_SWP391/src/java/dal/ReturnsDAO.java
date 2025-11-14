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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import dto.ReturnFormDTO;
import dto.ReturnHistoryDTO;
import util.DBContext;

public class ReturnsDAO extends DBContext {

    /**
     * Constructor: Kiểm tra kết nối
     */
    public ReturnsDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi nghiêm trọng: ReturnsDAO không thể kết nối CSDL.");
        }
    }

    /**
     * HÀM 1 (NÂNG CẤP): Lấy 10 trường cho Form Trả Hàng (Tìm 1 IMEI có status =
     * 'SOLD')
     */
    public ReturnFormDTO getUnitDetailsForReturn(String imei) throws Exception {
        ReturnFormDTO dto = null;
        // Câu truy vấn JOIN 8 bảng
        String query = "SELECT "
                + "    pu.unit_id, pu.imei, pu.status, "
                + // 1, 4 (Tình trạng)
                "    p.sku_code, p.name AS productName, "
                + // 2, 3
                "    o.order_id, "
                + // 5
                "    u.fullname AS customerName, u.phone AS customerPhone, "
                + // 6, 7
                "    s.supplier_name, s.phone AS supplierPhone, s.email AS supplierEmail "
                + // 8, 9, 10
                "FROM Product_units pu "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + // JOIN để lấy Đơn hàng (Order) và Khách hàng (User)
                "LEFT JOIN Shipment_units shu ON pu.unit_id = shu.unit_id "
                + "LEFT JOIN Shipment_lines sl ON shu.line_id = sl.line_id "
                + "LEFT JOIN Shipments sh ON sl.shipment_id = sh.shipment_id "
                + "LEFT JOIN Orders o ON sh.order_id = o.order_id "
                + "LEFT JOIN Users u ON o.user_id = u.user_id "
                + // JOIN để lấy Nhà cung cấp (Supplier)
                "LEFT JOIN Receipt_units ru ON pu.unit_id = ru.unit_id "
                + "LEFT JOIN Receipt_lines rl ON ru.line_id = rl.line_id "
                + "LEFT JOIN Receipts r ON rl.receipt_id = r.receipts_id "
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id "
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id "
                + "WHERE pu.imei = ? AND pu.status = 'SOLD'"; // Chỉ tìm hàng đã BÁN

        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, imei);
            rs = ps.executeQuery();
            if (rs.next()) {
                dto = new ReturnFormDTO();
                dto.setImei(rs.getString("imei"));
                dto.setUnitId(rs.getInt("unit_id"));
                dto.setSkuCode(rs.getString("sku_code"));
                dto.setProductName(rs.getString("productName"));
                dto.setCurrentStatus(rs.getString("status"));
                dto.setOrderId(rs.getInt("order_id"));
                dto.setCustomerName(rs.getString("customerName"));
                dto.setCustomerPhone(rs.getString("customerPhone"));
                dto.setSupplierName(rs.getString("supplier_name"));
                dto.setSupplierPhone(rs.getString("supplierPhone"));
                dto.setSupplierEmail(rs.getString("supplierEmail"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi tìm IMEI trả hàng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                // KHÔNG đóng conn, Servlet sẽ đóng
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return dto;
    }

    /**
     * HÀM 2 (Giữ nguyên): Xử lý trả hàng (Dùng Transaction)
     */
    public boolean processReturn(int unitId, int orderId, int createdBy, String reason, String note) throws Exception {
        Connection conn = this.connection;
        PreparedStatement psReturn = null;
        PreparedStatement psReturnLine = null;
        PreparedStatement psUpdateUnit = null;
        ResultSet rsReturn = null;

        // Cập nhật: Thêm note vào Returns
        String sqlReturn = "INSERT INTO Returns (return_no, order_id, created_by, status, note) VALUES (?, ?, ?, 'OPEN', ?)";
        String sqlReturnLine = "INSERT INTO Return_lines (return_id, unit_id, reason) VALUES (?, ?, ?)";
        String sqlUpdateUnit = "UPDATE Product_units SET status = 'RETURNED', updated_at = SYSUTCDATETIME() WHERE unit_id = ?";

        try {
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Tạo phiếu Returns
            String returnNo = "RT-" + System.currentTimeMillis();
            psReturn = conn.prepareStatement(sqlReturn, Statement.RETURN_GENERATED_KEYS);
            psReturn.setString(1, returnNo);
            psReturn.setInt(2, orderId);
            psReturn.setInt(3, createdBy);
            psReturn.setString(4, note); // Ghi chú chi tiết
            psReturn.executeUpdate();

            // Lấy return_id vừa tạo
            rsReturn = psReturn.getGeneratedKeys();
            if (!rsReturn.next()) {
                throw new Exception("Không thể tạo phiếu trả hàng (Returns).");
            }
            int returnId = rsReturn.getInt(1);

            // 2. Tạo dòng Return_lines
            psReturnLine = conn.prepareStatement(sqlReturnLine);
            psReturnLine.setInt(1, returnId);
            psReturnLine.setInt(2, unitId);
            psReturnLine.setString(3, reason); // Lý do (ngắn gọn)
            psReturnLine.executeUpdate();

            // 3. Cập nhật status của IMEI
            psUpdateUnit = conn.prepareStatement(sqlUpdateUnit);
            psUpdateUnit.setInt(1, unitId);
            int affectedRows = psUpdateUnit.executeUpdate();

            if (affectedRows == 0) {
                throw new Exception("Không thể cập nhật trạng thái IMEI.");
            }

            conn.commit(); // Lưu tất cả thay đổi
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            if (conn != null) {
                conn.rollback(); // Hoàn tác nếu có lỗi
            }
            throw e; // Ném lỗi ra Servlet
        } finally {
            // Đóng tất cả
            try {
                if (rsReturn != null) {
                    rsReturn.close();
                }
                if (psReturn != null) {
                    psReturn.close();
                }
                if (psReturnLine != null) {
                    psReturnLine.close();
                }
                if (psUpdateUnit != null) {
                    psUpdateUnit.close();
                }
                // KHÔNG đóng conn, Servlet sẽ đóng
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * HÀM 3 (MỚI): Lấy Lịch sử Trả hàng
     */
    public List<ReturnHistoryDTO> getReturnHistory() throws Exception {
        List<ReturnHistoryDTO> list = new ArrayList<>();
        String query = "SELECT "
                + "    r.return_no, r.created_at AS returnDate, r.status, "
                + "    u.fullname AS customerName, "
                + "    pu.imei, p.name AS productName "
                + "FROM Returns r "
                + "JOIN Return_lines rl ON r.return_id = rl.return_id "
                + "JOIN Orders o ON r.order_id = o.order_id "
                + // Lấy đơn hàng
                "JOIN Users u ON o.user_id = u.user_id "
                + // Lấy khách hàng từ đơn hàng
                "JOIN Product_units pu ON rl.unit_id = pu.unit_id "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "ORDER BY r.created_at DESC";

        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                ReturnHistoryDTO dto = new ReturnHistoryDTO();
                dto.setReturnNo(rs.getString("returnNo"));
                dto.setReturnDate(rs.getTimestamp("returnDate"));
                dto.setStatus(rs.getString("status"));
                dto.setCustomerName(rs.getString("customerName"));
                dto.setImei(rs.getString("imei"));
                dto.setProductName(rs.getString("productName"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi lấy lịch sử trả hàng: " + e.getMessage());
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                // KHÔNG đóng conn, Servlet sẽ đóng
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    /**
     * HÀM 4: Hàm để đóng kết nối thủ công
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
