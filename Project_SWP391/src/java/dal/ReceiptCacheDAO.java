package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import util.DBContext;

/**
 *
 * @author ASUS
 */
public class ReceiptCacheDAO extends DBContext{
    public Date date() {
        Date now = new Date();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT receipt_code_date FROM PNK_Cache");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    now = rs.getDate("receipt_code_date");
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
        sql.append("SELECT receipt_code_no FROM PNK_Cache");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    no = rs.getInt("receipt_code_no");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return no;
    }

    public void update(int no) {
        StringBuilder sql = new StringBuilder();
        sql.append("UPDATE PNK_Cache\n"
                + "SET \n"
                + "    receipt_code_date = CAST(GETDATE() AS DATE),\n"
                + "    receipt_code_no = ?;");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, no);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
