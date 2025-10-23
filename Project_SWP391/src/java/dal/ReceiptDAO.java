package dal;

import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ReceiptDAO extends DBContext {

    public List<Response_ReceiptOrderDTO> PO_list() {
        List<Response_ReceiptOrderDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	po.po_id,\n"
                + "	po.po_code\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "WHERE po.status = 'PENDING' OR po.status = 'ACTIVE'");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ReceiptOrderDTO line = new Response_ReceiptOrderDTO(
                            rs.getInt("po_id"),
                            rs.getString("po_code"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public Response_ReceiptHeaderDTO po_header(int po_id)
    {
        Response_ReceiptHeaderDTO line = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	s.display_name,\n"
                + "	po.created_at,\n"
                + "	po.note\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "WHERE (po.status = 'PENDING' OR po.status = 'ACTIVE') AND po.po_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    line = new Response_ReceiptHeaderDTO(
                            rs.getString("display_name"),
                            rs.getDate("created_at"),
                            rs.getString("note"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }

    public List<Response_ReceiptLineDTO> po_line(int po_id) {
        List<Response_ReceiptLineDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "*\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "LEFT JOIN Products p ON pol.product_id = p.product_id\n"
                + "WHERE 1 = 1 ");

        sql.append("AND po.po_id = ? ");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ReceiptLineDTO line = new Response_ReceiptLineDTO(
                            rs.getInt("product_id"),
                            rs.getString("name"),
                            rs.getFloat("unit_price"),
                            rs.getInt("qty"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
