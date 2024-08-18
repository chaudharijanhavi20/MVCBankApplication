<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	// Retrieve the session from the request
	if (session == null || session.getAttribute("email") == null) {
		response.sendRedirect("Login.jsp");
		return; // Exit the JSP to avoid rendering the page content
	}
%>
<script src="https://cdn.tailwindcss.com"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Make a Transaction</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.0.1/dist/tailwind.min.css">
</head>
<body class="bg-blue-100">
	<nav class="bg-blue-500">
		<div class="mx-auto max-w-7xl px-2 sm:px-6 lg:px-8">
			<div class="relative flex h-16 items-center justify-between">
				<div class="absolute inset-y-0 left-0 flex items-center sm:hidden">
				</div>
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
							<a href="PassBookServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white"
								aria-current="page">View Passbook</a>
							<a href="TransactionServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Make
								new Transaction</a>
							<a href="UpdateProfileServlet"
								class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Edit
								Profile</a>
							<a href="Login.jsp"
								class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="sm:hidden" id="mobile-menu">
			<div class="space-y-1 px-2 pb-3 pt-2">
				<a href="#"
					class="block rounded-md bg-gray-900 px-3 py-2 text-base font-medium text-white"
					aria-current="page">Dashboard</a>
				<a href="#"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Team</a>
				<a href="#"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Projects</a>
				<a href="#"
					class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Calendar</a>
				<a href="Login.jsp"
					class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
			</div>
		</div>
	</nav>

	<div class="container mx-auto mt-10">
		<div class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
			<h2 class="text-xl font-bold mb-4">Make a Transaction</h2>
			<form action="TransactionServlet" method="post">
				<div class="mb-4">
					<label class="block text-gray-700 text-sm font-bold mb-2"
						for="transactionType"> Transaction Type </label> <select
						name="transactionType" id="transactionType"
						class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
						onchange="toggleReceiverAccountField()">
						<option value="DEBIT">Debit</option>
						<option value="CREDIT">Credit</option>
						<option value="TRANSFER">Transfer</option>
					</select>
				</div>
				<div id="receiverAccountField" class="mb-4" style="display: none;">
					<label class="block text-gray-700 text-sm font-bold mb-2"
						for="toAccountNumber"> To Account Number </label> <input
						type="text" name="toAccountNumber" id="toAccountNumber"
						class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				</div>
				<div class="mb-4">
					<label class="block text-gray-700 text-sm font-bold mb-2"
						for="amount"> Amount </label> <input type="number" step="0.01"
						name="amount" id="amount"
						class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
				</div>
				<div class="flex items-center justify-between">
					<input type="submit" value="Submit"
						class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
				</div>
			</form>
		</div>
	</div>

  <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Use JSTL to escape and set the message safely
            var message = "<c:out value='${message}' />";
            if (message) {
                alert(message);
            }
        });

        function toggleReceiverAccountField() {
            var transactionType = document.getElementById('transactionType').value;
            var receiverAccountField = document.getElementById('receiverAccountField');
            if (transactionType === 'TRANSFER') {
                receiverAccountField.style.display = 'block';
            } else {
                receiverAccountField.style.display = 'none';
            }
        }
    </script>
</body>
</html>
