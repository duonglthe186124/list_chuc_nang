/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import util.DBContext;

public class WarehouseImportService extends DBContext {

    /**
     * Hàm nghiệp vụ trọn gói: Tạo phiếu nhập, chi tiết phiếu, và lưu IMEI
     * Tất cả trong 1 transaction.
     * @param supplierId
     * @param productId
     * @param quantity
     * @param importPrice
     * @param imeiList
     * @param createdBy
     * @return 
     */
    public boolean importNewReceipt(int supplierId, int productId, int quantity, 
                                    double importPrice, List<String> imeiList, int createdBy) {

        Connection conn = this.connection;
        if (conn == null) {
            System.err.println("Lỗi: WarehouseImportService không lấy được connection.");
            return false;
        }

        PreparedStatement psReceipt = null;
        PreparedStatement psReceiptLine = null;
        PreparedStatement psProductUnit = null;
        ResultSet rsReceipt = null;
        ResultSet rsReceiptLine = null;

        String sqlReceipt = "INSERT INTO Receipts (supplier_id, user_id, receipt_date, total_amount) VALUES (?, ?, ?, ?)";
        String sqlReceiptLine = "INSERT INTO Receipt_lines (receipt_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        String sqlProductUnit = "INSERT INTO Product_units (product_id, imei, status, receipt_line_id) VALUES (?, ?, 'Trong kho', ?)";

        try {
            conn.setAutoCommit(false); // *** BẮT ĐẦU TRANSACTION ***

            // 1. Tạo Phiếu nhập (Receipts)
            psReceipt = conn.prepareStatement(sqlReceipt, Statement.RETURN_GENERATED_KEYS);
            psReceipt.setInt(1, supplierId);
            psReceipt.setInt(2, createdBy);
            psReceipt.setTimestamp(3, new Timestamp(new Date().getTime()));
            psReceipt.setDouble(4, importPrice * quantity);
            psReceipt.executeUpdate();

            // Lấy ID phiếu nhập vừa tạo
            rsReceipt = psReceipt.getGeneratedKeys();
            if (!rsReceipt.next()) {
                throw new Exception("Không thể tạo phiếu nhập (Receipts).");
            }
            int receiptId = rsReceipt.getInt(1);

            // 2. Tạo Chi tiết phiếu nhập (Receipt_Lines)
            psReceiptLine = conn.prepareStatement(sqlReceiptLine, Statement.RETURN_GENERATED_KEYS);
            psReceiptLine.setInt(1, receiptId);
            psReceiptLine.setInt(2, productId);
            psReceiptLine.setInt(3, quantity);
            psReceiptLine.setDouble(4, importPrice);
            psReceiptLine.executeUpdate();

            // Lấy ID dòng phiếu nhập vừa tạo
            rsReceiptLine = psReceiptLine.getGeneratedKeys();
            if (!rsReceiptLine.next()) {
                throw new Exception("Không thể tạo chi tiết phiếu nhập (Receipt_Lines).");
            }
            int receiptLineId = rsReceiptLine.getInt(1);

            // 3. Lưu từng IMEI vào Product_units
            psProductUnit = conn.prepareStatement(sqlProductUnit);
            for (String imei : imeiList) {
                psProductUnit.setInt(1, productId);
                psProductUnit.setString(2, imei.trim());
                psProductUnit.setInt(3, receiptLineId);
                psProductUnit.addBatch(); // Thêm vào lô
            }
            psProductUnit.executeBatch(); // Thực thi

            // 4. Nếu mọi thứ thành công
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
                if (rsReceipt != null) rsReceipt.close();
                if (rsReceiptLine != null) rsReceiptLine.close();
                if (psReceipt != null) psReceipt.close();
                if (psReceiptLine != null) psReceiptLine.close();
                if (psProductUnit != null) psProductUnit.close();
                if (conn != null) conn.close(); // DBContext sẽ tạo connection mới lần sau
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}