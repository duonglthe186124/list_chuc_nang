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
    
    String sql = """
        SELECT
            p.product_id,
            p.[name],
            p.sku_code,
            b.brand_name,
            ps.cpu,
            ps.memory,
            ps.storage,
            ps.camera,
            ISNULL(pu.purchase_price, 0) AS purchase_price,
            pim.image_url,
            ISNULL(available_qty.Quantity, 0) AS available_quantity
        FROM Products p
        JOIN Brands b ON p.brand_id = b.brand_id
        JOIN Product_specs ps ON p.spec_id = ps.spec_id
        LEFT JOIN Product_images pim ON p.product_id = pim.product_id
        LEFT JOIN (
            SELECT product_id, purchase_price
            FROM Product_units
            WHERE status = 'AVAILABLE'
            GROUP BY product_id, purchase_price
        ) pu ON p.product_id = pu.product_id
        LEFT JOIN (
            SELECT product_id, purchase_price, COUNT(*) AS Quantity
            FROM Product_units
            WHERE status = 'AVAILABLE'
            GROUP BY product_id, purchase_price
        ) available_qty
            ON p.product_id = available_qty.product_id
            AND ISNULL(pu.purchase_price, 0) = ISNULL(available_qty.purchase_price, 0)
        WHERE 1 = 1
        """;

    ArrayList<Object> params = new ArrayList<>();

    // === BỘ LỌC ===
    if (brandName != null && !brandName.isEmpty()) {
        sql += " AND b.brand_name = ? ";
        params.add(brandName);
    }
    if (cpu != null && !cpu.isEmpty()) {
        sql += " AND ps.cpu = ? ";  // ĐÚNG: ps
        params.add(cpu);
    }
    if (memory != null && !memory.isEmpty()) {
        sql += " AND ps.memory = ? ";
        params.add(memory);
    }
    if (storage != null && !storage.isEmpty()) {
        sql += " AND ps.storage = ? ";
        params.add(storage);
    }
    if (color != null && !color.isEmpty()) {
        sql += " AND ps.color = ? ";
        params.add(color);
    }
    if (battery > 0) {
        sql += " AND ps.battery_capacity = ? ";
        params.add(battery);
    }
    if (screenSize != null && screenSize.compareTo(BigDecimal.ZERO) > 0) {
        sql += " AND ps.screen_size BETWEEN ? - 0.05 AND ? + 0.05 ";
        params.add(screenSize);
        params.add(screenSize);
    }
    if (screenType != null && !screenType.isEmpty()) {
        sql += " AND ps.screen_type = ? ";
        params.add(screenType);
    }
    if (camera > 0) {
        sql += " AND ps.camera = ? ";
        params.add(camera);
    }
    if (minPrice != null) {
        sql += " AND ISNULL(pu.purchase_price, 0) >= ? ";  // ĐÚNG: pu
        params.add(minPrice);
    }
    if (maxPrice != null) {
        sql += " AND ISNULL(pu.purchase_price, 0) <= ? ";
        params.add(maxPrice);
    }
    if (keyWord != null && !keyWord.trim().isEmpty()) {
        String kw = "%" + keyWord.trim() + "%";
        sql += " AND (p.name COLLATE Latin1_General_CI_AI LIKE ? OR p.sku_code COLLATE Latin1_General_CI_AI LIKE ?) ";
        params.add(kw);
        params.add(kw);
    }

    // === PHÂN TRANG ===
    sql += " ORDER BY p.product_id, ISNULL(pu.purchase_price, 0) "
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
        p.setQty(rs.getInt("available_quantity"));
        p.setImageUrl(rs.getString("image_url"));
        list.add(p);
    }
    return list;
}

   
public int countFilteredProducts(
        String brandName, String cpu, String memory, String storage, String color,
        int battery, BigDecimal screenSize, String screenType, int camera,
        BigDecimal minPrice, BigDecimal maxPrice, String keyWord
) throws SQLException {

    String sql = """
        SELECT COUNT(*) AS total_count
        FROM (
            SELECT
                p.product_id,
                ISNULL(pu.purchase_price, 0) AS purchase_price
            FROM Products p
            JOIN Brands b ON p.brand_id = b.brand_id
            JOIN Product_specs ps ON p.spec_id = ps.spec_id
            LEFT JOIN (
                SELECT product_id, purchase_price
                FROM Product_units
                WHERE status = 'AVAILABLE'
                GROUP BY product_id, purchase_price
            ) pu ON p.product_id = pu.product_id
            WHERE 1 = 1
        """;

    ArrayList<Object> params = new ArrayList<>();

    // === BỘ LỌC (giống hệt getProductsByPageFiltered) ===
    if (brandName != null && !brandName.isEmpty()) {
        sql += " AND b.brand_name = ? ";
        params.add(brandName);
    }
    if (cpu != null && !cpu.isEmpty()) {
        sql += " AND ps.cpu = ? ";
        params.add(cpu);
    }
    if (memory != null && !memory.isEmpty()) {
        sql += " AND ps.memory = ? ";
        params.add(memory);
    }
    if (storage != null && !storage.isEmpty()) {
        sql += " AND ps.storage = ? ";
        params.add(storage);
    }
    if (color != null && !color.isEmpty()) {
        sql += " AND ps.color = ? ";
        params.add(color);
    }
    if (battery > 0) {
        sql += " AND ps.battery_capacity = ? ";
        params.add(battery);
    }
    if (screenSize != null && screenSize.compareTo(BigDecimal.ZERO) > 0) {
        sql += " AND ps.screen_size BETWEEN ? - 0.05 AND ? + 0.05 ";
        params.add(screenSize);
        params.add(screenSize);
    }
    if (screenType != null && !screenType.isEmpty()) {
        sql += " AND ps.screen_type = ? ";
        params.add(screenType);
    }
    if (camera > 0) {
        sql += " AND ps.camera = ? ";
        params.add(camera);
    }
    if (minPrice != null) {
        sql += " AND ISNULL(pu.purchase_price, 0) >= ? ";
        params.add(minPrice);
    }
    if (maxPrice != null) {
        sql += " AND ISNULL(pu.purchase_price, 0) <= ? ";
        params.add(maxPrice);
    }
    if (keyWord != null && !keyWord.trim().isEmpty()) {
        String kw = "%" + keyWord.trim() + "%";
        sql += " AND (p.name COLLATE Latin1_General_CI_AI LIKE ? OR p.sku_code COLLATE Latin1_General_CI_AI LIKE ?) ";
        params.add(kw);
        params.add(kw);
    }

    sql += ") AS filtered_rows";

    PreparedStatement stm = connection.prepareStatement(sql);
    for (int i = 0; i < params.size(); i++) {
        stm.setObject(i + 1, params.get(i));
    }

    ResultSet rs = stm.executeQuery();
    return rs.next() ? rs.getInt("total_count") : 0;
}
}
