package servletControllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.Customer;
import Model.LoggingUtility;
import Queries.AddCustomers;

@WebServlet("/viewLastFiveCustomers")
public class CustomerServlet extends HttpServlet {
	private static Logger demologger = LoggingUtility.getLogger();
	private static final long serialVersionUID = 1L;
	private AddCustomers customerDAO;

	public void init() {
		customerDAO = new AddCustomers();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Customer> customers = new ArrayList<>();
		try {
			
			customers = customerDAO.getLastFiveCustomers();

			
			demologger.info("Customers retrieved: " + customers);

			request.setAttribute("customers", customers);

			RequestDispatcher dispatcher = request.getRequestDispatcher("add_account.jsp");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
}

