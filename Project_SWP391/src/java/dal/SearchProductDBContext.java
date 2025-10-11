/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import model.ProductInfoScreen_DuongLT;
import model.SpecsOptions;

/**
 *
 * @author hoang
 */
public class SearchProductDBContext extends DBContext {

    public ArrayList<ProductInfoScreen_DuongLT> getProductsByPageFiltered(
            String brandName,
            String cpu,
            String memory,
            String storage,
            String color,
            int battery,
            float screenSize,
            String screenType,
            int camera,
            BigDecimal minPrice,
            BigDecimal maxPrice
    ) throws SQLException {

        ArrayList<ProductInfoScreen_DuongLT> list = new ArrayList<>();

        String sql = "SELECT \n"
                + "    p.product_id,\n"
                + "    p.product_name,\n"
                + "    b.brand_name,\n"
                + "    s.cpu,\n"
                + "    s.memory,\n"
                + "    s.storage,\n"
                + "    s.camera,\n"
                + "    pt.[type_name],\n"
                + "    v.qty,\n"
                + "    i.image_url\n"
                + "FROM Products p\n"
                + "JOIN Brands b ON p.brand_id = b.brand_id\n"
                + "JOIN Product_specs s ON p.spec_id = s.spec_id\n"
                + "JOIN Product_units u ON p.product_id = u.product_id\n"
                + "join Product_images i on p.product_id = i.product_id\n"
                + "join Inventory_records v on  p.product_id = v.product_id\n"
                + "join Product_types pt on  p.product_id = pt.[type_id]\n"
                + "WHERE 1 = 1";

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

        if (screenSize > 0) {
            sql += " AND s.screen_size = ? ";
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
            sql += " AND u.unit_price >= ? ";
            params.add(minPrice);
        }

        if (maxPrice != null) {
            sql += " AND u.unit_price <= ? ";
            params.add(maxPrice);
        }
        PreparedStatement stm = connection.prepareStatement(sql);
        for (int i = 0; i < params.size(); i++) {
            stm.setObject(i + 1, params.get(i));
        }

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

    public int countProductsFiltered(SpecsOptions filter) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Products p "
                + "JOIN Brands b ON p.brand_id = b.brand_id "
                + "JOIN Product_specs s ON p.spec_id = s.spec_id "
                + "WHERE 1=1";

        ArrayList<Object> params = new ArrayList<>();

        if (filter.getBrandName() != null && !filter.getBrandName().isEmpty()) {
            sql += " AND b.brand_name = ?";
            params.add(filter.getBrandName());
        }
        if (filter.getCpu() != null && !filter.getCpu().isEmpty()) {
            sql += " AND s.cpu = ?";
            params.add(filter.getCpu());
        }
        if (filter.getMinPrice() != null) {
            sql += " AND p.price >= ?";
            params.add(filter.getMinPrice());
        }
        if (filter.getMaxPrice() != null) {
            sql += " AND p.price <= ?";
            params.add(filter.getMaxPrice());
        }

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                stm.setObject(i + 1, params.get(i));
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

   

}
