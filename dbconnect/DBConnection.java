package dbconnect;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	String driver="com.mysql.jdbc.Driver";
	String url="jdbc:mysql://localhost/bloodbankservices";
	String db_uname = "root";
	String db_pass = "root";
	
	
	public Connection getConnetion() throws Exception {
		// TODO Auto-generated method stub
		Class.forName(driver);
		return DriverManager.getConnection(url, db_uname, db_pass);
	}
	
}

