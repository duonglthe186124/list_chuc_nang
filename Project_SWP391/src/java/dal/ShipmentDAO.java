package dal;

import dto.Response_ShipmentDTO;
import model.Shipments;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Shipment_lines;
import util.DBContext;

/**
 *
 * @author ASUS
 */
public class ShipmentDAO extends DBContext {

    public List<Response_ShipmentDTO> shipment_list(String search, String status, int size, int offset) {
        List<Response_ShipmentDTO> list = new ArrayList();
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT\n"
                + "    s.shipment_id,\n"
                + "    s.shipment_no,\n"
                + "    o.order_id,\n"
                + "    u.fullname AS customer,\n"
                + "    COUNT(sl.line_id) AS total_line,\n"
                + "    SUM(sl.qty) AS total_shipped,\n"
                + "    o.total_amount AS total,\n"
                + "    creator.fullname AS created_by,\n"
                + "    s.requested_at AS created_at,\n"
                + "    s.status\n"
                + "FROM Shipments s\n"
                + "JOIN Orders o ON s.order_id = o.order_id\n"
                + "JOIN Users u ON o.user_id = u.user_id\n"
                + "JOIN Employees e ON s.created_by = e.employee_id\n"
                + "JOIN Users creator ON e.user_id = creator.user_id\n"
                + "LEFT JOIN Shipment_lines sl ON s.shipment_id = sl.shipment_id\n"
                + "WHERE 1 = 1 ");

        if (search != null) {
            sql.append("AND (s.shipment_no LIKE ? OR o.order_id LIKE ? ) ");
            params.add(search);
            params.add(search);
        }

        if (status != null) {
            sql.append("AND s.status = ? ");
            params.add(status);
        }

        sql.append("GROUP BY\n"
                + "    s.shipment_id,\n"
                + "    s.shipment_no,\n"
                + "    o.order_id,\n"
                + "    u.fullname,\n"
                + "    o.total_amount,\n"
                + "    creator.fullname,\n"
                + "    s.requested_at,\n"
                + "    s.status\n"
                + "ORDER BY s.requested_at DESC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(size);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ShipmentDTO line = new Response_ShipmentDTO(
                            rs.getInt("shipment_id"),
                            rs.getString("shipment_no"),
                            rs.getInt("order_id"),
                            rs.getString("customer"),
                            rs.getInt("total_line"),
                            rs.getInt("total_shipped"),
                            rs.getFloat("total"),
                            rs.getString("created_by"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getString("status")
                    );
                    list.add(line);
                }
            }

            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int total_items(String search, String status) {
        int items = 0;
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT\n"
                + "	COUNT(s.shipment_id) AS total_items\n"
                + "FROM Shipments s\n"
                + "WHERE 1 = 1 ");

        if (search != null) {
            sql.append("AND (s.shipment_no LIKE ? OR o.order_id LIKE ? ) ");
            params.add(search);
            params.add(search);
        }

        if (status != null) {
            sql.append("AND s.status = ? ");
            params.add(status);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    items = rs.getInt("total_items");
                }
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public int add_shipment_head(Shipments head) {
        int shipment_id = 0;
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO Shipments(shipment_no, order_id, created_by, note)\n"
                + "VALUES(?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, head.getShipment_no());
            ps.setInt(2, head.getUser_id());
            ps.setInt(3, head.getCreated_by());
            ps.setString(4, head.getNote());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        shipment_id = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shipment_id;
    }

    public int add_shipment_line(Shipment_lines object) {
        int shipment_line = 0;
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO Shipment_lines(shipment_id, product_id, qty)\n"
                + "VALUES(?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, object.getShipment_id());
            ps.setInt(2, object.getProduct_id());
            ps.setInt(3, object.getQty());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        shipment_line = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shipment_line;
    }

    public List<Response_ShipmentDTO> list_shipment() {
        List<Response_ShipmentDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("");
        return list;
    }
}
