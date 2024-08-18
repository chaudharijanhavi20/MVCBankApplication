package servletControllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Customer;
import Queries.dbConnection;

@WebServlet("/ViewCustomersServlet")
public class ViewCustomersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Customer> customers = new ArrayList<>();
		String customerNameFilter = request.getParameter("customerName");

		String sql = "SELECT c.customer_id, c.first_name, c.last_name, c.email_id, a.account_number, a.balance "
				+ "FROM Customers c " + "LEFT JOIN Accounts a ON c.customer_id = a.customer_id";

		if (customerNameFilter != null && !customerNameFilter.trim().isEmpty()) {
			sql += " WHERE c.first_name LIKE ? OR c.last_name LIKE ?";
		}

		try (Connection connection = new dbConnection().connectToDb();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			if (customerNameFilter != null && !customerNameFilter.trim().isEmpty()) {
				String filter = "%" + customerNameFilter + "%";
				ps.setString(1, filter);
				ps.setString(2, filter);
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Customer customer = new Customer(rs.getString("first_name"), rs.getString("last_name"),
							rs.getString("email_id"), "");
					customer.setCustomerId(rs.getInt("customer_id"));
					customer.setAccountNumber(rs.getString("account_number"));
					customer.setBalance(rs.getDouble("balance"));

					customers.add(customer);
				}
			}

			request.setAttribute("customers", customers);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("errorMessage", "An error occurred while retrieving customer data.");
		}

		request.getRequestDispatcher("view_customers.jsp").forward(request, response);
	}
}
