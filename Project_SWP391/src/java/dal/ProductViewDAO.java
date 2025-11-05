/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ProductViewDTO;
import dto.UnitViewDTO;
import util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class ProductViewDAO extends DBContext{
    
     public ProductViewDTO getProductCommonInfoById(int productId) throws SQLException {
    String sql = """
        SELECT TOP (1)
            p.product_id, p.name, p.sku_code, b.brand_name,
            ps.storage, ps.screen_type, ps.screen_size, ps.memory,
            ps.cpu, ps.color, ps.camera, ps.battery_capacity,
            [pi].image_url, pu.purchase_price
        FROM Products p
        LEFT JOIN Brands b ON p.brand_id = b.brand_id
        LEFT JOIN Product_specs ps ON ps.spec_id = p.spec_id
        LEFT JOIN Product_images [pi] ON [pi].product_id = p.product_id
        LEFT JOIN Product_units pu ON pu.product_id = p.product_id
        WHERE p.product_id = ?
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, productId);
        System.out.println("🔍 Đang truy vấn product_id = " + productId);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                System.out.println("✅ Đã tìm thấy sản phẩm trong DB!");
                // (phần tạo DTO giữ nguyên)
                
                ProductViewDTO product = new ProductViewDTO();
                product.setProductId(rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setSkuCode(rs.getString("sku_code"));
                product.setBrandName(rs.getString("brand_name"));
                product.setStorage(rs.getString("storage"));
                product.setScreenType(rs.getString("screen_type"));
                product.setScreenSize(rs.getBigDecimal("screen_size"));
                product.setMemory(rs.getString("memory"));
                product.setCpu(rs.getString("cpu"));
                product.setColor(rs.getString("color"));
                product.setCamera(rs.getInt("camera"));
                product.setBatteryCapacity(rs.getInt("battery_capacity"));
                product.setImageUrl(rs.getString("image_url"));
                product.setPurchasePrice(rs.getBigDecimal("purchase_price"));

                return product;
            } else {
                System.out.println("⚠️ Không tìm thấy sản phẩm nào có product_id = " + productId);
            }
        }
    } catch (SQLException e) {
        System.out.println("❌ Lỗi SQL: " + e.getMessage());
        throw e;
    }
    return null;
}

     
     
      public List<UnitViewDTO> getUnitsByProductId(int productId) throws SQLException {
        List<UnitViewDTO> list = new ArrayList<>();

        String sql = """
            SELECT unit_id, imei, serial_number, 
                   warranty_start, warranty_end, status
            FROM Product_units
            WHERE product_id = ?
            ORDER BY unit_id
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UnitViewDTO u = new UnitViewDTO();

                    u.setUnitId(rs.getInt("unit_id"));
                    u.setImei(rs.getString("imei"));
                    u.setSerialNumber(rs.getString("serial_number"));
                    u.setWarrantyStart(rs.getTimestamp("warranty_start"));
                    u.setWarrantyEnd(rs.getTimestamp("warranty_end"));
                    u.setStatus(rs.getString("status"));

                    list.add(u);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách unit của product_id=" + productId + ": " + e.getMessage(), e);
        }

        return list;
    }
    
}
