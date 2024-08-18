package servletControllers;

import java.util.logging.Logger;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.Transaction;
import Queries.dbConnection;
import Model.LoggingUtility;

@WebServlet("/ViewTransactionsServlet")
public class ViewTransactionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger demologger = LoggingUtility.getLogger();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String filter = request.getParameter("filter");
		List<Transaction> transactions = new ArrayList<>();

		String query = "SELECT sender_account_number, receiver_account_number, transaction_type, amount, transaction_date FROM Transactions";

		if (filter != null && !filter.equals("ALL")) {
			query += " WHERE transaction_type = ?";
		}

		demologger.info("Filter: " + filter);
		demologger.info("Query: " + query);

		try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement statement = connection.prepareStatement(query)) {

			if (filter != null && !filter.equals("ALL")) {
				statement.setString(1, filter);
			}

			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Transaction transaction = new Transaction(rs.getString("sender_account_number"),
							rs.getString("receiver_account_number"), rs.getString("transaction_type"),
							rs.getBigDecimal("amount"), rs.getTimestamp("transaction_date"));
					transactions.add(transaction);
				}
			}

			demologger.info("Transactions fetched: " + transactions.size());
			request.setAttribute("transactions", transactions);

		} catch (SQLException | ClassNotFoundException e) {
			demologger.severe("Error occurred: " + e.getMessage());
			throw new ServletException("Database error occurred.", e);
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("view_transactions.jsp");
		dispatcher.forward(request, response);
	}
}
