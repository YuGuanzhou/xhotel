<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%!
    // 数据库配置
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/db_xhotel?serverTimezone=GMT%2B8&useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "YU789321";
    
    // 连接池配置
    private static final int MAX_POOL_SIZE = 10;
    private static List<Connection> connectionPool = new ArrayList<>();
    private static final Object lock = new Object();
    
    static {
        try {
            Class.forName(DRIVER);
            for (int i = 0; i < MAX_POOL_SIZE; i++) {
                connectionPool.add(createConnection());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private static Connection createConnection() throws SQLException {
        return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
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
%>
