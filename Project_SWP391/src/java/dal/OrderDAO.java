package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;
import java.sql.Statement;

/**
 * Lớp DAO để xử lý tạo đơn hàng và chi tiết đơn trong bảng Orders và Order_details
 * @author hoang
 */
public class OrderDAO extends DBContext {

    public int insertOrder(int userId, BigDecimal totalAmount) throws SQLException {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int orderId = -1;

        try {
            String sql = "INSERT INTO Orders (user_id, total_amount) " +
                         "VALUES (?, ?);";
            stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stm.setInt(1, userId);
            stm.setBigDecimal(2, totalAmount);
            stm.executeUpdate();

            rs = stm.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting order: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    System.out.println("Error closing ResultSet: " + e.getMessage());
                }
            }
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {
                    System.out.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }

        return orderId;
    }

     public int updateProductUnitsStatus(int productId, BigDecimal unitPrice, int qty) throws SQLException {
        String updateSQL = "UPDATE TOP (?) product_units " +
                           "SET status = 'SOLD' " +
                           "WHERE product_id = ? AND purchase_price = ? AND status = 'AVAILABLE'";
        try (PreparedStatement stmt = connection.prepareStatement(updateSQL)) {
            stmt.setInt(1, qty);
            stmt.setInt(2, productId);
            stmt.setBigDecimal(3, unitPrice);
            return stmt.executeUpdate(); // trả về số row đã update
        }
    }
     
      public List<Integer> getSoldUnitIds(int productId, BigDecimal unitPrice, int qty) throws SQLException {
        String selectSQL = "SELECT TOP (?) unit_id FROM product_units " +
                           "WHERE product_id = ? AND purchase_price = ? AND status = 'SOLD' " +
                           "ORDER BY unit_id";
        List<Integer> unitIds = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(selectSQL)) {
            stmt.setInt(1, qty);
            stmt.setInt(2, productId);
            stmt.setBigDecimal(3, unitPrice);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    unitIds.add(rs.getInt("unit_id"));
                }
            }
        }
        return unitIds;
    }
      
      
    public void insertOrderDetails(int orderId, List<Integer> unitIds, int qty, BigDecimal unitPrice, BigDecimal amount) throws SQLException {
        String insertSQL = "INSERT INTO order_details(order_id, unit_id, qty, unit_price, line_amount) " +
                           "VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(insertSQL)) {
            for (int unitId : unitIds) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, unitId);
                stmt.setInt(3, qty);
                stmt.setBigDecimal(4, unitPrice);
                stmt.setBigDecimal(5, amount);
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    } 
}