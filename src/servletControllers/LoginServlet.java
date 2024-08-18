package servletControllers;



import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.logging.Logger;

import Model.IUser;
import Model.LoggingUtility;
import Model.User;
import Queries.UserImplementation;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static Logger demologger=LoggingUtility.getLogger();
	private static final long serialVersionUID = 1L;
	private IUser userDAO;

	public LoginServlet() {
		super();
		userDAO = new UserImplementation();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		demologger.info("Received GET request at " + request.getRequestURI());
		String username = request.getParameter("email");
		String password = request.getParameter("password");
		String role = request.getParameter("role"); // Get the selected role

		User user;
		try {
			user = userDAO.validateUser(username, password);

			if (user != null && role.equals(user.getRole())) {
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("email", user.getEmail());

				
				if (user != null && role.equals(user.getRole())) {
					
					if ("admin".equals(role)) {
						response.sendRedirect("admin_home.jsp"); 
					} else if ("customer".equals(role)) {
						response.sendRedirect("customer_home.jsp"); 
					}
				}

			} else {
				request.setAttribute("errorMessage", "Invalid email, password, or role");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}
