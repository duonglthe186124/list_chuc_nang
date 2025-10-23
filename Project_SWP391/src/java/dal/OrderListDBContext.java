/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.OrderList;
import java.util.ArrayList;
import util.DBContext;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class OrderListDBContext extends DBContext {

    public ArrayList<OrderList> getAllOrders() throws SQLException {
        ArrayList<OrderList> orders = new ArrayList<>();
        String sql = "SELECT od.order_no AS Order_Number, p.name AS Product_Name, od.qty AS Order_Quantity, "
                + "od.unit_price AS Product_Unit_Price, od.line_amount AS Order_Line_Amount, "
                + "u1.fullname AS Customer_Fullname, u1.email AS Customer_Email, u1.phone AS Customer_Phone, "
                + "u1.address AS Customer_Address, o.order_date AS Order_Date, o.status AS Order_Status, "
                + "sl.shipment_id AS Shipment_ID, s.requested_at AS Shipment_Date, s.status AS Shipment_Status, "
                + "s.note AS Shipment_Note, sl.qty AS Shipped_Quantity, u2.fullname AS Shipper_Fullname, "
                + "u2.email AS Shipper_Email, u2.phone AS Shipper_Phone "
                + "FROM Order_details od "
                + "INNER JOIN Product_units pu ON od.unit_id = pu.unit_id "
                + "INNER JOIN Products p ON pu.product_id = p.product_id "
                + "INNER JOIN Orders o ON od.order_id = o.order_id "
                + "INNER JOIN Users u1 ON o.user_id = u1.user_id "
                + "INNER JOIN Shipment_units su ON pu.unit_id = su.unit_id "
                + "INNER JOIN Shipment_lines sl ON su.line_id = sl.line_id "
                + "INNER JOIN Shipments s ON sl.shipment_id = s.shipment_id "
                + "INNER JOIN Employees e ON s.created_by = e.employee_id "
                + "INNER JOIN Users u2 ON e.user_id = u2.user_id";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();

        try {
            while (rs.next()) {
                OrderList order = mapResultSet(rs);
                orders.add(order);
            }
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return orders;
    }

    public ArrayList<OrderList> getOrdersByUserId(int userId) throws SQLException {
        ArrayList<OrderList> orders = new ArrayList<>();
        String sql = "SELECT od.order_no AS Order_Number, p.name AS Product_Name, od.qty AS Order_Quantity, "
                + "od.unit_price AS Product_Unit_Price, od.line_amount AS Order_Line_Amount, "
                + "u1.fullname AS Customer_Fullname, u1.email AS Customer_Email, u1.phone AS Customer_Phone, "
                + "u1.address AS Customer_Address, o.order_date AS Order_Date, o.status AS Order_Status, "
                + "sl.shipment_id AS Shipment_ID, s.requested_at AS Shipment_Date, s.status AS Shipment_Status, "
                + "s.note AS Shipment_Note, sl.qty AS Shipped_Quantity, u2.fullname AS Shipper_Fullname, "
                + "u2.email AS Shipper_Email, u2.phone AS Shipper_Phone "
                + "FROM Order_details od "
                + "INNER JOIN Product_units pu ON od.unit_id = pu.unit_id "
                + "INNER JOIN Products p ON pu.product_id = p.product_id "
                + "INNER JOIN Orders o ON od.order_id = o.order_id "
                + "INNER JOIN Users u1 ON o.user_id = u1.user_id "
                + "INNER JOIN Shipment_units su ON pu.unit_id = su.unit_id "
                + "INNER JOIN Shipment_lines sl ON su.line_id = sl.line_id "
                + "INNER JOIN Shipments s ON sl.shipment_id = s.shipment_id "
                + "INNER JOIN Employees e ON s.created_by = e.employee_id "
                + "INNER JOIN Users u2 ON e.user_id = u2.user_id "
                + "WHERE u1.user_id = ? OR e.user_id = ?";
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, userId); 
        stm.setInt(2, userId); 
        ResultSet rs = stm.executeQuery();

        try {
            while (rs.next()) {
                OrderList order = mapResultSet(rs);
                orders.add(order);
            }
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return orders;
    }

    private OrderList mapResultSet(ResultSet rs) throws SQLException {
        OrderList order = new OrderList();
        order.setOrderNumber(rs.getInt("Order_Number"));
        order.setProductName(rs.getString("Product_Name"));
        order.setOrderQuantity(rs.getInt("Order_Quantity"));
        order.setProductUnitPrice(rs.getBigDecimal("Product_Unit_Price"));
        order.setOrderAmount(rs.getBigDecimal("Order_Line_Amount")); 
        order.setCusName(rs.getString("Customer_Fullname")); 
        order.setCusEmail(rs.getString("Customer_Email")); 
        order.setCusPhone(rs.getString("Customer_Phone")); 
        order.setCusAddress(rs.getString("Customer_Address")); 
        order.setOrderDate(rs.getTimestamp("Order_Date"));
        order.setOrderStatus(rs.getString("Order_Status"));
        order.setShipmentDate(rs.getTimestamp("Shipment_Date"));
        order.setShipmentStatus(rs.getString("Shipment_Status"));
        order.setShipmentNote(rs.getString("Shipment_Note"));
        order.setShippedQuantity(rs.getInt("Shipped_Quantity"));
        order.setShipperName(rs.getString("Shipper_Fullname")); 
        order.setShipperEmail(rs.getString("Shipper_Email")); 
        order.setShipperPhone(rs.getString("Shipper_Phone"));
        return order;
    }
}
