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

    public List<Response_ShipmentDTO> list_shipment()
    {
        List<Response_ShipmentDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("");
        return list;
    }
}
