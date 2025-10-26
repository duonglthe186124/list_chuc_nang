/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ProductOrderInfo;
import util.DBContext;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class ProductOrderInfoDAO extends DBContext {

    public ProductOrderInfo getProductOrderInfoById(int productId) throws SQLException {
       
        PreparedStatement stm = null; 
        ResultSet rs = null; 
        ProductOrderInfo product = null; 

        try {
            
          String sql = "SELECT p.[name], pim.image_url, pu.purchase_price, " +
                     "COUNT(CASE WHEN pu.status = 'AVAILABLE' THEN pu.unit_id END) as available_quantity " +
                     "FROM Products p " +
                     "JOIN Product_images pim ON p.product_id = pim.product_id " +
                     "LEFT JOIN Product_units pu ON p.product_id = pu.product_id " +
                     "WHERE p.product_id = ? " +
                     "GROUP BY p.[name], pim.image_url, pu.purchase_price";
        stm = connection.prepareStatement(sql);
        stm.setInt(1, productId);
        rs = stm.executeQuery();

        if (rs.next()) {
            product = new ProductOrderInfo();
            product.setProductName(rs.getString("name"));
            product.setImageUrl(rs.getString("image_url"));
            product.setQuantity(rs.getInt("available_quantity"));
            product.setUnitPrice(rs.getBigDecimal("purchase_price")); 
            // totalAmount chưa tính, để Controller xử lý
        }

        } catch (SQLException e) {
            
            throw new SQLException("Error fetching product order info by ID: " + e.getMessage());
        } finally {
            
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.out.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {
                    System.out.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }

       
        return product;
    }
}
