/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ConnectionFactory;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
/**
 *
 * @author Felipe
 */
public class ConnectionFactory {
    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection != null)
            return connection;
        else {
            try {
                Properties prop = new Properties();
                
                String user = "root";
                String password = "";
                Class.forName("com.mysql.jdbc.Driver"); // Para quem for usar MySql
//                Class.forName("org.postgresql.Driver");// Para quem for usar Postgres
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/beibe", user, password);// Para quem for usar MySql
//                connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/userdb",user, password);// Para quem for usar Postgres
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            return connection;
        }

    }
    
}
