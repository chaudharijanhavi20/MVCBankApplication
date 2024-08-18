package Queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Logger;

import Model.Account;
import Model.LoggingUtility;

public class AccountDAO {
	private static Logger demologger = LoggingUtility.getLogger();

	public boolean createAccount(Account account) throws ClassNotFoundException {
		String sql = "INSERT INTO Accounts (account_number, customer_id, balance) VALUES (?, ?, ?)";

		try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setString(1, account.getAccountNumber());
			ps.setInt(2, account.getCustomerId());
			ps.setDouble(3, account.getBalance());

			demologger.info("Inserting account with number: " + account.getAccountNumber() + ", customer ID: "
					+ account.getCustomerId() + ", balance: " + account.getBalance());
			int rowsAffected = ps.executeUpdate();
			if (rowsAffected > 0) {
				demologger.info("Account created successfully for customer ID: " + account.getCustomerId());
				return true;
			} else {
				demologger.warning("Failed to create account for customer ID: " + account.getCustomerId());
				return false;
			}
		} catch (SQLException e) {
			demologger.severe("SQL Exception occurred: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}

	public boolean accountNumberExists(String accountNumber) throws SQLException, ClassNotFoundException {
        String query = "SELECT COUNT(*) FROM Accounts WHERE account_number = ?";
        try (Connection connection = new dbConnection().connectToDb();
             PreparedStatement statement = connection.prepareStatement(query)) {
            
            statement.setString(1, accountNumber);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                resultSet.next();
                return resultSet.getInt(1) > 0; // Returns true if account number exists
            }
            
        } catch (SQLException e) {
            // Log the exception and rethrow it if needed
            System.err.println("SQL Exception occurred while checking account number existence: " + e.getMessage());
            e.printStackTrace();
            // Optionally rethrow or handle the exception as needed
            throw e; // Rethrow the exception to propagate it
        }
    }
}