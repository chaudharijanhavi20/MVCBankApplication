<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	if (session == null || session.getAttribute("email") == null) {
		response.sendRedirect("Login.jsp");
		return;
	}
%>
<script src="https://cdn.tailwindcss.com"></script>
<!DOCTYPE html>
<html>
<head>
<style>
.alert {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 50;
	display: flex;
	justify-content: center;
	transition: transform 0.1s ease-in-out;
	transform: translateY(-100%);
}

.alert.show {
	transform: translateY(0);
}

.alert-success {
	background-color: #28a745; /* Green for success */
}

.alert-error {
	background-color: #dc3545; /* Red for error */
}
</style>
<title>View Customers and Create Account</title>
</head>
<body>
	<nav class="bg-blue-500">
		<div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
			<div class="relative flex h-16 items-center justify-between">
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
								href="ViewCustomersServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Customers</a> <a href="ViewTransactionsServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Transactions</a> <a href="Login.jsp"
								class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>
	<c:if test="${not empty message}">
		<div id="alert"
			class="alert ${messageType == 'success' ? 'alert-success' : 'alert-error'} text-white p-4 rounded-lg">
			<p class="font-semibold text-center">${message}</p>
		</div>
		<script>
			document.addEventListener("DOMContentLoaded", function() {
				var alertElement = document.getElementById('alert');
				if (alertElement) {
					alertElement.classList.add('show');
					// Hide the alert after 5 seconds
					setTimeout(function() {
						alertElement.classList.remove('show');
					}, 5000);
				}
			});
		</script>
	</c:if>

	<div class="min-h-screen bg-gray-100 flex items-center justify-center">
		<div class="w-full max-w-2xl">
			<div class="flex justify-center">
				<h1
					class="text-4xl font-semibold text-center text-blue-700 pb-8 pt-8">Customer
					Details</h1>
			</div>

			<div class="bg-white shadow-lg rounded-lg p-8 mx-auto mb-4">
				<form action="viewLastFiveCustomers" method="get">
					<label for="customerId" class="block text-gray-700">Search
						by Customer ID:</label> <input type="text" id="customerId"
						name="customerId"
						class="border border-gray-300 p-2 rounded w-full">
					<button type="submit"
						class="bg-blue-500 text-white px-3 py-1 rounded mt-4">Search</button>
				</form>
			</div>

			<c:if test="${not empty customers}">
				<div id="customer-details"
					class="bg-white shadow-lg rounded-lg p-8 mx-auto">
					<table
						class="w-full bg-white border-collapse border border-blue-300">
						<thead>
							<tr class="bg-blue-200">
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">ID</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">First
									Name</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Last
									Name</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Email</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Account
									Number</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="customer" items="${customers}">
								<tr>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.customerId}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.firstname}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.lastname}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.email}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">
										<form action="generateAccount" method="post">
											<input type="hidden" name="customerId"
												value="${customer.customerId}">
											<button type="submit"
												class="bg-blue-400 text-white px-3 py-1 rounded">Generate
												Account Number</button>
										</form>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>

			<c:if test="${empty customers}">
				<p class="text-center text-gray-700">No customers found.</p>
			</c:if>
		</div>
	</div>
</body>
</html>
