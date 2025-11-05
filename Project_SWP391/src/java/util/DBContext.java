package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
    protected Connection connection;

    public DBContext() {
        try {
            // You can change these values or set system env vars: DB_URL, DB_USER, DB_PASS
            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASS");

            if (url == null || url.isEmpty()) {
                // default (your local dev). Add ;encrypt=false to avoid TLS issues.
                url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391_WarehouseManagements;encrypt=false;trustServerCertificate=true";
            }
            if (user == null || user.isEmpty()) user = "duonglt";
            if (pass == null || pass.isEmpty()) pass = "12345";

            // Load driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            // Connect
            connection = DriverManager.getConnection(url, user, pass);
            //System.out.println("[DBContext] Database connected successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBContext] JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
            connection = null;
        } catch (SQLException e) {
            System.err.println("[DBContext] Database connection failed: " + e.getMessage());
            e.printStackTrace();
            connection = null;
        }
    }
}