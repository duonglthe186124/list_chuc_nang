/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ProductViewDTO;
import dto.StatusDTO;
import dto.UnitViewDTO;
import java.math.BigDecimal;
import util.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class ProductViewDAO extends DBContext {

    public ProductViewDTO getProductCommonInfoById(int productId, BigDecimal price) throws SQLException {
        String sql = """
        SELECT TOP (1)
                    p.product_id, p.name, p.sku_code, b.brand_name,
                    ps.storage, ps.screen_type, ps.screen_size, ps.memory,
                    ps.cpu, ps.color, ps.camera, ps.battery_capacity,
                    [pi].image_url, pu.purchase_price
                FROM Products p
                LEFT JOIN Brands b ON p.brand_id = b.brand_id
                LEFT JOIN Product_specs ps ON ps.spec_id = p.spec_id
                LEFT JOIN Product_images [pi] ON [pi].product_id = p.product_id
                LEFT JOIN Product_units pu ON pu.product_id = p.product_id
                WHERE p.product_id = ? AND pu.purchase_price = ?
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setBigDecimal(2, price);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {

                    // (phần tạo DTO giữ nguyên)
                    ProductViewDTO product = new ProductViewDTO();
                    product.setProductId(rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setSkuCode(rs.getString("sku_code"));
                    product.setBrandName(rs.getString("brand_name"));
                    product.setStorage(rs.getString("storage"));
                    product.setScreenType(rs.getString("screen_type"));
                    product.setScreenSize(rs.getBigDecimal("screen_size"));
                    product.setMemory(rs.getString("memory"));
                    product.setCpu(rs.getString("cpu"));
                    product.setColor(rs.getString("color"));
                    product.setCamera(rs.getInt("camera"));
                    product.setBatteryCapacity(rs.getInt("battery_capacity"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setPurchasePrice(rs.getBigDecimal("purchase_price"));

                    return product;
                } else {
                    System.out.println("Không tìm thấy sản phẩm nào có product_id = " + productId);
                }
            }
        } catch (SQLException e) {
            System.out.println("Lỗi SQL: " + e.getMessage());
            throw e;
        }
        return null;
    }

    public List<UnitViewDTO> getUnitsByProductId(int productId, BigDecimal price) throws SQLException {
        List<UnitViewDTO> list = new ArrayList<>();

        String sql = """
            SELECT unit_id, imei, serial_number, 
                               warranty_start, warranty_end, status
                        FROM Product_units
                        WHERE product_id = ? AND purchase_price = ?
                        ORDER BY unit_id
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setBigDecimal(2, price);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UnitViewDTO u = new UnitViewDTO();

                    u.setUnitId(rs.getInt("unit_id"));
                    u.setImei(rs.getString("imei"));
                    u.setSerialNumber(rs.getString("serial_number"));
                    u.setWarrantyStart(rs.getTimestamp("warranty_start"));
                    u.setWarrantyEnd(rs.getTimestamp("warranty_end"));
                    u.setStatus(rs.getString("status"));

                    list.add(u);
                }
            }
        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách unit của product_id=" + productId + ": " + e.getMessage(), e);
        }

        return list;
    }

    public List<StatusDTO> getAllStatusesUnit() throws SQLException {
        List<StatusDTO> list = new ArrayList<>();

        String sql = "SELECT definition FROM sys.check_constraints WHERE name = 'CHK_Product_units_status'";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                String def = rs.getString("definition");

                // Dò từng status trong constraint
                java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("'(\\w+)'");
                java.util.regex.Matcher matcher = pattern.matcher(def);

                while (matcher.find()) {
                    String status = matcher.group(1);
                    list.add(new StatusDTO(status));
                }
            }

        } catch (SQLException e) {
            throw new SQLException("Lỗi khi lấy danh sách status: " + e.getMessage(), e);
        }

        return list;
    }

    public List<UnitViewDTO> searchUnitsByFilters(int productId, String status, String imei, String serial)
            throws SQLException {
        List<UnitViewDTO> list = new ArrayList<>();

        String sql = """
        SELECT unit_id, imei, serial_number, warranty_start, warranty_end, status
        FROM Product_units
        WHERE product_id = ?
          AND (? IS NULL OR status LIKE ? COLLATE SQL_Latin1_General_CP1_CI_AS)
          AND (? IS NULL OR imei COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
          AND (? IS NULL OR serial_number COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
        ORDER BY unit_id
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);

            // status
            if (status == null || status.trim().isEmpty()) {
                ps.setNull(2, java.sql.Types.NVARCHAR);
                ps.setNull(3, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(2, status);
                ps.setString(3, status);
            }

            // imei
            if (imei == null || imei.trim().isEmpty()) {
                ps.setNull(4, java.sql.Types.NVARCHAR);
                ps.setNull(5, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(4, imei);
                ps.setString(5, "%" + imei + "%");
            }

            // serial
            if (serial == null || serial.trim().isEmpty()) {
                ps.setNull(6, java.sql.Types.NVARCHAR);
                ps.setNull(7, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(6, serial);
                ps.setString(7, "%" + serial + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UnitViewDTO u = new UnitViewDTO();
                    u.setUnitId(rs.getInt("unit_id"));
                    u.setImei(rs.getString("imei"));
                    u.setSerialNumber(rs.getString("serial_number"));
                    u.setWarrantyStart(rs.getTimestamp("warranty_start"));
                    u.setWarrantyEnd(rs.getTimestamp("warranty_end"));
                    u.setStatus(rs.getString("status"));
                    list.add(u);
                }
            }
        }

        return list;
    }

    public List<UnitViewDTO> getUnitsByProductIdPaged(int productId, BigDecimal price, int pageIndex, int pageSize) throws SQLException {
        List<UnitViewDTO> list = new ArrayList<>();
        String sql = """
        SELECT unit_id, imei, serial_number, warranty_start, warranty_end, status
        FROM Product_units
        WHERE product_id = ? AND purchase_price = ?
        ORDER BY unit_id
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, productId);
            stm.setBigDecimal(2, price);
            stm.setInt(3, (pageIndex - 1) * pageSize);
            stm.setInt(4, pageSize);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    UnitViewDTO u = new UnitViewDTO();
                    u.setUnitId(rs.getInt("unit_id"));
                    u.setImei(rs.getString("imei"));
                    u.setSerialNumber(rs.getString("serial_number"));
                    u.setWarrantyStart(rs.getTimestamp("warranty_start"));
                    u.setWarrantyEnd(rs.getTimestamp("warranty_end"));
                    u.setStatus(rs.getString("status"));
                    list.add(u);
                }
            }
        }
        return list;
    }

    public List<UnitViewDTO> searchUnitsByFiltersPaged(
            int productId, BigDecimal price, String status, String imei, String serial,
            int pageIndex, int pageSize) throws SQLException {

        List<UnitViewDTO> list = new ArrayList<>();

        String sql = """
        SELECT unit_id, imei, serial_number, warranty_start, warranty_end, status
        FROM Product_units
        WHERE product_id = ? AND purchase_price = ?
          AND (? IS NULL OR status LIKE ? COLLATE SQL_Latin1_General_CP1_CI_AS)
          AND (? IS NULL OR imei COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
          AND (? IS NULL OR serial_number COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
        ORDER BY unit_id
        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setBigDecimal(2, price);

            // status
            if (status == null || status.trim().isEmpty()) {
                ps.setNull(3, java.sql.Types.NVARCHAR);
                ps.setNull(4, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(3, status);
                ps.setString(4, status);
            }

            // imei
            if (imei == null || imei.trim().isEmpty()) {
                ps.setNull(5, java.sql.Types.NVARCHAR);
                ps.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(5, imei);
                ps.setString(6, "%" + imei + "%");
            }

            // serial
            if (serial == null || serial.trim().isEmpty()) {
                ps.setNull(7, java.sql.Types.NVARCHAR);
                ps.setNull(8, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(7, serial);
                ps.setString(8, "%" + serial + "%");
            }

            // Phân trang
            ps.setInt(9, (pageIndex - 1) * pageSize); // OFFSET
            ps.setInt(10, pageSize); // FETCH NEXT

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    UnitViewDTO u = new UnitViewDTO();
                    u.setUnitId(rs.getInt("unit_id"));
                    u.setImei(rs.getString("imei"));
                    u.setSerialNumber(rs.getString("serial_number"));
                    u.setWarrantyStart(rs.getTimestamp("warranty_start"));
                    u.setWarrantyEnd(rs.getTimestamp("warranty_end"));
                    u.setStatus(rs.getString("status"));
                    list.add(u);
                }
            }
        }

        return list;
    }

    public int countUnitsByFilters(int productId, BigDecimal price, String status, String imei, String serial) throws SQLException {
        String sql = """
        SELECT COUNT(*)
        FROM Product_units
        WHERE product_id = ?
          AND purchase_price = ?           
          AND (? IS NULL OR status LIKE ? COLLATE SQL_Latin1_General_CP1_CI_AS)
          AND (? IS NULL OR imei COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
          AND (? IS NULL OR serial_number COLLATE SQL_Latin1_General_CP1_CI_AS LIKE ?)
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.setBigDecimal(2, price);

            if (status == null || status.trim().isEmpty()) {
                ps.setNull(3, java.sql.Types.NVARCHAR);
                ps.setNull(4, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(3, status);
                ps.setString(4, status);
            }

            if (imei == null || imei.trim().isEmpty()) {
                ps.setNull(5, java.sql.Types.NVARCHAR);
                ps.setNull(6, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(5, imei);
                ps.setString(6, "%" + imei + "%");
            }

            if (serial == null || serial.trim().isEmpty()) {
                ps.setNull(7, java.sql.Types.NVARCHAR);
                ps.setNull(8, java.sql.Types.NVARCHAR);
            } else {
                ps.setString(7, serial);
                ps.setString(8, "%" + serial + "%");
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }

        return 0;
    }

    public int countUnitsByProductId(int productId, BigDecimal price) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Product_units WHERE product_id = ? AND purchase_price = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, productId);
            stm.setBigDecimal(2, price);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return 0;
    }

}
