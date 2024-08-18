<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// Retrieve the session from the request
	// false means don't create a new session if it doesn't exist

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
<title>View Customers</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
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
					<div class="flex flex-shrink-0 items-center"></div>
					<div class="hidden sm:ml-6 sm:block">
						<div class="flex space-x-4">

							<a href="add_customer.jsp"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white"
								aria-current="page">Add Customer</a> <a
								href="viewLastFiveCustomers"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Add
								Account</a>  <a href="ViewTransactionsServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Transactions</a>
								<a href="Login.jsp"
				class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<div class="min-h-screen bg-gray-100 flex items-center justify-center">
		<div class="w-full max-w-2xl">
			<div class="flex justify-center">
				<h1
					class="text-4xl font-semibold text-center text-blue-700 pb-8 pt-8">Customer
					Details</h1>
			</div>

			<!-- Form to filter customers -->
			<form action="ViewCustomersServlet" method="get" class="mb-8">
				<div class="flex items-center justify-between">
					<input type="text" name="customerName"
						placeholder="Enter customer name" class="border p-2 rounded-lg"
						value="${param.customerName}">
					<button type="submit"
						class="bg-blue-500 text-white px-4 py-2 rounded-lg ml-2">Filter</button>
				</div>
			</form>

			<!-- Display customer details -->
			<c:if test="${not empty customers}">
				<div id="customer-details"
					class="bg-white shadow-lg rounded-lg p-8 mx-auto">
					<table
						class="w-full bg-white border-collapse border border-blue-300">
						<thead>
							<tr class="bg-blue-200">
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
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Balance</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="customer" items="${customers}">
								<tr>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.firstname}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.lastname}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.email}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.accountNumber}</td>
									<td class="py-2 px-4 text-gray-800 border-r border-b">${customer.balance}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:if>

			<c:if test="${empty customers}">
				<div
					class="bg-yellow-100 border border-yellow-400 text-yellow-700 px-4 py-3 rounded relative">
					<strong class="font-bold">No Customers Found!</strong> <span
						class="block sm:inline">No customers match the filter
						criteria. Please try again with different criteria or remove the
						filter.</span>
				</div>
			</c:if>

			<c:if test="${not empty errorMessage}">
				<div
					class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
					<strong class="font-bold">Error!</strong> <span
						class="block sm:inline">${errorMessage}</span>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>
