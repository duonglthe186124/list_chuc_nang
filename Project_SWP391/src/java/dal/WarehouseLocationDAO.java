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
}

