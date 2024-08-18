package servletControllers;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.LoggingUtility;
import Queries.dbConnection;

@WebServlet("/TransactionServlet")
public class TransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger demologger = LoggingUtility.getLogger();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("transactionForm.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");

		if (email == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		String transactionType = request.getParameter("transactionType");
		String toAccountNumber = request.getParameter("toAccountNumber");
		BigDecimal amount = new BigDecimal(request.getParameter("amount"));

		if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			request.setAttribute("message", "Amount must be greater than zero.");
			request.getRequestDispatcher("transactionForm.jsp").forward(request, response);
			return;
		}

		if (!"DEBIT".equalsIgnoreCase(transactionType) && !"CREDIT".equalsIgnoreCase(transactionType)
				&& !"TRANSFER".equalsIgnoreCase(transactionType)) {
			request.setAttribute("message", "Invalid transaction type.");
			request.getRequestDispatcher("transactionForm.jsp").forward(request, response);
			return;
		}

		String sql = null;

		if ("DEBIT".equalsIgnoreCase(transactionType)) {
			sql = "INSERT INTO Transactions (sender_account_number, receiver_account_number, transaction_type, amount, account_id) "
					+ "VALUES ((SELECT a.account_number FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE c.email_id = ? LIMIT 1), ?, 'DEBIT', ?, "
					+ "(SELECT a.account_id FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE c.email_id = ? LIMIT 1))";
		} else if ("CREDIT".equalsIgnoreCase(transactionType)) {
			sql = "INSERT INTO Transactions (sender_account_number, receiver_account_number, transaction_type, amount, account_id) "
					+ "VALUES ((SELECT a.account_number FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE c.email_id = ? LIMIT 1), ?, 'CREDIT', ?, "
					+ "(SELECT a.account_id FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE c.email_id = ? LIMIT 1))";
		} else if ("TRANSFER".equalsIgnoreCase(transactionType)) {
			sql = "INSERT INTO Transactions (sender_account_number, receiver_account_number, transaction_type, amount, account_id) "
					+ "VALUES ((SELECT a.account_number FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE c.email_id = ? LIMIT 1), ?, 'TRANSFER', ?, "
					+ "(SELECT a.account_id FROM Accounts a JOIN Customers c ON a.customer_id = c.customer_id WHERE a.account_number = ? LIMIT 1))";

			if (email.equalsIgnoreCase(toAccountNumber)) {
				request.setAttribute("message", "Sender and receiver account numbers cannot be the same.");
				request.getRequestDispatcher("transactionForm.jsp").forward(request, response);
				return;
			}
		}

		try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement statement = connection.prepareStatement(sql)) {

			if ("DEBIT".equalsIgnoreCase(transactionType) || "CREDIT".equalsIgnoreCase(transactionType)) {
				statement.setString(1, email);
				statement.setString(2, toAccountNumber);
				statement.setBigDecimal(3, amount);
				statement.setString(4, email);
			} else if ("TRANSFER".equalsIgnoreCase(transactionType)) {
				statement.setString(1, email);
				statement.setString(2, toAccountNumber);
				statement.setBigDecimal(3, amount);
				statement.setString(4, toAccountNumber);
			}

			int rowsInserted = statement.executeUpdate();
			if (rowsInserted > 0) {
				request.setAttribute("message", "Transaction successful!");
			} else {
				request.setAttribute("message", "Transaction failed. Please try again.");
			}
		} catch (SQLException | ClassNotFoundException e) {
			demologger.severe("Database error occurred: " + e.getMessage());
			e.printStackTrace();
			throw new ServletException("Database error occurred.", e);
		}

		request.getRequestDispatcher("transactionForm.jsp").forward(request, response);
	}
}
