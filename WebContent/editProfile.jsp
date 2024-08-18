<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<meta charset="UTF-8">
<title>Edit Profile</title>
<style>
.alert {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	z-index: 50;
	display: flex;
	justify-content: center;
	transition: opacity 0.5s ease-in-out;
	opacity: 0;
}

.alert.show {
	opacity: 1;
}
</style>
</head>
<body>
	<nav class="bg-blue-500">
		<div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
			<div class="relative flex h-16 items-center justify-between">
				<div
					class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
					<h1 class="text-white font-medium">
						Welcome,
						<%=session.getAttribute("email")%>!
					</h1>
				</div>
				<div
					class="flex flex-1 items-center justify-center sm:items-stretch sm:justify-end">
					<div class="hidden sm:ml-6 sm:block">
						<div class="flex space-x-4">
							<a href="PassBookServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white"
								aria-current="page">View Passbook</a> <a
								href="TransactionServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Make
								New Transaction</a> <a href="UpdateProfileServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Edit
								Profile</a> <a href="Login.jsp"
								class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</nav>

	<!-- Notification Alert -->
	<c:if test="${not empty message}">
		<div id="alert" class="alert bg-green-500 text-white p-4 rounded-lg">
			<p class="font-semibold text-center">${message}</p>
		</div>
	</c:if>
	<c:if test="${not empty errorMessage}">
		<div id="alert" class="alert bg-red-500 text-white p-4 rounded-lg">
			<p class="font-semibold text-center">${errorMessage}</p>
		</div>
	</c:if>

	<div class="bg-blue-100 flex justify-center items-center h-screen">
		<div class="container mx-auto">
			<div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
				<h2 class="text-xl font-bold mb-4">Edit Profile</h2>
				<form action="UpdateProfileServlet" method="post">
					<div class="mb-4">
						<label class="block text-gray-700 text-sm font-bold mb-2"
							for="firstName">First Name</label> <input type="text"
							id="firstName" name="firstName"
							value="${sessionScope.customer.firstName}"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
							required>
					</div>
					<div class="mb-4">
						<label class="block text-gray-700 text-sm font-bold mb-2"
							for="lastName">Last Name</label> <input type="text" id="lastName"
							name="lastName" value="${sessionScope.customer.lastName}"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
							required>
					</div>
					<div class="mb-4">
						<label class="block text-gray-700 text-sm font-bold mb-2"
							for="password">Current Password</label> <input type="password"
							id="password" name="password"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
							required>
					</div>
					<div class="mb-4">
						<label class="block text-gray-700 text-sm font-bold mb-2"
							for="newPassword">New Password</label> <input type="password"
							id="newPassword" name="newPassword"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
							required>
					</div>
					<div class="flex items-center justify-between">
						<button type="submit"
							class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
							Update</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<script>
		// Show the alert if there's a message
		document.addEventListener("DOMContentLoaded", function() {
			var alert = document.getElementById('alert');
			if (alert) {
				alert.classList.add('show');
				// Hide the alert after 5 seconds
				setTimeout(function() {
					alert.classList.remove('show');
				}, 5000);
			}
		});
	</script>
</body>
</html>
