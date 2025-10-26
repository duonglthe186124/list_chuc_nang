/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;


public class ProductUnitDAO extends DBContext {

    public List<Integer> getRandomUnitIds(int productId, int qty) throws SQLException {
        List<Integer> unitIds = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String countSql = "SELECT COUNT(*) as quantity FROM Product_units pu " +
                             "WHERE pu.product_id = ? AND pu.status = 'AVAILABLE'";
            stm = connection.prepareStatement(countSql);
            stm.setInt(1, productId);
            rs = stm.executeQuery();
            int availableQuantity = 0;
            if (rs.next()) {
                availableQuantity = rs.getInt("quantity");
            }
            rs.close();
            stm.close();

            if (qty > availableQuantity) {
                throw new SQLException("Not enough available units. Required: " + qty + ", Available: " + availableQuantity);
            }

            // Lấy danh sách unit_id ngẫu nhiên
            String sql = "SELECT TOP (?) unit_id FROM Product_units " +
                         "WHERE product_id = ? AND status = 'AVAILABLE' " +
                         "ORDER BY NEWID()";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, qty);
            stm.setInt(2, productId);
            rs = stm.executeQuery();

            while (rs.next()) {
                int unitId = rs.getInt("unit_id");
                unitIds.add(unitId);
            }

        } catch (SQLException e) {
            throw new SQLException("Error getting random unit IDs: " + e.getMessage());
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

        return unitIds;
    }


    public void updateUnitStatus(List<Integer> unitIds) throws SQLException {
        PreparedStatement stm = null;

        try {
            if (unitIds != null && !unitIds.isEmpty()) {
                String sql = "UPDATE Product_units SET status = 'SOLD', updated_at = SYSUTCDATETIME() " +
                             "WHERE unit_id = ?";
                stm = connection.prepareStatement(sql);

                for (int unitId : unitIds) {
                    stm.setInt(1, unitId);
                    stm.addBatch();
                }
                stm.executeBatch();
            }
        } catch (SQLException e) {
            throw new SQLException("Error updating unit status: " + e.getMessage());
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
}