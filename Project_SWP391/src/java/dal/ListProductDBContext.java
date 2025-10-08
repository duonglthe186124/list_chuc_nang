/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import model.ProductInfoScreen_DuongLT;

/**
 *
 * @author hoang
 */
public class ListProductDBContext extends DBContext {

    public ArrayList<ProductInfoScreen_DuongLT> listAllProducts() throws SQLException {
        ArrayList<ProductInfoScreen_DuongLT> list = new ArrayList<>();

        String sql = "SELECT "
                + "p.product_id, "
                + "p.product_name, "
                + "b.brand_name, "
                + "s.cpu, "
                + "s.memory, "
                + "s.storage, "
                + "s.camera, "
                + "t.type_name, "
                + "i.qty, "
                + "img.image_url "
                + "FROM Products p "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "JOIN Product_specs s ON p.spec_id = s.spec_id "
                + "JOIN Product_types t ON p.type_id = t.type_id "
                + "JOIN Inventory_records i ON p.product_id = i.product_id "
                + "LEFT JOIN Product_images img ON p.product_id = img.product_id";

        try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {

            while (rs.next()) {
                ProductInfoScreen_DuongLT p = new ProductInfoScreen_DuongLT();
                p.setProductId(rs.getInt("product_id"));
                p.setProductName(rs.getString("product_name"));
                p.setBrandName(rs.getString("brand_name"));
                p.setCpu(rs.getString("cpu"));
                p.setMemory(rs.getString("memory"));
                p.setStorage(rs.getString("storage")); // ✅ sửa lại
                p.setCamera(rs.getInt("camera"));
                p.setTypeName(rs.getString("type_name"));
                p.setQty(rs.getInt("qty"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        }

        return list;
    }
    
    public ArrayList<ProductInfoScreen_DuongLT> getProductsByPage(int pageIndex, int pageSize) throws SQLException {
    ArrayList<ProductInfoScreen_DuongLT> list = new ArrayList<>();

    String sql = "SELECT p.product_id, p.product_name, b.brand_name, s.cpu, s.memory, "
               + "s.storage, s.camera, t.type_name, i.qty, img.image_url "
               + "FROM Products p "
               + "JOIN Brands b ON p.brand_id = b.brand_id "
               + "JOIN Product_specs s ON p.spec_id = s.spec_id "
               + "JOIN Product_types t ON p.type_id = t.type_id "
               + "JOIN Inventory_records i ON p.product_id = i.product_id "
               + "LEFT JOIN Product_images img ON p.product_id = img.product_id "
               + "ORDER BY p.product_id "
               + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    PreparedStatement stm = connection.prepareStatement(sql);
    stm.setInt(1, (pageIndex - 1) * pageSize);
    stm.setInt(2, pageSize);
    ResultSet rs = stm.executeQuery();

    while (rs.next()) {
        ProductInfoScreen_DuongLT p = new ProductInfoScreen_DuongLT();
        p.setProductId(rs.getInt("product_id"));
        p.setProductName(rs.getString("product_name"));
        p.setBrandName(rs.getString("brand_name"));
        p.setCpu(rs.getString("cpu"));
        p.setMemory(rs.getString("memory"));
        p.setStorage(rs.getString("storage"));
        p.setCamera(rs.getInt("camera"));
        p.setTypeName(rs.getString("type_name"));
        p.setQty(rs.getInt("qty"));
        p.setImageUrl(rs.getString("image_url"));
        list.add(p);
    }

    return list;
}
    public int countProducts() throws SQLException {
    String sql = "SELECT COUNT(*) AS total FROM Products";
    PreparedStatement stm = connection.prepareStatement(sql);
    ResultSet rs = stm.executeQuery();
    if (rs.next()) return rs.getInt("total");
    return 0;
}
}

