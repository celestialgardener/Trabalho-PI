/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package backend;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author feric
 */
public class conexao {

        private Connection c;
        
        public Connection getConnection() throws ClassNotFoundException, SQLException {
        String hostName = "localhost";
        String dbName = "Overclock";
        String user = "sa";
        String senha = "SuaSenhaForte123!";
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        c = DriverManager.getConnection(String.format(
            "jdbc:sqlserver://%s:1433;databaseName=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=true;",
            hostName, dbName, user, senha));

        return c;
        }
    
    }

