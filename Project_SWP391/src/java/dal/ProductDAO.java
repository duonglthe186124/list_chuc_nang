/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */

import util.DBContext;
import java.sql.*;
import java.util.*;
import model.Products;

public class ProductDAO extends DBContext {

    public List<Products> listAll() throws SQLException {
        List<Products> list = new ArrayList<>();
        String sql = "SELECT product_id, product_name, brand_id, spec_id, type_id, description, created_at FROM Products";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Products p = new Products(
                    rs.getInt("product_id"),
                    rs.getString("product_name"),
                    rs.getInt("brand_id"),
                    rs.getInt("spec_id"),
                    rs.getInt("type_id"),
                    rs.getString("description"),
                    rs.getTimestamp("created_at")
                );
                list.add(p);
            }
        }
        return list;
    }
}