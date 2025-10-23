/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import dto.ProductInfoScreen_DuongLT;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class ListProductDBContext extends DBContext {

    public ArrayList<ProductInfoScreen_DuongLT> getProductsByPage(int pageIndex, int pageSize) throws SQLException {
        ArrayList<ProductInfoScreen_DuongLT> list = new ArrayList<>();

        String sql = """
                     SELECT 
                         A.product_id,
                         A.[name],
                         A.sku_code,
                         A.brand_name,
                         A.cpu,
                         A.memory,
                         A.storage,
                         A.camera,
                         A.purchase_price,
                         A.image_url,
                         ISNULL(B.total_quantity, 0) AS total_quantity
                     FROM (
                         SELECT 
                             p.product_id,
                             p.[name],
                             p.sku_code,
                             b.brand_name, 
                             s.cpu,
                             s.memory,
                             s.storage,
                             s.camera,
                     \t\tu.purchase_price,
                             img.image_url
                         FROM Products p 
                         JOIN Brands b ON p.brand_id = b.brand_id 
                         JOIN Product_specs s ON p.spec_id = s.spec_id
                     \tjoin Product_units u on u.product_id = p.product_id
                         LEFT JOIN Product_images img ON p.product_id = img.product_id
                     ) AS A
                     LEFT JOIN (
                         SELECT
                             p.product_id,
                             COUNT(pu.unit_id) AS total_quantity
                         FROM Products p
                         LEFT JOIN Product_units pu ON p.product_id = pu.product_id
                         GROUP BY p.product_id
                     ) AS B ON A.product_id = B.product_id
                     ORDER BY A.[name]OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;""";

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, (pageIndex - 1) * pageSize);
        stm.setInt(2, pageSize);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            ProductInfoScreen_DuongLT p = new ProductInfoScreen_DuongLT();
            p.setProductId(rs.getInt("product_id"));
            p.setProductName(rs.getString("name"));
            p.setSku_code(rs.getString("sku_code"));
            p.setBrandName(rs.getString("brand_name"));
            p.setCpu(rs.getString("cpu"));
            p.setMemory(rs.getString("memory"));
            p.setStorage(rs.getString("storage"));
            p.setCamera(rs.getInt("camera"));
            p.setQty(rs.getInt("total_quantity"));
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
