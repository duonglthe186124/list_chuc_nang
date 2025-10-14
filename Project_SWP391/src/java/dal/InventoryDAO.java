/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import util.DBContext;
import java.sql.*;
import java.util.*;
import model.Inventory_records;

public class InventoryDAO extends DBContext {
    public InventoryDAO() { super(); }

    public List<Inventory_records> listAll() throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        List<Inventory_records> list = new ArrayList<>();
        String sql = "SELECT inventory_id, product_id, location_id, qty, last_updated FROM Inventory_records ORDER BY last_updated DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Inventory_records inv = new Inventory_records(
                    rs.getInt("inventory_id"),
                    rs.getInt("product_id"),
                    rs.getInt("location_id"),
                    rs.getInt("qty"),
                    rs.getTimestamp("last_updated")
                );
                list.add(inv);
            }
        }
        return list;
    }

    public Inventory_records findByProductAndLocation(int productId, int locationId) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        String sql = "SELECT inventory_id, product_id, location_id, qty, last_updated FROM Inventory_records WHERE product_id=? AND location_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setInt(2, locationId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Inventory_records(
                        rs.getInt("inventory_id"),
                        rs.getInt("product_id"),
                        rs.getInt("location_id"),
                        rs.getInt("qty"),
                        rs.getTimestamp("last_updated")
                    );
                }
            }
        }
        return null;
    }

    public void addProductToLocation(int productId, int locationId, int qty) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        Inventory_records exists = findByProductAndLocation(productId, locationId);
        if (exists != null) {
            String sql = "UPDATE Inventory_records SET qty = qty + ?, last_updated = GETDATE() WHERE inventory_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, qty);
                ps.setInt(2, exists.getInventory_id());
                ps.executeUpdate();
            }
        } else {
            String sql = "INSERT INTO Inventory_records (product_id, location_id, qty, last_updated) VALUES (?,?,?,GETDATE())";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, productId);
                ps.setInt(2, locationId);
                ps.setInt(3, qty);
                ps.executeUpdate();
            }
        }
    }

    public boolean decreaseFromLocation(int productId, int locationId, int qty) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        String sql = "UPDATE Inventory_records SET qty = qty - ?, last_updated = GETDATE() WHERE product_id = ? AND location_id = ? AND qty >= ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, productId);
            ps.setInt(3, locationId);
            ps.setInt(4, qty);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Inventory_records> getAllInventoryRecords() throws SQLException {
        return listAll();
    }
}