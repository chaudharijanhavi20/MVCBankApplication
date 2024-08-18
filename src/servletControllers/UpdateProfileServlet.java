package servletControllers;

import java.io.IOException;
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

import Model.Customer;
import Model.LoggingUtility;
import Queries.dbConnection;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger demologger = LoggingUtility.getLogger();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("editProfile.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("customer");

		if (customer == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String currentPassword = request.getParameter("password");
		String newPassword = request.getParameter("newPassword");

		if (!customer.getPassword().equals(currentPassword)) {
			request.setAttribute("errorMessage", "Current password is incorrect.");
			request.getRequestDispatcher("editProfile.jsp").forward(request, response);
			return;
		}

		String sqlCustomer = "UPDATE Customers SET first_name = ?, last_name = ?, password = ? WHERE customer_id = ?";
		String sqlUser = "UPDATE Users SET password = ? WHERE user_id = ?";

		try (Connection connection = new dbConnection().connectToDb()) {

			connection.setAutoCommit(false);

			try (PreparedStatement statement = connection.prepareStatement(sqlCustomer)) {
				statement.setString(1, firstName);
				statement.setString(2, lastName);
				statement.setString(3, newPassword);
				statement.setInt(4, customer.getCustomerId());
				int rowsUpdatedCustomer = statement.executeUpdate();

				try (PreparedStatement statementUser = connection.prepareStatement(sqlUser)) {
					statementUser.setString(1, newPassword);
					statementUser.setInt(2, customer.getCustomerId());
					int rowsUpdatedUser = statementUser.executeUpdate();

					if (rowsUpdatedCustomer > 0 && rowsUpdatedUser > 0) {
						connection.commit();

						customer.setFirstname(firstName);
						customer.setLastname(lastName);
						customer.setPassword(newPassword);
						session.setAttribute("customer", customer);

						request.setAttribute("message", "Profile updated successfully!");
					} else {
						connection.rollback();
						request.setAttribute("errorMessage", "Update failed. Please try again.");
					}
				} catch (SQLException e) {
					connection.rollback();
					throw e;
				}
			} catch (SQLException e) {
				connection.rollback();
				throw e;
			}
		} catch (SQLException | ClassNotFoundException e) {
			demologger.severe("Database error occurred: " + e.getMessage());
			e.printStackTrace();
			request.setAttribute("errorMessage", "Database error occurred. Please try again later.");
		}

		request.getRequestDispatcher("editProfile.jsp").forward(request, response);
	}
}
