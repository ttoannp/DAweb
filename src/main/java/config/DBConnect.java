package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {

    // Thông tin cấu hình kết nối
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/nhadat_db?useSSL=false&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "123456";

    /**
     * Trả về một đối tượng Connection kết nối tới CSDL MySQL
     * @return Connection
     * @throws SQLException nếu xảy ra lỗi trong quá trình kết nối
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Nạp Driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Trả về kết nối
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (ClassNotFoundException e) {
            // Nếu Driver không tồn tại trong classpath
            throw new SQLException("Không tìm thấy JDBC Driver: com.mysql.cj.jdbc.Driver", e);
        }
    }
}
