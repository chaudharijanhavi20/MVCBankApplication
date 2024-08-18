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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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

						<!-- Current: "bg-gray-700 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
						<a href="PassBookServlet"
							class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white"
							aria-current="page">View Passbook</a> <a
							href="TransactionServlet"
							class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Make
							new Transaction </a> <a href="UpdateProfileServlet"
							class="rounded-md bg-blue-700 px-3 py-2 text-sm font-medium text-white hover:bg-gray-700 hover:text-white">Edit
							Profile</a>
							<a href="Login.jsp"
				class="rounded-md bg-red-500 px-3 py-2 text-sm font-medium text-white hover:bg-red-900 hover:text-white">Logout</a>
					</div>
				</div>
			</div>

		</div>
	</div>

	<!-- Mobile menu, show/hide based on menu state. -->
	<div class="sm:hidden" id="mobile-menu">
		<div class="space-y-1 px-2 pb-3 pt-2">
			<!-- Current: "bg-gray-900 text-white", Default: "text-gray-300 hover:bg-gray-700 hover:text-white" -->
			<a href="#"
				class="block rounded-md bg-gray-900 px-3 py-2 text-base font-medium text-white"
				aria-current="page">Dashboard</a> <a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Team</a>
			<a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Projects</a>
			<a href="#"
				class="block rounded-md px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white">Calendar</a>
		</div>
	</div>
	</nav>

	<div class="min-h-screen bg-gray-100 flex items-center justify-center">
		<div class="w-full max-w-6xl">
			<div class="flex justify-center">
				<h1
					class="text-4xl font-semibold text-center text-blue-700 pb-8 pt-8">Passbook
					Transactions</h1>
			</div>

			<c:if test="${not empty transactions}">
				<div id="transaction-details"
					class="bg-white shadow-lg rounded-lg p-8 mx-auto">
					<table
						class="w-full bg-white border-collapse border border-blue-300">
						<thead>
							<tr class="bg-blue-200">
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Sender
									Account Number</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Receiver
									Account Number</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Transaction
									Type</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Amount</th>
								<th
									class="py-2 px-4 text-left font-semibold text-gray-700 border-r border-b">Date</th>
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
						</tbody>
					</table>
				</div>
			</c:if>
			<c:if test="${empty transactions}">
				<p>No transactions found for this account.</p>
			</c:if>

		</div>
	</div>


</body>
</html>