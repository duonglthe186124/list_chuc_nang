/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.util.List;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class CompleteShipDAO extends DBContext{
   public void updateOrderStatus(int orderId, String newStatus) throws SQLException {
        String sql = "UPDATE Orders SET status = ? WHERE order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("Không tìm thấy order_id: " + orderId);
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi cập nhật trạng thái đơn hàng: " + e.getMessage(), e);
        }
    }
   
   
   
     public int insertShipment(int orderId, String shipmentNo, int createdBy) throws SQLException {
        String sql = """
            INSERT INTO Shipments (shipment_no, order_id, created_by)
            VALUES (?, ?, ?)
            """;

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, shipmentNo);
            ps.setInt(2, orderId);
            ps.setInt(3, createdBy);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Trả về shipment_id
                } else {
                    throw new SQLException("Không lấy được shipment_id");
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi thêm shipment mới: " + e.getMessage(), e);
        }
    }
     
     public int insertShipmentLine(int shipmentId, int productId, int qty) throws SQLException {
        String sql = """
            INSERT INTO Shipment_lines (shipment_id, product_id, qty)
            VALUES (?, ?, ?)
            """;

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, shipmentId);
            ps.setInt(2, productId);
            ps.setInt(3, qty);
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // line_id mới được sinh ra (auto increment)
                } else {
                    throw new SQLException("Không lấy được line_id sau khi insert Shipment_line");
                }
            }
        }
    }
     
     
    public void insertShipmentUnits(int lineId, List<Integer> unitIds) throws SQLException {
    if (unitIds == null || unitIds.isEmpty()) return;

    String sql = "INSERT INTO Shipment_units (line_id, unit_id) VALUES (?, ?)";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {

        for (int unitId : unitIds) {
            ps.setInt(1, lineId);
            ps.setInt(2, unitId);
            ps.addBatch();
        }

        int[] results = ps.executeBatch();

        if (results.length != unitIds.size()) {
            throw new SQLException("Insert Shipment_units thất bại: số bản ghi chèn không khớp");
        }

    } catch (SQLException e) {
        throw new SQLException("Lỗi khi thêm Shipment_units: " + e.getMessage(), e);
    }
}
     
     
     
   
   
   
}
