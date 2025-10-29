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
import dto.InventoryStockDTO; 
import model.Brands;
import util.DBContext;

public class WarehouseReportDAO extends DBContext {

    /**
     * Hàm 1: Lấy danh sách tồn kho CÓ LỌC
     * @param productName (từ ô tìm kiếm, có thể là "")
     * @param brandId (từ dropdown, 0 = tất cả)
     * @return Danh sách tồn kho đã lọc
     */
    public List<InventoryStockDTO> getFilteredInventoryStock(String productName, int brandId) {
        List<InventoryStockDTO> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        
        // Bắt đầu câu SQL
        String query = "SELECT " +
                       "    p.product_id, p.name, p.sku_code, " +
                       "    COUNT(u.product_unit_id) as StockQuantity " +
                       "FROM " +
                       "    Products p " +
                       "LEFT JOIN " +
                       "    Product_units u ON p.product_id = u.product_id AND u.status = 'Trong kho' " +
                       "WHERE 1=1 "; // Mẹo để dễ dàng thêm AND

        // 1. Thêm bộ lọc theo Tên Sản phẩm (nếu có)
        if (productName != null && !productName.trim().isEmpty()) {
            query += " AND p.name LIKE ? ";
            params.add("%" + productName + "%");
        }
        
        // 2. Thêm bộ lọc theo Nhãn hàng (nếu có)
        if (brandId > 0) {
            query += " AND p.brand_id = ? ";
            params.add(brandId);
        }

        // Kết thúc câu SQL
        query += " GROUP BY p.product_id, p.name, p.sku_code ORDER BY p.name";

        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(query);
            
            // Set các tham số (params) vào câu query
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            rs = ps.executeQuery();
            while (rs.next()) {
                InventoryStockDTO item = new InventoryStockDTO();
                item.setProductId(rs.getInt("product_id"));
                item.setProductName(rs.getString("name"));
                item.setSkuCode(rs.getString("sku_code"));
                item.setStockQuantity(rs.getInt("StockQuantity"));
                list.add(item);
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

    /**
     * Hàm 2: Lấy tất cả nhãn hàng (để điền vào dropdown)
     */
    public List<Brands> getAllBrands() {
        List<Brands> list = new ArrayList<>();
        String query = "SELECT brand_id, name FROM Brands";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Brands b = new Brands();
                b.setBrand_id(rs.getInt("brand_id"));
                b.setBrand_name(rs.getString("brand_name"));
                list.add(b);
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
}