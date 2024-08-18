package servletControllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.LoggingUtility;
import Model.Transaction;
import Queries.dbConnection;

@WebServlet("/PassBookServlet")
public class PassBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger demologger = LoggingUtility.getLogger();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");

		if (email == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		List<Transaction> transactions = new ArrayList<>();
		String sql = "SELECT t.sender_account_number, t.receiver_account_number, t.transaction_type, t.amount, t.transaction_date "
				+ "FROM Transactions t " + "JOIN Accounts a ON t.account_id = a.account_id "
				+ "JOIN Customers c ON a.customer_id = c.customer_id " + "WHERE c.email_id = ?";

		try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement statement = connection.prepareStatement(sql)) {

			statement.setString(1, email);
			demologger.info("Executing query with email: " + email);

			try (ResultSet rs = statement.executeQuery()) {
				while (rs.next()) {
					Transaction transaction = new Transaction(rs.getString("sender_account_number"),
							rs.getString("receiver_account_number"), rs.getString("transaction_type"),
							rs.getBigDecimal("amount"), rs.getTimestamp("transaction_date"));
					transactions.add(transaction);
				}
			}
		} catch (SQLException | ClassNotFoundException e) {
			demologger.severe("Database error occurred: " + e.getMessage());
			e.printStackTrace();
			throw new ServletException("Database error occurred.", e);
		}

		request.setAttribute("transactions", transactions);

		request.getRequestDispatcher("passBook.jsp").forward(request, response);
	}
}
