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

public class ProductUnitDAO extends DBContext {
    public ProductUnitDAO() { super(); }

    public int findFirstUnitIdByProduct(int productId) throws SQLException {
        if (connection == null) throw new SQLException("DB connection is null.");
        String sql = "SELECT unit_id FROM Product_units WHERE product_id = ? ORDER BY created_at";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("unit_id");
            }
        }
        return -1;
    }
}