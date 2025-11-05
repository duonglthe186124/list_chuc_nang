/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class UpdateShipDAO extends DBContext {

    public int getProductIdByShipmentId(int shipmentId) throws SQLException {
        String sql = """
        SELECT sl.product_id
        FROM Shipment_lines sl
        LEFT JOIN Shipments s ON sl.shipment_id = s.shipment_id
        WHERE s.shipment_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shipmentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("product_id");
                } else {
                    throw new SQLException("Không tìm thấy product_id cho shipment_id: " + shipmentId);
                }
            }

        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy product_id từ shipment_id: " + e.getMessage(), e);
        }
    }
    
    
        public int getOrderIdByShipmentId(int shipmentId) throws SQLException {
        String sql = """
        select s.order_id  from Shipments s
        where s.shipment_id = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shipmentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("order_id");
                } else {
                    throw new SQLException("Không tìm thấy order_id cho shipment_id: " + shipmentId);
                }
            }

        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy order_id từ shipment_id: " + e.getMessage(), e);
        }
    }
        
        
    public void updateShipmentStatusAndNote(int shipmentId, String shipmentStatus, String shipmentNote) throws SQLException {
    String sql = "UPDATE Shipments SET [status] = ?, note = ? WHERE shipment_id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, shipmentStatus);

        if (shipmentNote == null || shipmentNote.trim().isEmpty()) {
            ps.setNull(2, java.sql.Types.VARCHAR);  // note có thể null
        } else {
            ps.setString(2, shipmentNote.trim());
        }

        ps.setInt(3, shipmentId);

        int rows = ps.executeUpdate();
        if (rows == 0) {
            throw new SQLException("Không tìm thấy shipment_id: " + shipmentId);
        }

    } catch (SQLException e) {
        throw new SQLException("Lỗi khi cập nhật status và note cho shipment_id " + shipmentId + ": " + e.getMessage(), e);
    }
}
    
    public void updateOrderStatusIfShipmentFinalized(int orderId, String shipmentStatus) throws SQLException {
    // chỉ update nếu shipment đã hoàn tất hoặc bị hủy
    if (!"SHIPPED".equalsIgnoreCase(shipmentStatus) && !"CANCELLED".equalsIgnoreCase(shipmentStatus)) {
        return; // không làm gì cả
    }

    String sql = "UPDATE Orders SET [status] = ? WHERE order_id = ?";

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, shipmentStatus.trim());
        ps.setInt(2, orderId);

        int rows = ps.executeUpdate();
        if (rows == 0) {
            throw new SQLException("Không tìm thấy order_id: " + orderId);
        }

    } catch (SQLException e) {
        throw new SQLException("Lỗi khi cập nhật status cho order_id " + orderId + ": " + e.getMessage(), e);
    }
}
    
    public void resetQtyIfShipmentCancelled() throws SQLException {
    String sql = """
        UPDATE sl
        SET sl.qty = 0
        FROM Shipment_lines sl
        JOIN Shipments s ON sl.shipment_id = s.shipment_id
        WHERE s.status = 'CANCELLED';
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        int rows = ps.executeUpdate();
        System.out.println("Đã set qty = 0 cho " + rows + " dòng Shipment_lines có shipment bị CANCELLED.");
    }
}

    
    public void restoreAvailableUnits(int productId, int qty) throws SQLException {
    String sql = """
        UPDATE TOP (?) Product_units
        SET status = 'AVAILABLE'
        WHERE product_id = ?
          AND status <> 'AVAILABLE';
    """;

    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, qty);
        ps.setInt(2, productId);
        int rows = ps.executeUpdate();
        System.out.println("Đã khôi phục " + rows + " units của product_id=" + productId + " về AVAILABLE.");
    }
}


    
    
    
    
}
