package dal;

import dto.POLineResponseDTO;
import dto.ReceiptHeaderDTO;
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

    public List<ReceiptHeaderDTO> PO_list() {
        List<ReceiptHeaderDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	po.po_id,\n"
                + "	po.po_code,\n"
                + "	s.display_name,\n"
                + "	po.created_at,\n"
                + "	po.note\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "WHERE po.status = 'PENDING' OR po.status = 'ACTIVE'");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReceiptHeaderDTO line = new ReceiptHeaderDTO(
                            rs.getInt("po_id"),
                            rs.getString("po_code"),
                            rs.getString("display_name"),
                            rs.getDate("created_at"),
                            rs.getString("note"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<POLineResponseDTO> po_line(int po_id) {
        List<POLineResponseDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "*\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "LEFT JOIN Products p ON po.product_id = p.product_id\n"
                + "WHERE 1 = 1 ");

        sql.append("AND po.po_id = ? ");
        
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    POLineResponseDTO line = new POLineResponseDTO(
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
