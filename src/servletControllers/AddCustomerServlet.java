package servletControllers;

import java.io.IOException;
import java.util.logging.Logger;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.Customer;
import Model.LoggingUtility;
import Queries.AddCustomers;

//@WebServlet("/addCustomerServlet")
//public class AddCustomerServlet extends HttpServlet {
//	private static Logger demologger = LoggingUtility.getLogger();
//	private static final long serialVersionUID = 1L;
//
//	protected void doPost(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//
//		String firstName = request.getParameter("firstname");
//		String lastName = request.getParameter("lastname");
//		String email = request.getParameter("email");
//		String password = request.getParameter("password");
//
//		Customer customer = new Customer(firstName, lastName, email, password);
//		customer.setFirstname(firstName);
//		customer.setLastname(lastName);
//		customer.setEmail(email);
//		customer.setPassword(password);
//
//		demologger.info("Receiving customer data: " + customer);
//
//		AddCustomers addCustomers = new AddCustomers();
//		try {
//			addCustomers.addCustomer(customer);
//
//			request.setAttribute("message", "Customer added successfully!");
//			request.setAttribute("messageType", "success");
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//
//			request.setAttribute("message", "An error occurred while adding the customer.");
//			request.setAttribute("messageType", "error");
//		}
//
//		request.getRequestDispatcher("add_customer.jsp").forward(request, response);
//	}
//
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		doPost(request, response);
//	}
//}
@WebServlet("/addCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddCustomerServlet.class.getName());
    private static final long serialVersionUID = 1L;

    private static final Pattern ALPHABET_PATTERN = Pattern.compile("^[a-zA-Z]+$");

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstname");
        String lastName = request.getParameter("lastname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        StringBuilder validationErrors = new StringBuilder();

        // Validate first name
        if (firstName == null || firstName.trim().isEmpty()) {
            validationErrors.append("First name is required. ");
        } else if (!ALPHABET_PATTERN.matcher(firstName).matches()) {
            validationErrors.append("First name can only contain alphabets. ");
        }

        // Validate last name
        if (lastName == null || lastName.trim().isEmpty()) {
            validationErrors.append("Last name is required. ");
        } else if (!ALPHABET_PATTERN.matcher(lastName).matches()) {
            validationErrors.append("Last name can only contain alphabets. ");
        }

        // Validate email
        if (email == null || email.trim().isEmpty()) {
            validationErrors.append("Email is required. ");
        }

        // Validate password
        if (password == null || password.trim().isEmpty()) {
            validationErrors.append("Password is required. ");
        }

        if (validationErrors.length() > 0) {
            request.setAttribute("message", validationErrors.toString());
            request.setAttribute("messageType", "error");
            request.getRequestDispatcher("add_customer.jsp").forward(request, response);
            return;
        }

        Customer customer = new Customer(firstName, lastName, email, password);

        AddCustomers addCustomers = new AddCustomers();
        try {
            addCustomers.addCustomer(customer);
            request.setAttribute("message", "Customer added successfully!");
            request.setAttribute("messageType", "success");
        } catch (ClassNotFoundException e) {
            LOGGER.severe("Error adding customer: " + e.getMessage());
            request.setAttribute("message", "An error occurred while adding the customer.");
            request.setAttribute("messageType", "error");
        }

        request.getRequestDispatcher("add_customer.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
