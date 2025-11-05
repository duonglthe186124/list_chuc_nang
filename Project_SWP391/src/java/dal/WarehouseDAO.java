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
import util.DBContext; 

public class WarehouseDAO extends DBContext {

    /**
     * Lấy tồn kho của TẤT CẢ sản phẩm bằng cách đếm động
     * @return 
     */
    public List<InventoryStockDTO> getInventoryStock() {
        List<InventoryStockDTO> list = new ArrayList<>();
        
        // Câu SQL này đếm tất cả Product_units có status 'Trong kho'
        // và nhóm theo sản phẩm
        String query = "SELECT " +
                       "    p.product_id, " +
                       "    p.name, " +
                       "    p.sku_code, " +
                       "    COUNT(u.unit_id) as StockQuantity " +
                       "FROM " +
                       "    Products p " +
                       "LEFT JOIN " +
                       "    Product_units u ON p.product_id = u.product_id AND u.status = 'AVAILABLE' " +
                       "GROUP BY " +
                       "    p.product_id, p.name, p.sku_code " +
                       "ORDER BY " +
                       "    p.name;";

        Connection conn = this.connection; 
        if (conn == null) {
            System.err.println("Lỗi: WarehouseDAO không lấy được connection.");
            return list;
        }

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(query);
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
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
}