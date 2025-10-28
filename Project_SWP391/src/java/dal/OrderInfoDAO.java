/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.OrderInfoDTO;
import jakarta.enterprise.concurrent.ContextServiceDefinition.List;
import util.DBContext;
import java.sql.*;
import java.util.ArrayList;

/**
 *
 * @author hoang
 */
public class OrderInfoDAO extends DBContext {

    public OrderInfoDTO getOrderDetailWithRepUnit(int orderId) throws SQLException {
        String sql = """
        SELECT 
            od.order_id, od.order_no, od.qty, od.unit_price, od.line_amount,
            pu.product_id, p.name AS product_name,
            o.user_id AS customer_user_id,
            u.fullname AS cus_name, u.email AS cus_email, u.phone AS cus_phone, u.address AS cus_address,
            o.order_date, o.status,
            rep_unit.unit_id AS representative_unit_id
        FROM Order_details od
        JOIN Product_units pu ON od.unit_id = pu.unit_id
        JOIN Products p ON pu.product_id = p.product_id
        JOIN Orders o ON od.order_id = o.order_id
        JOIN Users u ON o.user_id = u.user_id
        CROSS APPLY (
            SELECT TOP 1 pu2.unit_id
            FROM Product_units pu2
            JOIN Order_details od2 ON pu2.unit_id = od2.unit_id
            WHERE pu2.product_id = pu.product_id
              AND od2.order_id = od.order_id
              AND pu2.status = 'SOLD'
            ORDER BY pu2.unit_id
        ) rep_unit
        WHERE od.order_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OrderInfoDTO dto = new OrderInfoDTO();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setOrderNo(rs.getInt("order_no"));
                dto.setQty(rs.getInt("qty"));
                dto.setUnitPrice(rs.getBigDecimal("unit_price"));
                dto.setLineAmount(rs.getBigDecimal("line_amount"));
                dto.setProductId(rs.getInt("product_id"));
                dto.setProductName(rs.getString("product_name"));
                dto.setUserId(rs.getInt("customer_user_id"));
                dto.setCusName(rs.getString("cus_name"));
                dto.setCusEmail(rs.getString("cus_email"));
                dto.setCusPhone(rs.getString("cus_phone"));
                dto.setCusAddress(rs.getString("cus_address"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setStatus(rs.getString("status"));
                dto.setUnitId(rs.getInt("representative_unit_id")); 
                return dto;
            }
        }
        return null;
    }
    
    
    

}
