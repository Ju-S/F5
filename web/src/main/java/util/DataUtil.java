package util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

// Connection을 얻기 위한 Util Class
public class DataUtil {
    private static final DataSource dataSource;

    // 연속되는 dataSource lookup을 방지.
    static {
        try {
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/study");
        } catch (Exception e) {
            throw new ExceptionInInitializerError("DataSource lookup failed: " + e.getMessage());
        }
    }

    // new 방지.
    private DataUtil(){}

    public static Connection getConnection() throws Exception {
        return dataSource.getConnection();
    }
}
