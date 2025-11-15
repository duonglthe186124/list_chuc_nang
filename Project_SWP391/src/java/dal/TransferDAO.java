/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Containers;
import dto.ContainerDTO;
import dto.TransferDTO;
import util.DBContext;

public class TransferDAO extends DBContext {

    public TransferDAO() throws Exception {
        super();
        if (this.connection == null) {
            throw new Exception("Lỗi: TransferDAO không thể kết nối CSDL.");
        }
    }

    // Hàm 1: Tìm 1 IMEI (và vị trí hiện tại của nó)
    public TransferDTO getUnitForTransfer(String imei) throws Exception {
        TransferDTO dto = null;
        String query = "SELECT "
                + "    pu.unit_id, pu.imei, p.name AS productName, "
                + "    c.container_id, c.container_code, wl.code AS locationCode "
                + "FROM Product_units pu "
                + "JOIN Products p ON pu.product_id = p.product_id "
                + "JOIN Containers c ON pu.container_id = c.container_id "
                + "JOIN Warehouse_locations wl ON c.location_id = wl.location_id "
                + "WHERE pu.imei = ? AND pu.status = 'AVAILABLE'";

        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection conn = this.connection;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            ps.setString(1, imei);
            rs = ps.executeQuery();
            if (rs.next()) {
                dto = new TransferDTO();
                dto.setUnitId(rs.getInt("unit_id"));
                dto.setImei(rs.getString("imei"));
                dto.setProductName(rs.getString("productName"));
                dto.setCurrentContainerId(rs.getInt("container_id"));
                dto.setCurrentContainerCode(rs.getString("container_code"));
                dto.setCurrentLocationCode(rs.getString("locationCode"));
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
        return dto;
    }

    /**
     * Hàm 2: Lấy tất cả Containers (ĐÃ SỬA LỖI - Dùng DTO mới)
     */
    public List<ContainerDTO> getAllContainersWithLocation() throws Exception {
        // SỬA: Trả về List<ContainerDTO>
        List<ContainerDTO> list = new ArrayList<>();

        String query = "SELECT c.container_id, c.container_code, wl.code AS LocationCode "
                + "FROM Containers c "
                + "JOIN Warehouse_locations wl ON c.location_id = wl.location_id "
                + "ORDER BY wl.code, c.container_code";

        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection conn = this.connection;
        try {
            Connection conn = this.connection;
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                // SỬA: Tạo đối tượng DTO mới
                ContainerDTO c = new ContainerDTO();
                c.setContainerId(rs.getInt("container_id"));
                c.setContainerCode(rs.getString("container_code"));
                c.setLocationCode(rs.getString("LocationCode")); 
                list.add(c);
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
        return list;
    }

    // Hàm 3: Xử lý Điều chuyển (Dùng Transaction và Ghi Log)
    public boolean processTransfer(int unitId, int newContainerId, int employeeId, String reason) throws Exception {
        PreparedStatement psUpdateUnit = null;
        PreparedStatement psLogAdjustment = null;
        Connection conn = this.connection;
        String sqlUpdateUnit = "UPDATE Product_units SET container_id = ?, updated_at = SYSUTCDATETIME() WHERE unit_id = ?";
        String sqlLog = "INSERT INTO Stock_adjustments (unit_id, reason, created_by) VALUES (?, ?, ?)";
        try {
            Connection conn = this.connection;
            conn.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Cập nhật Vị trí (Container) mới cho IMEI
            psUpdateUnit = this.connection.prepareStatement(sqlUpdateUnit);
            psUpdateUnit.setInt(1, newContainerId);
            psUpdateUnit.setInt(2, unitId);
            int affectedRows = psUpdateUnit.executeUpdate();

            if (affectedRows == 0) {
                throw new Exception("Không thể cập nhật vị trí IMEI.");
            }

            // 2. Ghi log vào Stock_adjustments
            psLogAdjustment = this.connection.prepareStatement(sqlLog);
            psLogAdjustment.setInt(1, unitId);
            psLogAdjustment.setString(2, reason);
            psLogAdjustment.setInt(3, employeeId);
            psLogAdjustment.executeUpdate();

            this.connection.commit(); // Lưu
            return true;
        } catch (Exception e) {
            Connection conn = this.connection;
            e.printStackTrace();
            if (conn != null) {
                conn.rollback(); // Hoàn tác nếu có lỗi
            }
            throw e;
        } finally {
            Connection conn = this.connection;
            // Đóng tất cả
            try {
                if (psUpdateUnit != null) {
                    psUpdateUnit.close();
                }
                if (psLogAdjustment != null) {
                    psLogAdjustment.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Hàm 4: Đóng kết nối
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
