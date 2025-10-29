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
        String sql = "SELECT \n"
                + "    wl.*,\n"
                + "    COUNT(pu.unit_id) AS current_quantity\n"
                + "FROM Warehouse_locations AS wl\n"
                + "LEFT JOIN Containers AS c\n"
                + "    ON c.location_id = wl.location_id\n"
                + "LEFT JOIN Product_units AS pu\n"
                + "    ON pu.container_id = c.container_id\n"
                + "    AND pu.status = 'AVAILABLE'\n"
                + "GROUP BY \n"
                + "    wl.location_id,\n"
                + "    wl.code,\n"
                + "    wl.area,\n"
                + "    wl.aisle,\n"
                + "    wl.slot,\n"
                + "    wl.capacity,\n"
                + "    wl.description,\n"
                + "    wl.created_at\n"
                + "ORDER BY wl.location_id;";

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
                            rs.getInt("current_quantity"),
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

    // Lấy tất cả vị trí kho
    public List<Warehouse_locations> getAllLocationsHR() {
        List<Warehouse_locations> list = new ArrayList<>();
        String query = "SELECT location_id, code, area, aisle, slot, capacity, description FROM Warehouse_locations";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(query);
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
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // Thêm vị trí mới
    public boolean addLocation(Warehouse_locations loc) {
        String query = "INSERT INTO Warehouse_locations (code, area, aisle, slot, capacity, description, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = null;

        try {
            ps = connection.prepareStatement(query);
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
                if (ps != null) {
                    ps.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }
}
