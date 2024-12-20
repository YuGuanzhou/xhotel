package com.xhotel.util;

import java.sql.*;
import java.io.*;
import java.util.Properties;
import com.mysql.cj.jdbc.MysqlConnectionPoolDataSource;
import com.mysql.cj.jdbc.MysqlDataSource;

public class DBUtil {
    private static MysqlConnectionPoolDataSource dataSource;
    
    static {
        try {
            Properties prop = new Properties();
            InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("data_source.properties");
            prop.load(in);
            
            dataSource = new MysqlConnectionPoolDataSource();
            dataSource.setURL(prop.getProperty("jdbc.url"));
            dataSource.setUser(prop.getProperty("jdbc.username"));
            dataSource.setPassword(prop.getProperty("jdbc.password"));
            
            // 设置连接池参数
            dataSource.setMaxConnections(20); // 最大连接数
            dataSource.setLoginTimeout(5); // 连接超时时间（秒）
            
            // 设置连接参数
            dataSource.setCharacterEncoding("UTF-8");
            dataSource.setUseUnicode(true);
            
            // 设置缓存参数
            dataSource.setCachePrepStmts(true);
            dataSource.setPrepStmtCacheSize(25);
            dataSource.setPrepStmtCacheSqlLimit(256);
            
            // 设置其他优化参数
            dataSource.setUseServerPrepStmts(true);
            dataSource.setRewriteBatchedStatements(true);
            dataSource.setMaintainTimeStats(false);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource not initialized!");
        }
        Connection conn = dataSource.getConnection();
        conn.setAutoCommit(true); // 默认开启自动提交
        return conn;
    }
    
    public static void close(ResultSet rs, Statement stmt, Connection conn) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        if (conn != null) {
            try {
                if (!conn.getAutoCommit()) {
                    conn.setAutoCommit(true); // 恢复默认的自动提交状态
                }
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void close(Statement stmt, Connection conn) {
        close(null, stmt, conn);
    }
    
    public static void close(Connection conn) {
        close(null, null, conn);
    }
}
