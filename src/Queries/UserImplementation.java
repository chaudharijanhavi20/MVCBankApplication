package Queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import Model.IUser;
import Model.User;

public class UserImplementation implements IUser {
	public User validateUser(String email, String password) throws ClassNotFoundException {
		User user = null;
		String sql = "SELECT * FROM Users WHERE email = ? AND password = ?";

		try {
			dbConnection dbConn = new dbConnection();
			Connection connection = dbConn.connectToDb();

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery();

			System.out.println("Executing query with email: " + email + " and password: " + password);

			if (rs.next()) {
				user = new User(rs.getInt("user_id"), rs.getString("email"), rs.getString("password"),
						rs.getString("role"));

			} else {
				System.out.println("No user found with the provided credentials.");
			}

			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return user;
	}
}
