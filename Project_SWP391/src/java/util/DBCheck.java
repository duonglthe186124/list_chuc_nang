package util;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBCheck {
    public static void main(String[] args) {
        System.out.println("== Bắt đầu kiểm tra kết nối tới SWP391_WarehouseManagements ==");
        DBContext ctx = new DBContext();

        // DBContext.connection là protected; vì DBTest cùng package 'dal' nên có thể truy cập trực tiếp.
        try (Connection conn = ctx.connection) {
            if (conn == null || conn.isClosed()) {
                System.err.println("-> Không có kết nối (null hoặc đã đóng). Kiểm tra URL/username/password/SQL Server.");
                return;
            }

            // Thực hiện truy vấn test
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT 1 AS ok")) {

                if (rs.next() && rs.getInt("ok") == 1) {
                    DatabaseMetaData md = conn.getMetaData();
                    System.out.println("✔ Kết nối thành công!");
                    System.out.println("  DB Product : " + md.getDatabaseProductName());
                    System.out.println("  DB Version : " + md.getDatabaseProductVersion());
                    System.out.println("  DB URL     : " + md.getURL());
                    System.out.println("  DB User    : " + md.getUserName());
                } else {
                    System.err.println("⚠ Kết nối được nhưng truy vấn kiểm tra trả về không như mong đợi.");
                }
            }
        } catch (SQLException ex) {
            System.err.println("✖ Lỗi khi kiểm tra kết nối: " + ex.getMessage());
            ex.printStackTrace(System.err);

            System.err.println("\nGợi ý khắc phục nhanh:");
            System.err.println("- Kiểm tra HOST/PORT trong connection URL (localhost:1433 hay IP thật).");
            System.err.println("- Nếu là named instance (SQLEXPRESS), dùng instanceName thay vì port hoặc bật SQL Browser.");
            System.err.println("- Kiểm tra SQL Server đã enable TCP/IP (SQL Server Configuration Manager).");
            System.err.println("- Mở firewall port 1433 (hoặc port SQL đang dùng).");
            System.err.println("- Kiểm tra credentials (sa / password) và SQL Authentication (mixed mode).");
        } finally {
            System.out.println("== Kiểm tra kết nối kết thúc ==");
        }
    }
}
