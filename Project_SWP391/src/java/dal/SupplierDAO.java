package dal;

import dto.Response_SupplierDTO;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Suppliers;

/**
 *
 * @author ASUS
 */
public class SupplierDAO extends DBContext {

    public List<Response_SupplierDTO> list_supplier() {
        List<Response_SupplierDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.supplier_id, s.supplier_name FROM Suppliers s");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_SupplierDTO line = new Response_SupplierDTO(
                            rs.getInt("supplier_id"),
                            rs.getString("supplier_name"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Suppliers> suppliers(String search_input, int offset, int page_size) {
        List<Suppliers> list = new ArrayList();
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT * FROM Suppliers WHERE 1 = 1 ");

        if (search_input != null && !search_input.trim().isEmpty()) {
            sql.append("AND supplier_name LIKE ? OR address LIKE ? OR phone LIKE ?");
            params.add(search_input);
            params.add(search_input);
            params.add(search_input);
        }

        sql.append("ORDER BY supplier_id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(page_size);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Suppliers line = new Suppliers(
                            rs.getInt("supplier_id"),
                            rs.getString("supplier_name"),
                            null,
                            rs.getString("address"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            null,
                            null,
                            null);
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int total_lines(String search_input) {
        int lines = 0;
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(supplier_id) AS line FROM Suppliers WHERE 1 = 1 ");

        if (search_input != null && !search_input.trim().isEmpty()) {
            sql.append("AND supplier_name LIKE ? OR address LIKE ? OR phone LIKE ?");
            params.add(search_input);
            params.add(search_input);
            params.add(search_input);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lines = rs.getInt("line");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lines;
    }

    public String supplier_email(int supplier_id) {
        String email = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT email FROM Suppliers WHERE supplier_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, supplier_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    email = rs.getString("email");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return email;
    }

    public Suppliers supplier(int supplier_id) {
        Suppliers supplier = null;
        String sql = "SELECT * FROM Suppliers WHERE supplier_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, supplier_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    supplier = new Suppliers(
                            rs.getInt("supplier_id"),
                            rs.getString("supplier_name"),
                            rs.getString("display_name"),
                            rs.getString("address"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            rs.getString("representative"),
                            rs.getString("payment_method"),
                            rs.getString("note"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplier;
    }
}
