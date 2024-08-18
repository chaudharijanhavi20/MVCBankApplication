package Queries;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConnection {

	private static final String URL = "jdbc:mysql://localhost:3306/bankApplicationdb";
	private static final String USER = "root";
	private static final String PASSWORD = "Janhavi@123";

	public Connection connectToDb() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}
}
