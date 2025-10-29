/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import util.DBContext; 

public class WarehouseIssueService extends DBContext {

    /**
     * Hàm nghiệp vụ trọn gói: Cập nhật status cho một danh sách IMEI.Tất cả trong 1 transaction.
     * @param imeiList
     * @param userId
     * @return 
     */
    public boolean issueProductUnits(List<String> imeiList, int userId) {
        
        Connection conn = this.connection;
        if (conn == null) {
            System.err.println("Lỗi: WarehouseIssueService không lấy được connection.");
            return false;
        }

        PreparedStatement psUpdate = null;
        
        String sql = "UPDATE Product_units SET status = 'Đã xuất' WHERE imei = ? AND status = 'Trong kho'";

        try {
            conn.setAutoCommit(false); // *** BẮT ĐẦU TRANSACTION ***

            psUpdate = conn.prepareStatement(sql);

            for (String imei : imeiList) {
                psUpdate.setString(1, imei.trim());
                int affectedRows = psUpdate.executeUpdate();

                // KIỂM TRA THEN CHỐT:
                // Nếu không có dòng nào được update, nghĩa là IMEI này
                // không tồn tại hoặc không ở 'Trong kho'. Hủy toàn bộ.
                if (affectedRows == 0) {
                    throw new Exception("Lỗi: IMEI '" + imei + "' không hợp lệ hoặc không có trong kho.");
                }
            }

            // Nếu mọi thứ thành công
            conn.commit(); // *** LƯU TẤT CẢ THAY ĐỔI ***
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // *** HOÀN TÁC ***
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            // Đóng tất cả tài nguyên
            try {
                if (psUpdate != null) psUpdate.close();
                if (conn != null) conn.close(); 
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}