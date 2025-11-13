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
import dto.InspectionFormDTO; 
import model.Quality_inspections; 
import model.Warehouse_locations; 
import util.DBContext; 

public class QualityInspectionDAO extends DBContext {

    // Constructor (giữ nguyên)
    public QualityInspectionDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi: QualityInspectionDAO không thể kết nối CSDL.");
        }
    }
    
    // HÀM MỚI: JOIN 7 BẢNG ĐỂ LẤY THÔNG TIN CHO FORM
    public InspectionFormDTO getUnitDetailsForInspection(String imei) throws Exception {
        InspectionFormDTO details = null;
        String query = "SELECT " +
            "    pu.unit_id, pu.imei, pu.status, " +
            "    p.sku_code, p.name AS productName, " +
            "    s.supplier_name, s.phone AS supplierPhone, s.email AS supplierEmail " +
            "FROM Product_units pu " +
            "JOIN Products p ON pu.product_id = p.product_id " +
            "LEFT JOIN Receipt_units ru ON pu.unit_id = ru.unit_id " +
            "LEFT JOIN Receipt_lines rl ON ru.line_id = rl.line_id " +
            "LEFT JOIN Receipts r ON rl.receipt_id = r.receipts_id " +
            "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id " +
            "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id " +
            "WHERE pu.imei = ?";
        
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, imei);
            rs = ps.executeQuery();
            if (rs.next()) {
                details = new InspectionFormDTO();
                details.setUnitId(rs.getInt("unit_id"));
                details.setImei(rs.getString("imei"));
                details.setCurrentStatus(rs.getString("status"));
                details.setSkuCode(rs.getString("sku_code"));
                details.setProductName(rs.getString("productName"));
                details.setSupplierName(rs.getString("supplier_name"));
                details.setSupplierPhone(rs.getString("supplierPhone"));
                details.setSupplierEmail(rs.getString("supplierEmail"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            // KHÔNG đóng conn
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return details;
    }

    // Hàm 2: Thêm một phiếu kiểm định mới (Giữ nguyên)
    public boolean addInspection(Quality_inspections inspection) throws Exception {
        String query = "INSERT INTO Quality_Inspections (inspection_no, unit_id, location_id, inspected_by, inspected_at, status, result, note) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, inspection.getInspection_no());
            ps.setInt(2, inspection.getUnit_id());
            ps.setInt(3, inspection.getLocation_id());
            ps.setInt(4, inspection.getInspected_by());
            ps.setTimestamp(5, new java.sql.Timestamp(inspection.getInspected_date().getTime())); // Dùng Timestamp
            ps.setString(6, inspection.getStatus());
            ps.setString(7, inspection.getResult());
            ps.setString(8, inspection.getNote());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                if (ps != null) ps.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
    }
    
    // Hàm 3: Lấy danh sách vị trí kho (Giữ nguyên)
    public List<Warehouse_locations> getAllLocations() throws Exception {
        List<Warehouse_locations> list = new ArrayList<>();
        String query = "SELECT location_id, code FROM Warehouse_locations";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse_locations loc = new Warehouse_locations();
                loc.setLocation_id(rs.getInt("location_id"));
                loc.setCode(rs.getString("code"));
                list.add(loc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return list;
    }

    // Hàm 4: Đóng kết nối (Giữ nguyên)
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
