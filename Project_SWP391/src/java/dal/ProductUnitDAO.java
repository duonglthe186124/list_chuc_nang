/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Product_units;
import util.DBContext;

public class ProductUnitDAO extends DBContext {

    public List<Integer> getRandomUnitIds(int productId, int qty) throws SQLException {
        List<Integer> unitIds = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            String countSql = "SELECT COUNT(*) as quantity FROM Product_units pu "
                    + "WHERE pu.product_id = ? AND pu.status = 'AVAILABLE'";
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
            String sql = "SELECT TOP (?) unit_id FROM Product_units "
                    + "WHERE product_id = ? AND status = 'AVAILABLE' "
                    + "ORDER BY NEWID()";
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
                String sql = "UPDATE Product_units SET status = 'SOLD', updated_at = SYSUTCDATETIME() "
                        + "WHERE unit_id = ?";
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

    /**
     * Create new units
     *
     * @param list
     */
    public int create_new_unit(Product_units line) {
        int unit_id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Product_units(imei, serial_number, warranty_start, "
                + "warranty_end, product_id, purchase_price, container_id, status)\n"
                + "VALUES(?, ?, ?, ?, ?, ? ,?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, line.getImei());
            ps.setString(2, line.getSerial_number());
            ps.setDate(3, (java.sql.Date) line.getWarranty_start());
            ps.setDate(4, (java.sql.Date) line.getWarranty_end());
            ps.setInt(5, line.getProduct_id());
            ps.setFloat(6, line.getPurchase_price());
            ps.setInt(7, line.getContainer_id());
            ps.setString(8, line.getStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        unit_id = rs.getInt(1);
                    }
                }
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return unit_id;
    }

    public List<Integer> get_n_unit_id(int product_id, int qty) {
        List<Integer> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT TOP (?) unit_id\n"
                + "FROM Product_units\n"
                + "WHERE product_id = ?\n"
                + "ORDER BY received_date ASC, unit_id ASC;");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, qty);
            ps.setInt(2, product_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getInt(1));
                }
                ps.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        sql = new StringBuilder("UPDATE Product_units\n"
                + "SET status = 'RESERVED',\n"
                + "    updated_at = SYSUTCDATETIME()\n"
                + "WHERE unit_id IN (\n"
                + "    SELECT TOP (?) unit_id\n"
                + "    FROM Product_units\n"
                + "    WHERE product_id = ? AND status = 'AVAILABLE'\n"
                + "    ORDER BY received_date ASC\n"
                + ");");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, qty);
            ps.setInt(2, product_id);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public void add_shipment_unit(int line_id, List<Integer> unit_id) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Shipment_units(line_id, unit_id)\n"
                + "VALUES(?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (Integer i : unit_id) {
                ps.setInt(1, line_id);
                ps.setInt(2, i);

                ps.addBatch();
            }
            ps.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
