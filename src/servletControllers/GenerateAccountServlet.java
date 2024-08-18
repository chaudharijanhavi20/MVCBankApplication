package servletControllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Queries.dbConnection;

@WebServlet("/generateAccount")
public class GenerateAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerId;
        try {
            customerId = Integer.parseInt(request.getParameter("customerId"));
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Customer ID format.");
            request.getRequestDispatcher("AddAccountByCustomerId.jsp").forward(request, response);
            return;
        }

        String accountNumber;
        try (Connection connection = new dbConnection().connectToDb()) {
            if (connection == null) {
                throw new ServletException("Database connection failed!");
            }

            accountNumber = generateUniqueAccountNumber(connection);

            String insertQuery = "INSERT INTO Accounts (account_number, customer_id) VALUES (?, ?)";
            try (PreparedStatement insertStatement = connection.prepareStatement(insertQuery)) {
                insertStatement.setString(1, accountNumber);
                insertStatement.setInt(2, customerId);
                insertStatement.executeUpdate();
            }

            request.getSession().setAttribute("generatedAccountNumber", accountNumber);
            request.getSession().setAttribute("customerId", customerId);

            response.sendRedirect("AccountNumberDisplay.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database error occurred.", e);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ServletException("Database driver not found.", e);
        }
    }

    private String generateUniqueAccountNumber(Connection connection) throws SQLException {
        Random random = new Random();
        String accountNumber;
        String checkQuery = "SELECT COUNT(*) FROM Accounts WHERE account_number = ?";

        while (true) {
            accountNumber = String.format("%010d", random.nextInt(1000000000));
            try (PreparedStatement checkStatement = connection.prepareStatement(checkQuery)) {
                checkStatement.setString(1, accountNumber);
                try (ResultSet resultSet = checkStatement.executeQuery()) {
                    resultSet.next();
                    if (resultSet.getInt(1) == 0) {
                        return accountNumber;
                    }
                }
            }
        }
    }
}


// public class GenerateAccountServlet extends HttpServlet {
// private static final long serialVersionUID = 1L;
//
// @Override
// protected void doPost(HttpServletRequest request, HttpServletResponse
// response)
// throws ServletException, IOException {
// int customerId;
// try {
// customerId = Integer.parseInt(request.getParameter("customerId"));
// } catch (NumberFormatException e) {
// request.setAttribute("errorMessage", "Invalid Customer ID format.");
// request.getRequestDispatcher("AddAccountByCustomerId.jsp").forward(request,
// response);
// return;
// }
//
// String accountNumber;
// try (Connection connection = new dbConnection().connectToDb()) {
// if (connection == null) {
// throw new ServletException("Database connection failed!");
// }
//
// String checkQuery = "SELECT account_number FROM Accounts WHERE customer_id =
// ?";
// try (PreparedStatement checkStatement =
// connection.prepareStatement(checkQuery)) {
// checkStatement.setInt(1, customerId);
// try (ResultSet resultSet = checkStatement.executeQuery()) {
// if (resultSet.next()) {
//
// accountNumber = resultSet.getString("account_number");
// } else {
//
// accountNumber = generateRandomAccountNumber();
//
// String insertQuery = "INSERT INTO Accounts (account_number, customer_id)
// VALUES (?, ?)";
// try (PreparedStatement insertStatement =
// connection.prepareStatement(insertQuery)) {
// insertStatement.setString(1, accountNumber);
// insertStatement.setInt(2, customerId);
// insertStatement.executeUpdate();
// }
// }
// }
// }
//
// request.getSession().setAttribute("generatedAccountNumber", accountNumber);
// request.getSession().setAttribute("customerId", customerId);
//
// response.sendRedirect("AccountNumberDisplay.jsp");
//
// } catch (SQLException e) {
// e.printStackTrace();
// throw new ServletException("Database error occurred.", e);
// } catch (ClassNotFoundException e) {
// e.printStackTrace();
// throw new ServletException("Database driver not found.", e);
// }
// }
//
// private String generateRandomAccountNumber(Connection connection) throws
// SQLException {
// Random random = new Random();
// String accountNumber;
// String checkQuery = "SELECT COUNT(*) FROM Accounts WHERE account_number = ?";
//
// do {
// accountNumber = String.format("%010d", random.nextInt(1000000000));
// try (PreparedStatement checkStatement =
// connection.prepareStatement(checkQuery)) {
// checkStatement.setString(1, accountNumber);
// try (ResultSet resultSet = checkStatement.executeQuery()) {
// resultSet.next();
// if (resultSet.getInt(1) == 0) {
// break;
// }
// }
// }
// } while (true);
//
// return accountNumber;
// }
//
// }
