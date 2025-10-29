package dal;

import model.Warehouse_locations;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBContext;

public class WarehouseLocationDAO extends DBContext {

    public List<Warehouse_locations> getAllLocations() {
        List<Warehouse_locations> list = new ArrayList<>();
        String sql = "SELECT location_id, code, area, aisle, slot, capacity, description FROM Warehouse_locations ORDER BY location_id";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Warehouse_locations loc = new Warehouse_locations(
                            rs.getInt("location_id"),
                            rs.getString("code"),
                            rs.getString("area"),
                            rs.getString("aisle"),
                            rs.getString("slot"),
                            rs.getInt("capacity"),
                            rs.getString("description"),
                            null
                    );
                    list.add(loc);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

public class WarehouseLocationDAO extends DBContext {

    // Lấy tất cả vị trí kho
    public List<Warehouse_locations> getAllLocations() {
        List<Warehouse_locations> list = new ArrayList<>();
        String query = "SELECT location_id, code, area, aisle, slot, capacity, description FROM Warehouse_locations";
        Connection conn = this.connection;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                Warehouse_locations loc = new Warehouse_locations();
                loc.setLocation_id(rs.getInt("location_id"));
                loc.setCode(rs.getString("code"));
                loc.setArea(rs.getString("area"));
                loc.setAisle(rs.getString("aisle"));
                loc.setSlot(rs.getString("slot"));
                loc.setCapacity(rs.getInt("capacity"));
                loc.setDescription(rs.getString("description"));
                list.add(loc);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return list;
    }

    // Thêm vị trí mới
    public boolean addLocation(Warehouse_locations loc) {
        String query = "INSERT INTO Warehouse_locations (code, area, aisle, slot, capacity, description, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = this.connection;
        PreparedStatement ps = null;

        try {
            ps = conn.prepareStatement(query);
            // ĐÃ SỬA: Dùng đúng getter
            ps.setString(1, loc.getCode());
            ps.setString(2, loc.getArea());
            ps.setString(3, loc.getAisle());
            ps.setString(4, loc.getSlot());
            ps.setInt(5, loc.getCapacity());
            ps.setString(6, loc.getDescription());
            ps.setDate(7, new java.sql.Date(loc.getCreated_at().getTime())); 
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) { e.printStackTrace(); }
        }
        return false;
    }
}
