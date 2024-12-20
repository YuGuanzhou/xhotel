<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%!
public static class DBUtil {
    private static Properties props = new Properties();
    private static String DRIVER;
    private static String URL;
    private static String DB_USER;
    private static String DB_PASSWORD;
    
    // 连接池配置
    private static final int MAX_POOL_SIZE = 10;
    private static List<Connection> connectionPool = new ArrayList<>();
    private static final Object lock = new Object();
    
    static {
        try {
            // 硬编码数据库配置
            DRIVER = "com.mysql.cj.jdbc.Driver";
            URL = "jdbc:mysql://localhost:3306/db_xhotel?serverTimezone=GMT%2B8&useSSL=false&allowPublicKeyRetrieval=true";
            DB_USER = "root";
            DB_PASSWORD = "YU789321";
            
            System.out.println("正在初始化数据库连接...");
            System.out.println("驱动: " + DRIVER);
            System.out.println("URL: " + URL);
            System.out.println("用户: " + DB_USER);
            
            Class.forName(DRIVER);
            for (int i = 0; i < MAX_POOL_SIZE; i++) {
                connectionPool.add(createConnection());
            }
            System.out.println("数据库连接池初始化成功，大小: " + MAX_POOL_SIZE);
        } catch (Exception e) {
            System.out.println("数据库连接初始化失败: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    private static Connection createConnection() throws SQLException {
        try {
            return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.out.println("创建数据库连接失败: " + e.getMessage());
            throw e;
        }
    }
    
    public static Connection getConnection() throws SQLException {
        synchronized (lock) {
            if (connectionPool.isEmpty()) {
                return createConnection();
            }
            return connectionPool.remove(connectionPool.size() - 1);
        }
    }
    
    public static void releaseConnection(Connection conn) {
        if (conn != null) {
            synchronized (lock) {
                if (connectionPool.size() < MAX_POOL_SIZE) {
                    connectionPool.add(conn);
                } else {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
%>
