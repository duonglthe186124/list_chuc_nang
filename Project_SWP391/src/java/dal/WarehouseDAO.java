/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dto.InventoryDetailDTO;
import model.Brands;
import util.DBContext;

public class WarehouseDAO extends DBContext {

    // Constructor kiểm tra kết nối
    public WarehouseDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi WarehouseDAO: Không thể kết nối CSDL.");
        }
    }

    // Hàm 1: Đếm tổng số IMEI khớp với bộ lọc (cho phân trang)
    public int getDetailedStockCount(String productName, int brandId) throws Exception {
        List<Object> params = new ArrayList<>();
        int total = 0;
        String query = "SELECT COUNT(pu.unit_id) "
                + "FROM Product_units pu "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "WHERE 1=1 ";
        if (productName != null && !productName.trim().isEmpty()) {
            query += " AND p.name LIKE ? ";
            params.add("%" + productName + "%");
        }
        if (brandId > 0) {
            query += " AND p.brand_id = ? ";
            params.add(brandId);
        }
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi đếm: " + e.getMessage());
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

    // Hàm 2: Lấy Tồn kho Chi tiết CÓ LỌC và PHÂN TRANG
    public List<InventoryDetailDTO> getDetailedStockPaginated(String productName, String imei, int brandId, int pageIndex, int pageSize) throws Exception {
        List<InventoryDetailDTO> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        String query = "SELECT "
                + "    pu.unit_id, pu.imei, pu.status, pu.purchase_price, pu.received_date, "
                + "    p.name AS productName, "
                + "    wl.code AS locationCode, "
                + "    s.supplier_name, "
                + "    latest_qi.inspected_at AS lastInspectionDate, "
                + "    e_ins.fullname AS inspectorName, "
                + "    sh.requested_at AS issueDate "
                + "FROM Product_units pu "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "LEFT JOIN Brands b ON p.brand_id = b.brand_id "
                + "LEFT JOIN Containers c ON pu.container_id = c.container_id "
                + "LEFT JOIN Warehouse_locations wl ON c.location_id = wl.location_id "
                + "LEFT JOIN Receipt_units ru ON pu.unit_id = ru.unit_id "
                + "LEFT JOIN Receipt_lines rl ON ru.line_id = rl.line_id "
                + "LEFT JOIN Receipts r ON rl.receipt_id = r.receipts_id "
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id "
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id "
                + "LEFT JOIN Shipment_units shu ON pu.unit_id = shu.unit_id "
                + "LEFT JOIN Shipment_lines sl ON shu.line_id = sl.line_id "
                + "LEFT JOIN Shipments sh ON sl.shipment_id = sh.shipment_id "
                + "OUTER APPLY ( "
                + "    SELECT TOP 1 qi.inspected_at, qi.inspected_by "
                + "    FROM Quality_Inspections qi "
                + "    WHERE qi.unit_id = pu.unit_id "
                + "    ORDER BY qi.inspected_at DESC "
                + ") AS latest_qi "
                + "LEFT JOIN Employees e ON latest_qi.inspected_by = e.employee_id "
                + "LEFT JOIN Users e_ins ON e.user_id = e_ins.user_id "
                + "WHERE 1=1 ";
        if (productName != null && !productName.trim().isEmpty()) {
            query += " AND p.name LIKE ? ";
            params.add("%" + productName + "%");
        }
        if (imei != null && !imei.trim().isEmpty()) {
            query += " AND pu.imei LIKE ? ";
            params.add("%" + imei + "%");
        }
        if (brandId > 0) {
            query += " AND p.brand_id = ? ";
            params.add(brandId);
        }
        query += " ORDER BY p.name, pu.imei "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((pageIndex - 1) * pageSize);
        params.add(pageSize);
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                InventoryDetailDTO dto = new InventoryDetailDTO();
                dto.setUnitId(rs.getInt("unit_id"));
                dto.setImei(rs.getString("imei"));
                dto.setStatus(rs.getString("status"));
                dto.setPurchasePrice(rs.getBigDecimal("purchase_price"));
                dto.setReceiptDate(rs.getTimestamp("received_date"));
                dto.setProductName(rs.getString("productName"));
                dto.setLocationCode(rs.getString("locationCode"));
                dto.setSupplierName(rs.getString("supplier_name"));
                dto.setLastInspectionDate(rs.getTimestamp("lastInspectionDate"));
                dto.setInspectorName(rs.getString("inspectorName"));
                dto.setIssueDate(rs.getTimestamp("issueDate"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi lấy dữ liệu: " + e.getMessage());
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

    // Hàm 3: Lấy tất cả nhãn hàng (ĐÃ SỬA LỖI TÊN)
    public List<Brands> getAllBrands() throws Exception {
        List<Brands> list = new ArrayList<>();
        String query = "SELECT brand_id, brand_name FROM Brands";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Brands b = new Brands();
                b.setBrand_id(rs.getInt("brand_id"));
                b.setBrand_name(rs.getString("brand_name")); // Sửa lỗi
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Lỗi SQL khi lấy Brand: " + e.getMessage());
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
