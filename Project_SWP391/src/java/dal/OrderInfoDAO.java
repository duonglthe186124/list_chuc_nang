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
