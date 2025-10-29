package dal;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import util.DBContext;

/**
 * Lớp DAO để xử lý tạo đơn hàng và chi tiết đơn trong bảng Orders và Order_details
 * @author hoang
 */
public class OrderDAO extends DBContext {

    private int insertOrder(int userId, BigDecimal totalAmount) throws SQLException {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int orderId = -1;

        try {
            String sql = "INSERT INTO Orders (user_id, total_amount, status, order_date) " +
                         "VALUES (?, ?, 'PENDING', SYSUTCDATETIME()); SELECT SCOPE_IDENTITY();";
            stm = connection.prepareStatement(sql);
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

    private void insertOrderDetails(int orderId, List<Integer> unitIds, int qty, BigDecimal purchasePrice) throws SQLException {
        PreparedStatement stm = null;

        try {
            if (orderId != -1 && unitIds != null && !unitIds.isEmpty()) {
                // Kiểm tra nếu qty vượt quá số lượng unit_id khả dụng
                if (qty > unitIds.size()) {
                    throw new SQLException("Order cannot be placed. Requested qty (" + qty + ") exceeds available units (" + unitIds.size() + ").");
                }

                String sql = "INSERT INTO Order_details (order_id, unit_id, qty, unit_price, line_amount) " +
                             "VALUES (?, ?, ?, ?, ?)";
                stm = connection.prepareStatement(sql);
                
                // Phân bổ qty thực tế từ người dùng, nhưng hiện tại mỗi unit_id chỉ chứa 1 sản phẩm
                int unitsPerItem = qty / unitIds.size();
                int remaining = qty % unitIds.size();

                for (int i = 0; i < unitIds.size(); i++) {
                    int currentQty = unitsPerItem + (i < remaining ? 1 : 0); // Phân bổ đều qty
                    BigDecimal lineAmount = purchasePrice.multiply(BigDecimal.valueOf(currentQty));
                    
                    stm.setInt(1, orderId);
                    stm.setInt(2, unitIds.get(i));
                    stm.setInt(3, currentQty); // Sử dụng qty thực tế
                    stm.setBigDecimal(4, purchasePrice);
                    stm.setBigDecimal(5, lineAmount);
                    stm.addBatch();
                }
                stm.executeBatch();
            } else {
                throw new SQLException("Invalid order_id, unit_ids, or qty.");
            }
        } catch (SQLException e) {
            throw new SQLException("Error inserting order details: " + e.getMessage());
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException e) {
                    System.out.println("Error closing PreparedStatement: " + e.getMessage());
                }
            }
        }
    }

    public int createOrder(int userId, int productId, int qty, BigDecimal purchasePrice) throws SQLException {
        PreparedStatement stm = null;
        ResultSet rs = null;
        int orderId = -1;

        connection.setAutoCommit(false);

        try {
            ProductUnitDAO productUnitDAO = new ProductUnitDAO();
            List<Integer> unitIds = productUnitDAO.getRandomUnitIds(productId, qty);
            
            BigDecimal totalAmount = purchasePrice.multiply(BigDecimal.valueOf(qty));
            orderId = insertOrder(userId, totalAmount);

            if (orderId != -1) {
                insertOrderDetails(orderId, unitIds, qty, purchasePrice);
                productUnitDAO.updateUnitStatus(unitIds);
            } else {
                throw new SQLException("Failed to create order.");
            }

            connection.commit();
            System.out.println("Order created successfully with order_id: " + orderId);

        } catch (SQLException e) {
            try {
                connection.rollback();
                System.out.println("Transaction rolled back due to: " + e.getMessage());
            } catch (SQLException ex) {
                System.out.println("Rollback failed: " + ex.getMessage());
            }
            throw e;
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
            connection.setAutoCommit(true);
        }

        return orderId;
    }
}