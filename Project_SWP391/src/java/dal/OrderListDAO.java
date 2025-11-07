package dal;

import dto.OrderList;
import dto.Response_OrderListDTO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class OrderListDAO extends DBContext {
    
    public ArrayList<OrderList> getAllOrders() throws SQLException {
        ArrayList<OrderList> orders = new ArrayList<>();
        String sql = """
                     SELECT 
                       o.order_id AS Order_Number,
                       p.name AS Product_Name,
                       od.qty AS Order_Quantity,            -- theo dòng order detail
                       od.unit_price AS Product_Unit_Price,
                       od.line_amount AS Order_Line_Amount,
                       u1.fullname AS Customer_Fullname,
                       u1.email AS Customer_Email,
                       u1.phone AS Customer_Phone,
                       u1.address AS Customer_Address,
                       o.order_date AS Order_Date,
                       o.status AS Order_Status,
                       s.shipment_id AS Shipment_ID,
                       s.shipment_no,
                       s.requested_at AS Shipment_Date,
                       s.status AS Shipment_Status,
                       s.note AS Shipment_Note,
                       sl.qty AS Shipped_Quantity,
                       u2.fullname AS Shipper_Fullname,
                       u2.email AS Shipper_Email,
                       u2.phone AS Shipper_Phone
                     FROM Order_details od
                     JOIN Product_units pu ON od.unit_id = pu.unit_id
                     JOIN Products p ON pu.product_id = p.product_id
                     JOIN Orders o ON od.order_id = o.order_id
                     JOIN Users u1 ON o.user_id = u1.user_id
                     
                     LEFT JOIN Shipment_units su ON pu.unit_id = su.unit_id
                     LEFT JOIN Shipment_lines sl ON su.line_id = sl.line_id
                     LEFT JOIN Shipments s ON sl.shipment_id = s.shipment_id AND s.order_id = o.order_id
                     LEFT JOIN Employees e ON s.created_by = e.employee_id
                     LEFT JOIN Users u2 ON e.user_id = u2.user_id
                     GROUP BY o.order_id, p.name, od.qty, od.line_amount, od.unit_price, u1.fullname, u1.email, u1.phone, u1.address, o.order_date, o.status, s.shipment_id, s.shipment_no, s.requested_at, s.status, s.note, sl.qty, u2.fullname, u2.email, u2.phone ORDER BY o.order_id, p.name;""";
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
        String sql = """
                     SELECT 
                       o.order_id AS Order_Number,
                       p.name AS Product_Name,
                       od.qty AS Order_Quantity,            -- theo dòng order detail
                       od.unit_price AS Product_Unit_Price,
                       od.line_amount AS Order_Line_Amount,
                       u1.fullname AS Customer_Fullname,
                       u1.email AS Customer_Email,
                       u1.phone AS Customer_Phone,
                       u1.address AS Customer_Address,
                       o.order_date AS Order_Date,
                       o.status AS Order_Status,
                       s.shipment_id AS Shipment_ID,
                       s.shipment_no,
                       s.requested_at AS Shipment_Date,
                       s.status AS Shipment_Status,
                       s.note AS Shipment_Note,
                       sl.qty AS Shipped_Quantity,
                       u2.fullname AS Shipper_Fullname,
                       u2.email AS Shipper_Email,
                       u2.phone AS Shipper_Phone
                     FROM Order_details od
                     JOIN Product_units pu ON od.unit_id = pu.unit_id
                     JOIN Products p ON pu.product_id = p.product_id
                     JOIN Orders o ON od.order_id = o.order_id
                     JOIN Users u1 ON o.user_id = u1.user_id
                     LEFT JOIN Shipment_units su ON pu.unit_id = su.unit_id
                     LEFT JOIN Shipment_lines sl ON su.line_id = sl.line_id
                     LEFT JOIN Shipments s ON sl.shipment_id = s.shipment_id AND s.order_id = o.order_id
                     LEFT JOIN Employees e ON s.created_by = e.employee_id
                     LEFT JOIN Users u2 ON e.user_id = u2.user_id
                     WHERE u1.user_id = ?  or e.user_id = ?
                     GROUP BY o.order_id, p.name, od.qty, od.line_amount, od.unit_price, u1.fullname, u1.email, u1.phone, u1.address, o.order_date, o.status, s.shipment_id, s.shipment_no, s.requested_at, s.status, s.note, sl.qty, u2.fullname, u2.email, u2.phone ORDER BY o.order_id, p.name;""";
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
    
    public ArrayList<OrderList> getAllOrdersByPage(int pageIndex, int pageSize) throws SQLException {
        ArrayList<OrderList> allOrders = getAllOrders();
        ArrayList<OrderList> pageOrders = new ArrayList<>();
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(start + pageSize, allOrders.size());
        for (int i = start; i < end; i++) {
            pageOrders.add(allOrders.get(i));
        }
        return pageOrders;
    }
    
    public ArrayList<OrderList> getOrdersByUserIdPage(int userId, int pageIndex, int pageSize) throws SQLException {
        ArrayList<OrderList> allOrders = getOrdersByUserId(userId);
        ArrayList<OrderList> pageOrders = new ArrayList<>();
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(start + pageSize, allOrders.size());
        for (int i = start; i < end; i++) {
            pageOrders.add(allOrders.get(i));
        }
        return pageOrders;
    }
    
    public int countAllOrders() throws SQLException {
        return getAllOrders().size();
    }
    
    public int countOrdersByUserId(int userId) throws SQLException {
        return getOrdersByUserId(userId).size();
    }
    
    public ArrayList<OrderList> getAllOrdersSorted(String sortBy) throws SQLException {
        ArrayList<OrderList> allOrders = getAllOrders();
        allOrders.sort((o1, o2) -> {
            switch (sortBy) {
                case "Lowest order price":
                    return o1.getOrderAmount().compareTo(o2.getOrderAmount());
                case "Highest order price":
                    return o2.getOrderAmount().compareTo(o1.getOrderAmount());
                case "Earliest orders":
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "Latest orders":
                    return o2.getOrderDate().compareTo(o1.getOrderDate());
                case "Lowest quantity":
                    return Integer.compare(o1.getOrderQuantity(), o2.getOrderQuantity());
                case "Highest quantity":
                    return Integer.compare(o2.getOrderQuantity(), o1.getOrderQuantity());
                case "PENDING":
                    int pending1 = "PENDING".equals(o1.getOrderStatus()) ? 0 : 1;
                    int pending2 = "PENDING".equals(o2.getOrderStatus()) ? 0 : 1;
                    int pendingCompare = Integer.compare(pending1, pending2);
                    if (pendingCompare != 0) {
                        return pendingCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "CONFIRMED":
                    int confirmed1 = "CONFIRMED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int confirmed2 = "CONFIRMED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int confirmedCompare = Integer.compare(confirmed1, confirmed2);
                    if (confirmedCompare != 0) {
                        return confirmedCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "SHIPPED":
                    int shipped1 = "SHIPPED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int shipped2 = "SHIPPED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int shippedCompare = Integer.compare(shipped1, shipped2);
                    if (shippedCompare != 0) {
                        return shippedCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "CANCELLED":
                    int cancelled1 = "CANCELLED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int cancelled2 = "CANCELLED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int cancelledCompare = Integer.compare(cancelled1, cancelled2);
                    if (cancelledCompare != 0) {
                        return cancelledCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                default:
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
            }
        });
        return allOrders;
    }
    
    public ArrayList<OrderList> getOrdersByUserIdSorted(int userId, String sortBy) throws SQLException {
        ArrayList<OrderList> allOrders = getOrdersByUserId(userId);
        allOrders.sort((o1, o2) -> {
            switch (sortBy) {
                case "Lowest order price":
                    return o1.getOrderAmount().compareTo(o2.getOrderAmount());
                case "Highest order price":
                    return o2.getOrderAmount().compareTo(o1.getOrderAmount());
                case "Earliest orders":
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "Latest orders":
                    return o2.getOrderDate().compareTo(o1.getOrderDate());
                case "Lowest quantity":
                    return Integer.compare(o1.getOrderQuantity(), o2.getOrderQuantity());
                case "Highest quantity":
                    return Integer.compare(o2.getOrderQuantity(), o1.getOrderQuantity());
                case "PENDING":
                    int pending1 = "PENDING".equals(o1.getOrderStatus()) ? 0 : 1;
                    int pending2 = "PENDING".equals(o2.getOrderStatus()) ? 0 : 1;
                    int pendingCompare = Integer.compare(pending1, pending2);
                    if (pendingCompare != 0) {
                        return pendingCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "CONFIRMED":
                    int confirmed1 = "CONFIRMED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int confirmed2 = "CONFIRMED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int confirmedCompare = Integer.compare(confirmed1, confirmed2);
                    if (confirmedCompare != 0) {
                        return confirmedCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "SHIPPED":
                    int shipped1 = "SHIPPED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int shipped2 = "SHIPPED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int shippedCompare = Integer.compare(shipped1, shipped2);
                    if (shippedCompare != 0) {
                        return shippedCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                case "CANCELLED":
                    int cancelled1 = "CANCELLED".equals(o1.getOrderStatus()) ? 0 : 1;
                    int cancelled2 = "CANCELLED".equals(o2.getOrderStatus()) ? 0 : 1;
                    int cancelledCompare = Integer.compare(cancelled1, cancelled2);
                    if (cancelledCompare != 0) {
                        return cancelledCompare;
                    }
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
                default:
                    return o1.getOrderDate().compareTo(o2.getOrderDate());
            }
        });
        return allOrders;
    }
    
    public ArrayList<OrderList> getAllOrdersByPageSorted(int pageIndex, int pageSize, String sortBy) throws SQLException {
        ArrayList<OrderList> allOrders = getAllOrdersSorted(sortBy);
        ArrayList<OrderList> pageOrders = new ArrayList<>();
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(start + pageSize, allOrders.size());
        for (int i = start; i < end; i++) {
            pageOrders.add(allOrders.get(i));
        }
        return pageOrders;
    }
    
    public ArrayList<OrderList> getOrdersByUserIdPageSorted(int userId, int pageIndex, int pageSize, String sortBy) throws SQLException {
        ArrayList<OrderList> allOrders = getOrdersByUserIdSorted(userId, sortBy);
        ArrayList<OrderList> pageOrders = new ArrayList<>();
        int start = (pageIndex - 1) * pageSize;
        int end = Math.min(start + pageSize, allOrders.size());
        for (int i = start; i < end; i++) {
            pageOrders.add(allOrders.get(i));
        }
        return pageOrders;
    }
    
    private OrderList mapResultSet(ResultSet rs) throws SQLException {
        OrderList order = new OrderList();
        order.setOrderNumber(rs.getInt("Order_Number") == 0 && rs.wasNull() ? null : rs.getInt("Order_Number"));
        order.setOrderQuantity(rs.getInt("Order_Quantity") == 0 && rs.wasNull() ? null : rs.getInt("Order_Quantity"));
        order.setShipMentId(rs.getInt("Shipment_ID") == 0 && rs.wasNull() ? null : rs.getInt("Shipment_ID"));
        order.setShippedQuantity(rs.getInt("Shipped_Quantity") == 0 && rs.wasNull() ? null : rs.getInt("Shipped_Quantity"));
        order.setProductName(rs.getString("Product_Name"));
        order.setCusName(rs.getString("Customer_Fullname"));
        order.setCusEmail(rs.getString("Customer_Email"));
        order.setCusPhone(rs.getString("Customer_Phone"));
        order.setCusAddress(rs.getString("Customer_Address"));
        order.setOrderDate(rs.getTimestamp("Order_Date"));
        order.setOrderStatus(rs.getString("Order_Status"));
        order.setShipmentDate(rs.getTimestamp("Shipment_Date"));
        order.setShipmentStatus(rs.getString("Shipment_Status"));
        order.setShipmentNote(rs.getString("Shipment_Note"));
        order.setShipperName(rs.getString("Shipper_Fullname"));
        order.setShipperEmail(rs.getString("Shipper_Email"));
        order.setShipperPhone(rs.getString("Shipper_Phone"));
        order.setProductUnitPrice(rs.getBigDecimal("Product_Unit_Price"));
        order.setOrderAmount(rs.getBigDecimal("Order_Line_Amount"));
        return order;
    }
    
    public List<Response_OrderListDTO> get_order_details(int order_id) {
        List<Response_OrderListDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "  p.product_id,\n"
                + "  p.sku_code,\n"
                + "  p.name,\n"
                + "  od.unit_price,\n"
                + "  SUM(od.qty) AS qty,\n"
                + "  SUM(od.line_amount) AS total_price\n"
                + "FROM Order_details od\n"
                + "LEFT JOIN Product_units pu ON od.unit_id = pu.unit_id\n"
                + "LEFT JOIN Products p ON pu.product_id = p.product_id\n"
                + "WHERE od.order_id = ?\n"
                + "GROUP BY p.product_id, p.sku_code, p.name, od.unit_price\n"
                + "ORDER BY p.product_id, od.unit_price;");
        
        try(PreparedStatement ps = connection.prepareStatement(sql.toString()))
        {
            ps.setInt(1, order_id);
            
            try(ResultSet rs = ps.executeQuery())
            {
                while(rs.next())
                {
                    Response_OrderListDTO line = new Response_OrderListDTO(
                                rs.getInt("product_id"),
                                rs.getString("sku_code"),
                                rs.getString("name"),
                                rs.getFloat("unit_price"),
                                rs.getInt("qty"),
                                rs.getFloat("total_price"));
                    list.add(line);
                }
            }
        }
        catch(SQLException e)
        {
            e.printStackTrace();
        }
        return list;
    }
}
