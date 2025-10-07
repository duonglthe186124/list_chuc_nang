package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.*;
import model.Inventory_transactions;

public class TransactionDAO extends DBContext {

    public List<Inventory_transactions> get_inventory_transactions() {
        List<Inventory_transactions> list = new ArrayList();

        String sql = "SELECT \n"
                + "	tx_id,\n"
                + "	tx_type,\n"
                + "	product_id,\n"
                + "	unit_id,\n"
                + "	qty,\n"
                + "	from_location,\n"
                + "	to_location,\n"
                + "	ref_code,\n"
                + "	related_inbound_id,\n"
                + "	related_outbound_id,\n"
                + "	employee_id,\n"
                + "	tx_date,\n"
                + "	note\n"
                + "FROM Inventory_transactions";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Inventory_transactions tx = new Inventory_transactions(
                        rs.getInt("tx_id"),
                        rs.getString("tx_type"),
                        rs.getInt("product_id"),
                        rs.getInt("unit_id"),
                        rs.getInt("qty"),
                        (Integer) rs.getObject("from_location"),
                        (Integer) rs.getObject("to_location"),
                        rs.getString("ref_code"),
                        rs.getObject("related_inbound_id", Integer.class),
                        rs.getObject("related_outbound_id", Integer.class),
                        rs.getInt("employee_id"),
                        rs.getDate("tx_date"),
                        rs.getString("note"));
                list.add(tx);
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        TransactionDAO dao = new TransactionDAO();
        List<Inventory_transactions> list = dao.get_inventory_transactions();
        if (!list.isEmpty()) {
            System.out.println(list.get(0).getFrom_location());
        }
    }
}
