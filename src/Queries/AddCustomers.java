package Queries;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import Model.Customer;
import Model.LoggingUtility;

public class AddCustomers {
	private static Logger demologger = LoggingUtility.getLogger();
	private Connection connection = null;

	public void addCustomer(Customer customer) throws ClassNotFoundException {
		dbConnection dbConn = null;
		try {
			dbConn = new dbConnection();
			connection = dbConn.connectToDb();
			connection.setAutoCommit(false);

			String usersql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
			PreparedStatement ps = connection.prepareStatement(usersql);
			ps.setString(1, customer.getEmail());
			ps.setString(2, customer.getPassword());
			ps.setString(3, "customer");
			demologger.info("Adding customer: " + customer);

			ps.executeUpdate();

			String cust = "INSERT INTO Customers (first_name, last_name, email_id, password) VALUES (?, ?, ?, ?)";
			ps = connection.prepareStatement(cust);
			ps.setString(1, customer.getFirstname());
			ps.setString(2, customer.getLastname());
			ps.setString(3, customer.getEmail());
			ps.setString(4, customer.getPassword());

			ps.executeUpdate();
			connection.commit();

		} catch (SQLException | ClassNotFoundException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (connection != null && !connection.isClosed()) {
					connection.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public Customer getCustomerById(int customerId) throws ClassNotFoundException {
		String sql = "SELECT * FROM Customers WHERE customer_id = ?";
		Customer customer = null;

		try {

			dbConnection dbConn = new dbConnection();
			Connection connection = dbConn.connectToDb();

			PreparedStatement ps = connection.prepareStatement(sql);
			ps.setInt(1, customerId);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				customer = new Customer(rs.getString("first_name"), rs.getString("last_name"), rs.getString("email_id"),
						rs.getString("password"));
			}

			connection.close();
		} catch (SQLException e) {
			e.printStackTrace(); 
		}

		return customer;
	}

	public List<Customer> getLastFiveCustomers() throws ClassNotFoundException {
		List<Customer> customers = new ArrayList<>();
		String query = "SELECT customer_id, first_name, last_name, email_id FROM Customers ORDER BY created_at DESC";

		try {
			dbConnection dbConn = new dbConnection();
			Connection connection = dbConn.connectToDb();
			PreparedStatement statement = connection.prepareStatement(query);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
				Customer customer = new Customer(rs.getString("first_name"), rs.getString("last_name"),
						rs.getString("email_id"), "" 
				);
				customer.setCustomerId(rs.getInt("customer_id"));
				customers.add(customer);
			}
			demologger.info("Retrieved customers: " + customers);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customers;
	}

	public Customer searchCustomerById(int customerId) throws ClassNotFoundException {
		Customer customer = null;
		String query = "SELECT customer_id, first_name, last_name, email_id FROM Customers WHERE customer_id = ?";

		try {
			dbConnection dbConn = new dbConnection(); 
			Connection connection = dbConn.connectToDb(); 

			PreparedStatement statement = connection.prepareStatement(query);
			statement.setInt(1, customerId);
			try (ResultSet rs = statement.executeQuery()) {
				if (rs.next()) {
					customer = new Customer(rs.getString("first_name"), rs.getString("last_name"),
							rs.getString("email_id"), "" 
					);
					customer.setCustomerId(rs.getInt("customer_id"));
				}
			}
			connection.close(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return customer;
	}

}