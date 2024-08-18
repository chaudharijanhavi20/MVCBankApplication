package servletControllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Account;
import Model.LoggingUtility;
import Queries.AccountDAO;

@WebServlet("/createAccount")
public class CreateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger demologger = LoggingUtility.getLogger();
	private AccountDAO accountDAO;

	@Override
	public void init() throws ServletException {
		try {
			demologger.info("Attempting to initialize AccountDAO.");
			accountDAO = new AccountDAO();
			demologger.info("AccountDAO initialized successfully.");
		} catch (Exception e) {
			demologger.severe("Failed to initialize AccountDAO: " + e.getMessage());
			e.printStackTrace();
			throw new ServletException("Initialization failed", e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int customerId = Integer.parseInt(request.getParameter("customerId"));
		double initialBalance = Double.parseDouble(request.getParameter("initialBalance"));

		if (initialBalance < 0) {
			request.setAttribute("message", "Initial balance cannot be negative.");
			request.setAttribute("messageType", "error");
			request.getRequestDispatcher("AccountNumberDisplay.jsp").forward(request, response);
			return;
		}

		Account account = new Account();
		account.setCustomerId(customerId);

		boolean success = false;
		while (!success) {
			try {
				// Generate unique account number
				String accountNumber = generateUniqueAccountNumber();
				account.setAccountNumber(accountNumber);
				account.setBalance(initialBalance);

				demologger.info("Creating account with data: " + account);

				success = accountDAO.createAccount(account);
				if (success) {
					request.setAttribute("message", "Initial Balance added successfully!!");
					request.setAttribute("messageType", "success");
				} else {
					request.setAttribute("message", "An error occurred while creating the account.");
					request.setAttribute("messageType", "error");
				}
				break;
			} catch (SQLException e) {
				if (e.getMessage().contains("Duplicate entry")) {

					demologger.info("Duplicate account number found. Generating a new one.");
				} else {
					demologger.severe("SQL Exception occurred: " + e.getMessage());
					e.printStackTrace();
					request.setAttribute("message", "An error occurred while creating the account.");
					request.setAttribute("messageType", "error");
					break; // Exit loop on non-duplicate error
				}
			} catch (ClassNotFoundException e) {
				demologger.severe("ClassNotFoundException occurred: " + e.getMessage());
				e.printStackTrace();
				request.setAttribute("message", "An error occurred while creating the account.");
				request.setAttribute("messageType", "error");
				break; 
			}
		}

		request.getRequestDispatcher("AccountNumberDisplay.jsp").forward(request, response);
	}

	private String generateUniqueAccountNumber() throws ClassNotFoundException, SQLException {
		Random random = new Random();
		String accountNumber;
		do {
			accountNumber = String.format("%010d", random.nextInt(1000000000));
		} while (accountDAO.accountNumberExists(accountNumber));
		return accountNumber;
	}
}
