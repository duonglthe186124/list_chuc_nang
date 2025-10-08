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
import model.Inventory_records;

public class InventoryDAO extends DBContext {

    public List<Inventory_records> listAll() throws SQLException {
        List<Inventory_records> list = new ArrayList<>();
        String sql = "SELECT inventory_id, product_id, location_id, qty, last_update FROM Inventory_records ORDER BY last_update DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Inventory_records inv = new Inventory_records(
                    rs.getInt("inventory_id"),
                    rs.getInt("product_id"),
                    rs.getInt("location_id"),
                    rs.getInt("qty"),
                    rs.getTimestamp("last_update")
                );
                list.add(inv);
            }
        }
        return list;
    }

    public Inventory_records getByInventoryId(int inventoryId) throws SQLException {
        String sql = "SELECT * FROM Inventory_records WHERE inventory_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, inventoryId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Inventory_records(
                        rs.getInt("inventory_id"),
                        rs.getInt("product_id"),
                        rs.getInt("location_id"),
                        rs.getInt("qty"),
                        rs.getTimestamp("last_update")
                    );
                }
            }
        }
        return null;
    }

    public Inventory_records findByProductAndLocation(int productId, int locationId) throws SQLException {
        String sql = "SELECT * FROM Inventory_records WHERE product_id=? AND location_id=?";
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
                        rs.getTimestamp("last_update")
                    );
                }
            }
        }
        return null;
    }

    public void addProductToLocation(int productId, int locationId, int qty) throws SQLException {
        Inventory_records exists = findByProductAndLocation(productId, locationId);
        if (exists != null) {
            String sql = "UPDATE Inventory_records SET qty = qty + ?, last_update = GETDATE() WHERE inventory_id = ?";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, qty);
                ps.setInt(2, exists.getInventory_id());
                ps.executeUpdate();
            }
        } else {
            String sql = "INSERT INTO Inventory_records (product_id, location_id, qty, last_update) VALUES (?,?,?,GETDATE())";
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, productId);
                ps.setInt(2, locationId);
                ps.setInt(3, qty);
                ps.executeUpdate();
            }
        }
    }

    // trả về true nếu thành công (qty đủ)
    public boolean decreaseFromLocation(int productId, int locationId, int qty) throws SQLException {
        String sql = "UPDATE Inventory_records SET qty = qty - ?, last_update = GETDATE() WHERE product_id = ? AND location_id = ? AND qty >= ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, qty);
            ps.setInt(2, productId);
            ps.setInt(3, locationId);
            ps.setInt(4, qty);
            int updated = ps.executeUpdate();
            return updated > 0;
        }
    }

    public void updateQuantityByInventoryId(int inventoryId, int newQty) throws SQLException {
        String sql = "UPDATE Inventory_records SET qty = ?, last_update = GETDATE() WHERE inventory_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, newQty);
            ps.setInt(2, inventoryId);
            ps.executeUpdate();
        }
    }
}