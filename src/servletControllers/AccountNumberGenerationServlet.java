package servletControllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Queries.dbConnection;

@WebServlet("/generateAccountNumber")
public class AccountNumberGenerationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String customerIdParam = request.getParameter("customerId");

		if (customerIdParam == null || customerIdParam.trim().isEmpty()) {
			request.setAttribute("errorMessage", "Customer ID is required.");
			request.getRequestDispatcher("AddAccountByCustomerId.jsp").forward(request, response);
			return;
		}

		int customerId;
		try {
			customerId = Integer.parseInt(customerIdParam);
		} catch (NumberFormatException e) {
			request.setAttribute("errorMessage", "Invalid Customer ID.");
			request.getRequestDispatcher("AddAccountByCustomerId.jsp").forward(request, response);
			return;
		}

		try (Connection connection = new dbConnection().connectToDb()) {
			if (connection == null) {
				throw new ServletException("Database connection failed!");
			}

			String checkAccountQuery = "SELECT account_number FROM Accounts WHERE customer_id = ?";
			try (PreparedStatement checkAccountStmt = connection.prepareStatement(checkAccountQuery)) {
				checkAccountStmt.setInt(1, customerId);
				try (ResultSet rs = checkAccountStmt.executeQuery()) {
					if (rs.next()) {
						request.setAttribute("errorMessage", "Customer already has an account.");
						request.getRequestDispatcher("AddAccountByCustomerId.jsp").forward(request, response);
						return;
					}
				}
			}

			String accountNumber = generateRandomAccountNumber();
			String insertAccountQuery = "INSERT INTO Accounts (account_number, customer_id, balance) VALUES (?, ?, ?)";
			try (PreparedStatement insertAccountStmt = connection.prepareStatement(insertAccountQuery)) {
				insertAccountStmt.setString(1, accountNumber);
				insertAccountStmt.setInt(2, customerId);
				insertAccountStmt.setDouble(3, 0);
				insertAccountStmt.executeUpdate();
			}

			response.sendRedirect("successPage.jsp?accountNumber=" + accountNumber);
		} catch (SQLException e) {
			e.printStackTrace();
			throw new ServletException("Database error occurred: " + e.getMessage(), e);
		} catch (ClassNotFoundException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}

	private String generateRandomAccountNumber() {

		return String.format("%010d", (int) (Math.random() * 1000000000));
	}
}
