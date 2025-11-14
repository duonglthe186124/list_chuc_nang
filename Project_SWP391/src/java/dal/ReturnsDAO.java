/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

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

    public ReturnsDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi: ReturnsDAO không thể kết nối CSDL.");
        }
    }

    // Hàm 1 (NÂNG CẤP): Lấy 10 trường cho Form Trả Hàng
    public ReturnFormDTO getUnitDetailsForReturn(String imei) throws Exception {
        ReturnFormDTO dto = null;
        String query = "SELECT "
                + "    pu.unit_id, pu.imei, pu.status, "
                + "    p.sku_code, p.name AS productName, "
                + "    o.order_id, "
                + "    u.fullname AS customerName, u.phone AS customerPhone, "
                + "    s.supplier_name, s.phone AS supplierPhone, s.email AS supplierEmail "
                + "FROM Product_units pu "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "LEFT JOIN Shipment_units shu ON pu.unit_id = shu.unit_id "
                + "LEFT JOIN Shipment_lines sl ON shu.line_id = sl.line_id "
                + "LEFT JOIN Shipments sh ON sl.shipment_id = sh.shipment_id "
                + "LEFT JOIN Orders o ON sh.order_id = o.order_id "
                + "LEFT JOIN Users u ON o.user_id = u.user_id "
                + "LEFT JOIN Receipt_units ru ON pu.unit_id = ru.unit_id "
                + "LEFT JOIN Receipt_lines rl ON ru.line_id = rl.line_id "
                + "LEFT JOIN Receipts r ON rl.receipt_id = r.receipts_id "
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id "
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id "
                + "WHERE pu.imei = ? AND pu.status = 'SOLD'";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
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
        return dto;
    }

    // Hàm 2: Xử lý trả hàng (Dùng Transaction)
    public boolean processReturn(int unitId, int orderId, int createdBy, String reason, String note) throws Exception {
        PreparedStatement psReturn = null;
        PreparedStatement psReturnLine = null;
        PreparedStatement psUpdateUnit = null;
        ResultSet rsReturn = null;
        String sqlReturn = "INSERT INTO Returns (return_no, order_id, created_by, status, note) VALUES (?, ?, ?, 'OPEN', ?)";
        String sqlReturnLine = "INSERT INTO Return_lines (return_id, unit_id, reason) VALUES (?, ?, ?)";
        String sqlUpdateUnit = "UPDATE Product_units SET status = 'RETURNED', updated_at = SYSUTCDATETIME() WHERE unit_id = ?";
        try {
            Connection conn = this.connection;
            conn.setAutoCommit(false); // Bắt đầu Transaction
            String returnNo = "RT-" + System.currentTimeMillis();
            psReturn = conn.prepareStatement(sqlReturn, Statement.RETURN_GENERATED_KEYS);
            psReturn.setString(1, returnNo);
            psReturn.setInt(2, orderId);
            psReturn.setInt(3, createdBy);
            psReturn.setString(4, note);
            psReturn.executeUpdate();
            rsReturn = psReturn.getGeneratedKeys();
            if (!rsReturn.next()) {
                throw new Exception("Không thể tạo phiếu trả hàng (Returns).");
            }
            int returnId = rsReturn.getInt(1);
            psReturnLine = conn.prepareStatement(sqlReturnLine);
            psReturnLine.setInt(1, returnId);
            psReturnLine.setInt(2, unitId);
            psReturnLine.setString(3, reason);
            psReturnLine.executeUpdate();
            psUpdateUnit = conn.prepareStatement(sqlUpdateUnit);
            psUpdateUnit.setInt(1, unitId);
            int affectedRows = psUpdateUnit.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Không thể cập nhật trạng thái IMEI.");
            }
            this.connection.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (this.connection != null) {
                this.connection.rollback();
            }
            throw e;
        } finally {
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Hàm 3 (ĐÃ SỬA LỖI SQL): Lấy Lịch sử Trả hàng
    public List<ReturnHistoryDTO> getReturnHistory() throws Exception {
        List<ReturnHistoryDTO> list = new ArrayList<>();
        String query = "SELECT "
                + "    r.return_no, r.created_at AS returnDate, r.status, "
                + "    u.fullname AS customerName, "
                + "    pu.imei, p.name AS productName "
                + "FROM Returns r "
                + "JOIN Return_lines rl ON r.return_id = rl.return_id "
                + "JOIN Orders o ON r.order_id = o.order_id "
                + // Sửa: Lấy đơn hàng
                "JOIN Users u ON o.user_id = u.user_id "
                + // Sửa: Lấy khách hàng từ đơn hàng
                "JOIN Product_units pu ON rl.unit_id = pu.unit_id "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "ORDER BY r.created_at DESC";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
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

    // Hàm 4: Đóng kết nối
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
