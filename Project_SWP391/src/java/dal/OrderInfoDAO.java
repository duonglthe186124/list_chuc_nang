/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.OrderInfoDTO;
import dto.Response_OrderInfoDTO;
import util.DBContext;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class OrderInfoDAO extends DBContext {

    public OrderInfoDTO getOrderDetailInfo(int orderId) throws SQLException {
        String sql = """
     SELECT 
         o.order_id,
     	p.product_id,
         p.[name] AS product_name,
         SUM(ot.qty) AS total_qty,
         ot.unit_price,
         o.total_amount,
     	u.user_id,
     	u.fullname AS cus_name, u.email AS cus_email, u.phone AS cus_phone, u.address AS cus_address,o.order_date,o.status
     FROM Orders o
     LEFT JOIN Order_details ot ON o.order_id = ot.order_id
     JOIN Product_units pu ON ot.unit_id = pu.unit_id
     JOIN Products p ON pu.product_id = p.product_id
     JOIN Users u ON o.user_id = u.user_id
     where o.order_id = ?
     GROUP BY o.order_id, p.[name], ot.unit_price, o.total_amount, u.fullname, u.email, u.phone, u.address, o.status, p.product_id, u.user_id, o.order_date;
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                OrderInfoDTO dto = new OrderInfoDTO();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setQty(rs.getInt("total_qty"));
                dto.setUnitPrice(rs.getBigDecimal("unit_price"));
                dto.setLineAmount(rs.getBigDecimal("total_amount"));
                dto.setProductId(rs.getInt("product_id"));
                dto.setProductName(rs.getString("product_name"));
                dto.setUserId(rs.getInt("user_id"));
                dto.setCusName(rs.getString("cus_name"));
                dto.setCusEmail(rs.getString("cus_email"));
                dto.setCusPhone(rs.getString("cus_phone"));
                dto.setCusAddress(rs.getString("cus_address"));
                dto.setOrderDate(rs.getTimestamp("order_date"));
                dto.setStatus(rs.getString("status"));
                return dto;
            }
        }
        return null;
    }

    public List<Integer> getSoldUnitIdsForShipment(int productId, int qty) throws SQLException {
        List<Integer> unitIds = new ArrayList<>();
        String sql = """
        SELECT TOP(?) unit_id 
        FROM Product_units 
        WHERE product_id = ? AND status = 'SOLD'
        ORDER BY unit_id
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    unitIds.add(rs.getInt("unit_id"));
                }
            }
        }
        return unitIds;
    }
    
    
    public List<String> getAllShipmentNos() throws SQLException {
    List<String> list = new ArrayList<>();
    String sql = "SELECT shipment_no FROM Shipments";
    try (PreparedStatement ps = connection.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        while (rs.next()) {
            list.add(rs.getString("shipment_no"));
        }
    }
    return list;
}

    public List<Integer> get_order_id() {
        List<Integer> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT o.order_id FROM Orders o\n"
                + "WHERE o.status = 'CONFIRMED'");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString()); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int line = rs.getInt(1);
                list.add(line);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Response_OrderInfoDTO get_order_info(int order_id) {
        Response_OrderInfoDTO line = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	u.fullname,\n"
                + "	o.order_date,\n"
                + "	o.status,\n"
                + "	COUNT(DISTINCT pu.unit_id) AS line_count,\n"
                + "	SUM(qty) AS total_qty,\n"
                + "	SUM(line_amount) AS total_value\n"
                + "FROM Orders o\n"
                + "LEFT JOIN Users u ON o.user_id = u.user_id\n"
                + "LEFT JOIN Order_details od ON o.order_id = od.order_id\n"
                + "LEFT JOIN Product_units pu ON od.unit_id = pu.unit_id\n"
                + "WHERE o.status = 'CONFIRMED' AND o.order_id = ?\n"
                + "GROUP BY\n"
                + "	u.fullname,\n"
                + "	o.order_date,\n"
                + "	o.status");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, order_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    line = new Response_OrderInfoDTO(
                            rs.getString("fullname"),
                            rs.getObject("order_date", LocalDateTime.class),
                            rs.getString("status"),
                            rs.getInt("line_count"),
                            rs.getInt("total_qty"),
                            rs.getFloat("total_value"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }
}
