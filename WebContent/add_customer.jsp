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
<title>Add New Customer</title>
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
						<%=session.getAttribute("username")%>!
					</h1>
				</div>
				<div
					class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-end">
					<div class="flex flex-shrink-0 items-center"></div>
					<div class="hidden sm:ml-6 sm:block">
						<div class="flex space-x-4">
							<a href="viewLastFiveCustomers"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Add
								Account</a> <a href="ViewCustomersServlet"
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

	<form action="addCustomerServlet" method="post">
		<div
			class="min-h-screen bg-gray-100 py-6 flex flex-col justify-center sm:py-12">
			<div class="relative py-3 sm:max-w-6xl sm:mx-auto w-full">
				<div
					class="relative px-12 py-16 bg-white shadow-lg sm:rounded-3xl sm:p-20">
					<div class="max-w-3xl mx-auto">
						<div>
							<h1 class="text-3xl font-semibold">Add New Customer</h1>
						</div>
						<div class="divide-y divide-gray-200">
							<div
								class="py-8 text-base leading-6 space-y-6 text-gray-700 sm:text-lg sm:leading-7">
								<div class="relative">
									<input autocomplete="off" id="firstname" name="firstname"
										type="text"
										class="peer placeholder-transparent h-12 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:border-rose-600"
										placeholder="FirstName" /> <label for="firstname"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">FirstName</label>
								</div>
								<div class="relative">
									<input autocomplete="off" id="lastname" name="lastname"
										type="text"
										class="peer placeholder-transparent h-12 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:border-rose-600"
										placeholder="LastName" /> <label for="lastname"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">LastName</label>
								</div>
								<div class="relative">
									<input autocomplete="off" id="email" name="email" type="text"
										class="peer placeholder-transparent h-12 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:border-rose-600"
										placeholder="Email Address" /> <label for="email"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">Email
										Address</label>
								</div>
								<div class="relative">
									<input autocomplete="off" id="password" name="password"
										type="password"
										class="peer placeholder-transparent h-12 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:border-rose-600"
										placeholder="Password" /> <label for="password"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">Password</label>
								</div>
								<div class="relative">
									<button class="bg-blue-700 text-white rounded-md px-8 py-4">Add
										Customer</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
