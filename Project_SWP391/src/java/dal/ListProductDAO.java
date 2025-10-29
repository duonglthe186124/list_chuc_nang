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
                             distinct p.product_id,
                             p.[name],
                             p.sku_code,
                             b.brand_name,
                             ps.cpu,
                             ps.memory,
                             ps.storage,
                             ps.camera,
                             pu.purchase_price,
                             pim.image_url,
                             ISNULL(available_qty.Quantity, 0) AS available_quantity
                         FROM Products p
                         JOIN Brands b ON p.brand_id = b.brand_id
                         JOIN Product_specs ps ON p.spec_id = ps.spec_id
                         JOIN Product_images pim ON p.product_id = pim.product_id
                         JOIN Product_units pu ON p.product_id = pu.product_id
                         LEFT JOIN (
                             SELECT 
                                 pu.product_id,
                                 COUNT(*) AS Quantity
                             FROM Product_units pu
                             WHERE pu.status = 'AVAILABLE'
                             GROUP BY pu.product_id
                         ) available_qty ON p.product_id = available_qty.product_id
                         ORDER BY p.[name]
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
        String sql = "SELECT COUNT(*) AS total FROM Products";
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt("total");
        }
        return 0;
    }
}
