package dal;

import java.sql.Statement;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import util.DBContext;

/**
 * Lớp DAO để xử lý tạo đơn hàng và chi tiết đơn trong bảng Orders và
 * Order_details
 *
 * @author hoang
 */
public class OrderDAO extends DBContext {

    public int insertOrder(int userId, BigDecimal totalAmount) throws SQLException {
        String sql = "INSERT INTO Orders (user_id, total_amount) VALUES (?, ?)";

        
        try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setInt(1, userId);
            stm.setBigDecimal(2, totalAmount);

            int rows = stm.executeUpdate(); // chỉ chạy 1 lần

            if (rows > 0) {
               
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1); // cột đầu tiên là order_id
                    }
                }
            }
        }
        throw new SQLException("Tạo đơn hàng thất bại");
    }

    public void insertOrderDetails(int orderId, int qty, BigDecimal unitPrice,
            BigDecimal lineAmount, int unitId) throws SQLException {
        String sql = "INSERT INTO Order_details (order_id, unit_id, qty, unit_price, line_amount) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, orderId);
            stm.setInt(2, unitId);
            stm.setInt(3, qty);
            stm.setBigDecimal(4, unitPrice);
            stm.setBigDecimal(5, lineAmount);
            stm.executeUpdate();
        }
    }

    public int updateUnitStatusToSold(int productId, int qty) throws SQLException {
        PreparedStatement stm = null;
        try {
            String sql = "UPDATE TOP (?) Product_units SET status = 'SOLD', updated_at = SYSUTCDATETIME() "
                    + "WHERE product_id = ? AND status = 'AVAILABLE'";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, qty);
            stm.setInt(2, productId);
            int rowsAffected = stm.executeUpdate();
            return rowsAffected;
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

}
