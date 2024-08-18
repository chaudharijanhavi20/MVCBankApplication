package Queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.math.BigDecimal;
import Model.Transaction;
import Queries.dbConnection;

public class TransactionDAO {

    public void addTransaction(Transaction transaction) throws SQLException, ClassNotFoundException {
        String query = "INSERT INTO Transactions (sender_account_number, receiver_account_number, transaction_type, amount, transaction_date) VALUES (?, ?, ?, ?, ?)";

        try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setString(1, transaction.getSenderAccountNumber());
            statement.setString(2, transaction.getReceiverAccountNumber());
            statement.setString(3, transaction.getTransactionType());
            statement.setBigDecimal(4, transaction.getAmount());
            statement.setTimestamp(5, transaction.getTransactionDate());

            statement.executeUpdate();
        }
    }

    // You can add more methods as needed (e.g., for querying transactions)
}
