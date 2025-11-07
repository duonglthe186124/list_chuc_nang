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
import dto.InspectionViewDTO; 
import model.Quality_inspections; 
import model.Warehouse_locations; 
import util.DBContext; 

public class QualityInspectionDAO extends DBContext {

    // Hàm 1: Lấy unit_id (ID của IMEI) từ số IMEI
    public int getUnitIdByImei(String imei) {
        String query = "SELECT product_unit_id FROM Product_units WHERE imei = ?";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int unitId = 0;
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, imei);
            rs = ps.executeQuery();
            if (rs.next()) {
                unitId = rs.getInt("product_unit_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        }
        return unitId;
    }

    // Hàm 2: Thêm một phiếu kiểm định mới
    public boolean addInspection(Quality_inspections inspection) {
        String query = "INSERT INTO Quality_inspections (inspection_no, unit_id, location_id, inspected_by, inspected_date, status, result, note) " +
                       "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, inspection.getInspection_no());
            ps.setInt(2, inspection.getUnit_id());
            ps.setInt(3, inspection.getLocation_id());
            ps.setInt(4, inspection.getInspected_by());
            ps.setDate(5, new java.sql.Date(inspection.getInspected_date().getTime()));
            ps.setString(6, inspection.getStatus());
            ps.setString(7, inspection.getResult());
            ps.setString(8, inspection.getNote());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
    }

    // Hàm 3: Lấy lịch sử kiểm định (dùng JOIN và DTO mới)
    public List<InspectionViewDTO> getAllInspectionsForView() {
        List<InspectionViewDTO> list = new ArrayList<>();
        String query = "SELECT " +
                       "    q.inspection_no, q.inspected_at, q.result, q.note, " +
                       "    pu.imei, p.name as productName, u.fullname as inspectorName, wl.code as locationCode " +
                       "FROM " +
                       "    Quality_inspections q " +
                       "JOIN Product_units pu ON q.unit_id = pu.unit_id " +
                       "JOIN Products p ON pu.product_id = p.product_id " +
                       "JOIN Users u ON q.inspected_by = u.user_id " +
                       "LEFT JOIN Warehouse_locations wl ON q.location_id = wl.location_id " + // LEFT JOIN phòng khi location là null
                       "ORDER BY q.inspected_at DESC";
        
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                InspectionViewDTO dto = new InspectionViewDTO();
                dto.setInspection_no(rs.getString("inspection_no"));
                dto.setInspected_date(rs.getDate("inspected_at"));
                dto.setResult(rs.getString("result"));
                dto.setNote(rs.getString("note"));
                dto.setImei(rs.getString("imei"));
                dto.setProductName(rs.getString("productName"));
                dto.setInspectorName(rs.getString("inspectorName"));
                dto.setLocationCode(rs.getString("locationCode"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return list;
    }
    
    // Hàm 4: Lấy danh sách vị trí kho (để điền vào dropdown)
    public List<Warehouse_locations> getAllLocations() {
        List<Warehouse_locations> list = new ArrayList<>();
        String query = "SELECT location_id, code FROM Warehouse_locations";
        Connection conn = this.connection; // Dùng chung connection
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
        }
        return list;
    }
}