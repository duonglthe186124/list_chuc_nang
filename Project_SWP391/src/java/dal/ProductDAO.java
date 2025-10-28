package dal;

import dto.Response_ProductDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBContext;

/**
 *
 * @author ASUS
 */
public class ProductDAO extends DBContext {

    public List<Response_ProductDTO> list_product_sku() {
        List<Response_ProductDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT product_id, sku_code FROM Products");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ProductDTO line = new Response_ProductDTO(
                            rs.getInt("product_id"),
                            rs.getString("sku_code"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String name_product(int product_id) {
        String product_name = "";
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT name FROM Products\n"
                + "WHERE product_id = ?;");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, product_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    product_name = rs.getString("name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product_name;
    }
}
