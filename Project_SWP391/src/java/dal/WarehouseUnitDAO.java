package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Product_units;
import model.Products;
import util.DBContext;

public class WarehouseUnitDAO extends DBContext {

    public WarehouseUnitDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi WarehouseUnitDAO: Không thể kết nối CSDL.");
        }
    }

    // Hàm 1: Lấy thông tin chi tiết của 1 IMEI (unit)
    public Product_units getUnitById(int unitId) throws Exception {
        Product_units unit = null;
        String query = "SELECT * FROM Product_units WHERE unit_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            ps.setInt(1, unitId);
            rs = ps.executeQuery();
            if (rs.next()) {
                unit = new Product_units();
                unit.setUnit_id(rs.getInt("unit_id"));
                unit.setImei(rs.getString("imei"));
                unit.setProduct_id(rs.getInt("product_id"));
                unit.setStatus(rs.getString("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return unit;
    }

    /**
     * Hàm 2: (NÂNG CẤP) Cập nhật Status VÀ Ghi Log (Dùng Transaction)
     */
    public boolean updateUnitStatus(int unitId, String oldStatus, String newStatus, int employeeId, String userReason) throws Exception {
        PreparedStatement psUpdateUnit = null;
        PreparedStatement psLog = null;

        String sqlUpdateUnit = "UPDATE Product_units SET status = ?, updated_at = SYSUTCDATETIME() WHERE unit_id = ?";
        String sqlLog = "INSERT INTO Stock_adjustments (unit_id, reason, created_by) VALUES (?, ?, ?)";

        // NÂNG CẤP: Tạo lý do chi tiết
        String logReason = "Status changed: " + oldStatus + " -> " + newStatus + ". Reason: " + userReason;

        try {
            this.connection.setAutoCommit(false); // Bắt đầu Transaction
            // 1. Cập nhật Status
            psUpdateUnit = this.connection.prepareStatement(sqlUpdateUnit);
            psUpdateUnit.setString(1, newStatus);
            psUpdateUnit.setInt(2, unitId);

            int affectedRows = psUpdateUnit.executeUpdate();
            if (affectedRows == 0) {
                throw new Exception("Cập nhật thất bại. Status có thể đã bị thay đổi bởi người khác.");
            }

            // 2. Ghi Log (với lý do chi tiết)
            psLog = this.connection.prepareStatement(sqlLog);
            psLog.setInt(1, unitId);
            psLog.setString(2, logReason); // NÂNG CẤP: Dùng lý do mới
            psLog.setInt(3, employeeId);
            psLog.executeUpdate();

            this.connection.commit(); // Lưu thay đổi
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            if (this.connection != null) {
                this.connection.rollback(); // Hoàn tác
            }
            throw e;
        } finally {
            try {
                if (psUpdateUnit != null) {
                    psUpdateUnit.close();
                }
                if (psLog != null) {
                    psLog.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Hàm 3: Lấy tên sản phẩm (để hiển thị)
     */
    public String getProductNameById(int productId) throws Exception {
        String productName = "";
        String query = "SELECT name FROM Products WHERE product_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            ps.setInt(1, productId);
            rs = ps.executeQuery();
            if (rs.next()) {
                productName = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return productName;
    }

    /**
     * HÀM 4: Lấy employee_id từ user_id (Dùng để sửa lỗi login)
     */
    public int getEmployeeIdByUserId(int userId) throws Exception {
        int employeeId = 0;
        String query = "SELECT employee_id FROM Employees WHERE user_id = ?";
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            // Dùng connection đã được kế thừa
            ps = this.connection.prepareStatement(query);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                employeeId = rs.getInt("employee_id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Chỉ đóng ps và rs, connection sẽ được đóng bởi Servlet
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return employeeId;
    }

    // Hàm 5: Đóng kết nối
    public void closeConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed()) {
                this.connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
