<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Creation</title>
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
</style>
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
								Account</a> <a href="ViewCustomersServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Customers</a> <a href="view_transactions.jsp"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">View
								Transactions</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<!-- Notification Alert -->
	<c:if test="${not empty message}">
		<div id="alert"
			class="alert ${messageType == 'success' ? 'bg-green-500' : 'bg-red-500'} text-white p-4 rounded-lg">
			<p class="font-semibold text-center">${message}</p>
		</div>
	</c:if>

	<!-- Main Content Section -->
	<c:if test="${not empty generatedAccountNumber}">
		<div class="min-h-screen bg-gray-100 flex items-center justify-center">
			<div class="w-full max-w-2xl">
				<h2 class="text-2xl font-semibold text-center text-blue-700 pb-4">Account
					Number: ${generatedAccountNumber}</h2>
				<h2 class="text-xl text-center text-blue-700 pb-4">Set Initial
					Balance</h2>
				<form action="createAccount" method="post">
					<input type="hidden" name="customerId"
						value="${sessionScope.customerId}"> <input type="hidden"
						name="accountNumber"
						value="${sessionScope.generatedAccountNumber}">
					<div class="bg-white shadow-lg rounded-lg p-8 mx-auto">
						<label for="initialBalance" class="block text-gray-700">Initial
							Balance:</label> <input type="number" name="initialBalance"
							id="initialBalance" required
							class="border border-gray-300 p-2 rounded w-full">
						<button type="submit"
							class="bg-blue-500 text-white px-3 py-1 rounded mt-4">Add
							Initial Balance</button>
					</div>
				</form>
			</div>
		</div>
	</c:if>

	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var alert = document.getElementById('alert');
			if (alert) {
				alert.classList.add('show');
				setTimeout(function() {
					alert.classList.remove('show');
				}, 5000);
			}
		});
	</script>
</body>
</html>
