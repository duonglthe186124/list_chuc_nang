package dal;

import dto.ProductInfo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class ListProductDAO extends DBContext {

    public ArrayList<ProductInfo> getProductsByPage(int pageIndex, int pageSize) throws SQLException {
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
                         ISNULL(avail.available_quantity, 0) AS available_quantity,
                         ISNULL(COALESCE(avail.purchase_price, all_prices.purchase_price), 0) AS purchase_price,
                         pim.image_url
                     FROM Products p
                     JOIN Brands b ON p.brand_id = b.brand_id
                     JOIN Product_specs ps ON p.spec_id = ps.spec_id
                     LEFT JOIN Product_images pim ON p.product_id = pim.product_id
                     LEFT JOIN (
                         -- Lấy TẤT CẢ các mức giá từng có của product (kể cả đã hết)
                         SELECT DISTINCT
                             product_id,
                             purchase_price
                         FROM Product_units
                     ) all_prices ON p.product_id = all_prices.product_id
                     LEFT JOIN (
                         -- Chỉ lấy số lượng AVAILABLE
                         SELECT 
                             product_id,
                             purchase_price,
                             COUNT(*) AS available_quantity
                         FROM Product_units
                         WHERE status = 'AVAILABLE'
                         GROUP BY product_id, purchase_price
                     ) avail ON all_prices.product_id = avail.product_id 
                             AND all_prices.purchase_price = avail.purchase_price
                     ORDER BY p.product_id
                     OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;""";

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, (pageIndex - 1) * pageSize);
        stm.setInt(2, pageSize);
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
            p.setQty(rs.getInt("available_quantity"));
            p.setPrice(rs.getBigDecimal("purchase_price"));
            p.setImageUrl(rs.getString("image_url"));
            list.add(p);
        }

        return list;
    }

    public int countProducts() throws SQLException {
        String sql = """
                     SELECT COUNT(*) AS total
                     FROM (
                         SELECT
                             p.product_id,
                             ISNULL(all_prices.purchase_price, 0) AS purchase_price
                         FROM Products p
                         LEFT JOIN (
                             -- Lấy TẤT CẢ các mức giá từng có
                             SELECT DISTINCT product_id, purchase_price
                             FROM Product_units
                         ) all_prices ON p.product_id = all_prices.product_id
                         GROUP BY p.product_id, ISNULL(all_prices.purchase_price, 0)
                     ) AS filtered_products
                     """;
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt("total");
        }
        return 0;
    }

}
