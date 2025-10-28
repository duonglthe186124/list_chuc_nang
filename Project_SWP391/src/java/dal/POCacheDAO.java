package dal;

import java.util.Date;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class POCacheDAO extends DBContext {

    public Date date() {
        Date now = new Date();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT po_code_date FROM PO_Cache");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    now = rs.getDate("po_code_date");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return now;
    }

    public int no() {
        int no = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT po_code_no FROM PO_Cache");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    no = rs.getInt("po_code_no");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return no;
    }

    public void update(int no) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE PO_Cache\n"
                + "SET \n"
                + "    po_code_date = CAST(GETDATE() AS DATE),\n"
                + "    po_code_no = ?;");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, no);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
