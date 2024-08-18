package Queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import Model.BankAccount;


public class BankAccountDao {

	public void addBankAccount(BankAccount bankAccount) throws ClassNotFoundException {
		String sql = "INSERT INTO BankAccounts (account_number, customer_id, balance) VALUES (?, ?, ?)";

		try {
			dbConnection dbConn = new dbConnection();
			Connection connection = dbConn.connectToDb();

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setString(1, bankAccount.getAccountNumber());
			ps.setInt(2, bankAccount.getCustomerId());
			ps.setDouble(3, bankAccount.getBalance());

			ps.executeUpdate();

			connection.close();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
