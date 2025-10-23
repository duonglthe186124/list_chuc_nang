/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.InventoryDTO;
import java.sql.*;
import java.util.*;
import util.DBContext;

public class InventoryDAO extends DBContext {

    public List<InventoryDTO> list() {
        List<InventoryDTO> list = new ArrayList<>();
        String sql = """
            SELECT p.product_id, p.name AS product_name, b.brand_name, 
                   COUNT(u.unit_id) AS total_units,
                   SUM(CASE WHEN u.status='AVAILABLE' THEN 1 ELSE 0 END) AS available_units,
                   SUM(CASE WHEN u.status='DAMAGED' THEN 1 ELSE 0 END) AS damaged_units
            FROM Products p
            JOIN Brands b ON p.brand_id = b.brand_id
            LEFT JOIN Product_units u ON p.product_id = u.product_id
            GROUP BY p.product_id, p.name, b.brand_name
            ORDER BY p.product_id
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                InventoryDTO i = new InventoryDTO();
                i.setProduct_id(rs.getInt("product_id"));
                i.setProduct_name(rs.getString("product_name"));
                i.setBrand_name(rs.getString("brand_name"));
                i.setTotal_units(rs.getInt("total_units"));
                i.setAvailable_units(rs.getInt("available_units"));
                i.setDamaged_units(rs.getInt("damaged_units"));
                list.add(i);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
