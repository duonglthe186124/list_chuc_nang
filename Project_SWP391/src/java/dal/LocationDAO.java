/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */

import dal.DBContext;
import java.sql.*;
import java.util.*;
import model.Warehouse_locations;

public class LocationDAO extends DBContext {

    public List<Warehouse_locations> listAll() throws SQLException {
        List<Warehouse_locations> list = new ArrayList<>();
        String sql = "SELECT location_id, code, area, ailse, slot, max_capacity, current_capacity, description FROM Warehouse_locations";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Warehouse_locations w = new Warehouse_locations(
                    rs.getInt("location_id"),
                    rs.getString("code"),
                    rs.getString("area"),
                    rs.getString("ailse"),
                    rs.getString("slot"),
                    rs.getInt("max_capacity"),
                    rs.getInt("current_capacity"),
                    rs.getString("description")
                );
                list.add(w);
            }
        }
        return list;
    }
}