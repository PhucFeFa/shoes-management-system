// Author: PhucLHCE191132
package com.mycompany.shoestore.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    // TODO: Update these credentials to match your local SQL Server setup
    private final String serverName = "localhost";
    //private final String serverName = "SANG111203\\SQLEXPRESS";
    private final String dbName = "ShoesStore";
    //private final String dbName = "Shoes_Shop1";
    private final String portNumber = "1433";
    private final String instance = ""; // Leave blank if not using named instance
    private final String userID = "sa";
    private final String password = "123456"; // Your SA password
    //private final String password = "19092004"; // Your SA password

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName
                + ";encrypt=true;trustServerCertificate=true;";
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName
                    + ";encrypt=true;trustServerCertificate=true;";
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }
}
