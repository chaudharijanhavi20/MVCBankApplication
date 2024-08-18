<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	// Retrieve the session from the request
	if (session == null || session.getAttribute("email") == null) {
		// If session is null or user attribute is missing, redirect to login page
		response.sendRedirect("Login.jsp");
		return; // Exit the JSP to avoid rendering the page content
	}
%>
<script src="https://cdn.tailwindcss.com"></script>
<!DOCTYPE html>
<html>
<head>
<title>View Transactions</title>
</head>
<body>

	<nav class="bg-blue-500">
		<div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
			<div class="relative flex h-16 items-center justify-between">
				<div class="absolute inset-y-0 left-0 flex items-center sm:hidden"></div>
				<div
					class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
					<h1 class="text-white font-medium">
						Welcome
						<%=session.getAttribute("email")%>!
					</h1>
				</div>
				<div
					class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-end">
					<div class="hidden sm:ml-6 sm:block">
						<div class="flex space-x-4">
							<a href="add_customer.jsp"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white"
								aria-current="page">Add Customer</a> <a
								href="viewLastFiveCustomers"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Add
								Account</a> <a href="ViewCustomersServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Customers</a> <a href="Login.jsp"
				class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<div
		class="min-h-screen bg-gray-100 flex flex-col items-center justify-center p-6">
		<div class="w-full max-w-4xl bg-white shadow-md rounded-lg p-6">
			<h2 class="text-3xl font-semibold text-blue-700 mb-6">View
				Transactions</h2>

			<!-- Filter Form -->
			<form action="ViewTransactionsServlet" method="get"
				class="mb-6 flex items-center">
				<label for="filter"
					class="block text-gray-700 text-sm font-semibold mr-4">Filter
					By:</label> <select id="filter" name="filter"
					class="shadow appearance-none border border-gray-300 rounded py-2 px-3 text-gray-700 mr-4 focus:outline-none focus:border-blue-500">
					<option value="ALL">All Transactions</option>
					<option value="CREDIT">Credit Transactions</option>
					<option value="DEBIT">Debit Transactions</option>
				</select> <input type="submit" value="Filter"
					class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
			</form>

			<!-- Transactions Table -->
			<table class="w-full bg-white border border-gray-300 border-collapse">
				<thead>
					<tr class="bg-gray-200">
						<th
							class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Sender
							Account Number</th>
						<th
							class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Receiver
							Account Number</th>
						<th
							class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Type</th>
						<th
							class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Amount</th>
						<th
							class="py-2 px-4 text-left font-semibold text-gray-700 border-b">Date</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="transaction" items="${transactions}">
						<tr>
							<td class="py-2 px-4 text-gray-800 border-r border-b">${transaction.senderAccountNumber}</td>
							<td class="py-2 px-4 text-gray-800 border-r border-b">${transaction.receiverAccountNumber}</td>
							<td class="py-2 px-4 text-gray-800 border-r border-b">${transaction.transactionType}</td>
							<td class="py-2 px-4 text-gray-800 border-r border-b">${transaction.amount}</td>
							<td class="py-2 px-4 text-gray-800 border-b">${transaction.transactionDate}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty transactions}">
						<tr>
							<td colspan="5"
								class="py-2 px-4 text-gray-800 text-center border-b">No
								transactions found.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>
