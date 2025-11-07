package dal;

import dto.ProductInfo;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class SearchProductDAO extends DBContext {

    public ArrayList<ProductInfo> getProductsByPageFiltered(
            String brandName,
            String cpu,
            String memory,
            String storage,
            String color,
            int battery,
            BigDecimal screenSize,
            String screenType,
            int camera,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            String keyWord,
            int pageIndex,
            int pageSize
    ) throws SQLException {

        ArrayList<ProductInfo> list = new ArrayList<>();

        String sql = "SELECT "
                + "   distinct p.product_id, "
                + "    p.name, "
                + "    p.sku_code, "
                + "    b.brand_name, "
                + "    s.cpu, "
                + "    s.memory, "
                + "    s.storage, "
                + "    s.color, "
                + "    s.battery_capacity, "
                + "    s.screen_size, "
                + "    s.screen_type, "
                + "    s.camera, "
                + "    u.purchase_price, "
                + "    ISNULL(v.available_quantity, 0) AS available_quantity, " // Đổi tên thành available_quantity
                + "    i.image_url "
                + "FROM Products p "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "JOIN Product_specs s ON p.spec_id = s.spec_id "
                + "JOIN Product_units u ON p.product_id = u.product_id "
                + "LEFT JOIN Product_images i ON p.product_id = i.product_id "
                + "LEFT JOIN ( "
                + "    SELECT product_id, COUNT(unit_id) AS available_quantity "
                + "    FROM Product_units "
                + "    WHERE status = 'AVAILABLE' " // Thêm điều kiện status
                + "    GROUP BY product_id "
                + ") v ON p.product_id = v.product_id "
                + "WHERE 1 = 1 ";

        ArrayList<Object> params = new ArrayList<>();

        if (brandName != null && !brandName.isEmpty()) {
            sql += " AND b.brand_name = ? ";
            params.add(brandName);
        }
        if (cpu != null && !cpu.isEmpty()) {
            sql += " AND s.cpu = ? ";
            params.add(cpu);
        }
        if (memory != null && !memory.isEmpty()) {
            sql += " AND s.memory = ? ";
            params.add(memory);
        }
        if (storage != null && !storage.isEmpty()) {
            sql += " AND s.storage = ? ";
            params.add(storage);
        }
        if (color != null && !color.isEmpty()) {
            sql += " AND s.color = ? ";
            params.add(color);
        }
        if (battery > 0) {
            sql += " AND s.battery_capacity = ? ";
            params.add(battery);
        }
        if (screenSize != null && screenSize.compareTo(BigDecimal.ZERO) > 0) {
            sql += " AND s.screen_size BETWEEN ? - 0.05 AND ? + 0.05 ";
            params.add(screenSize);
            params.add(screenSize);
        }
        if (screenType != null && !screenType.isEmpty()) {
            sql += " AND s.screen_type = ? ";
            params.add(screenType);
        }
        if (camera > 0) {
            sql += " AND s.camera = ? ";
            params.add(camera);
        }
        if (minPrice != null) {
            sql += " AND u.purchase_price >= ? ";
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql += " AND u.purchase_price <= ? ";
            params.add(maxPrice);
        }
        if (keyWord != null && !keyWord.trim().isEmpty()) {
            sql += " AND (p.name COLLATE Latin1_General_CI_AI LIKE ? "
                    + " OR p.sku_code COLLATE Latin1_General_CI_AI LIKE ?) ";
            params.add("%" + keyWord.trim() + "%");
            params.add("%" + keyWord.trim() + "%");
        }
        sql += " ORDER BY p.product_id "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        int offset = (pageIndex - 1) * pageSize;
        params.add(offset);
        params.add(pageSize);

        PreparedStatement stm = connection.prepareStatement(sql);

        for (int i = 0; i < params.size(); i++) {
            stm.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            ProductInfo p = new ProductInfo();
            p.setProductId(rs.getInt("product_id"));
            p.setProductName(rs.getString("name"));
            p.setSku_code(rs.getString("sku_code"));
            p.setBrandName(rs.getString("brand_name"));
            p.setCpu(rs.getString("cpu"));
            p.setMemory(rs.getString("memory"));
            p.setStorage(rs.getString("storage"));
            p.setCamera(rs.getInt("camera"));
            p.setPrice(rs.getBigDecimal("purchase_price"));
            p.setQty(rs.getInt("available_quantity")); // Cập nhật tên cột
            p.setImageUrl(rs.getString("image_url"));
            list.add(p);
        }

        return list;
    }

    public int countFilteredProducts(
            String brandName,
            String cpu,
            String memory,
            String storage,
            String color,
            int battery,
            BigDecimal screenSize,
            String screenType,
            int camera,
            BigDecimal minPrice,
            BigDecimal maxPrice,
            String keyWord
    ) throws SQLException {

        String sql = "SELECT COUNT(DISTINCT p.product_id) AS total_count "
                + "FROM Products p "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "JOIN Product_specs s ON p.spec_id = s.spec_id "
                + "JOIN Product_units u ON p.product_id = u.product_id "
                + "LEFT JOIN ( "
                + "    SELECT product_id, COUNT(unit_id) AS available_quantity "
                + "    FROM Product_units "
                + "    WHERE status = 'AVAILABLE' " // Thêm điều kiện status
                + "    GROUP BY product_id "
                + ") v ON p.product_id = v.product_id "
                + "WHERE 1 = 1 ";

        ArrayList<Object> params = new ArrayList<>();

        if (brandName != null && !brandName.isEmpty()) {
            sql += " AND b.brand_name = ? ";
            params.add(brandName);
        }
        if (cpu != null && !cpu.isEmpty()) {
            sql += " AND s.cpu = ? ";
            params.add(cpu);
        }
        if (memory != null && !memory.isEmpty()) {
            sql += " AND s.memory = ? ";
            params.add(memory);
        }
        if (storage != null && !storage.isEmpty()) {
            sql += " AND s.storage = ? ";
            params.add(storage);
        }
        if (color != null && !color.isEmpty()) {
            sql += " AND s.color = ? ";
            params.add(color);
        }
        if (battery > 0) {
            sql += " AND s.battery_capacity = ? ";
            params.add(battery);
        }
        if (screenSize != null && screenSize.compareTo(BigDecimal.ZERO) > 0) {
            sql += " AND s.screen_size BETWEEN ? - 0.05 AND ? + 0.05 ";
            params.add(screenSize);
            params.add(screenSize);
        }
        if (screenType != null && !screenType.isEmpty()) {
            sql += " AND s.screen_type = ? ";
            params.add(screenType);
        }
        if (camera > 0) {
            sql += " AND s.camera = ? ";
            params.add(camera);
        }
        if (minPrice != null) {
            sql += " AND u.purchase_price >= ? ";
            params.add(minPrice);
        }
        if (maxPrice != null) {
            sql += " AND u.purchase_price <= ? ";
            params.add(maxPrice);
        }
        if (keyWord != null && !keyWord.trim().isEmpty()) {
            sql += " AND (p.name COLLATE Latin1_General_CI_AI LIKE ? "
                    + " OR p.sku_code COLLATE Latin1_General_CI_AI LIKE ?) ";
            params.add("%" + keyWord.trim() + "%");
            params.add("%" + keyWord.trim() + "%");
        }

        PreparedStatement stm = connection.prepareStatement(sql);

        for (int i = 0; i < params.size(); i++) {
            stm.setObject(i + 1, params.get(i));
        }

        ResultSet rs = stm.executeQuery();
        int total = 0;
        if (rs.next()) {
            total = rs.getInt("total_count");
        }

        rs.close();
        stm.close();

        return total;
    }
}