<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	// Retrieve the session from the request
	if (session == null || session.getAttribute("email") == null) {
		// If session is null or user attribute is missing, redirect to login page
		response.sendRedirect("Login.jsp");
		return; // Exit the JSP to avoid rendering the page content
	}
%>
<script src="https://cdn.tailwindcss.com"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>customer home</title>
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
					<%=session.getAttribute("username")%>!
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

	<!-- source:https://gist.github.com/w3collective/7e7c89635fd932e5dae470b3516c1a99 -->

	<div class="container m-auto">
		<div
			class="flex flex-wrap items-center justify-center w-full text-center">

			<!-- basic plan -->
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div class="flex flex-col rounded border-2 border-blue-400 ">
					<div class="py-5 text-blue-700 bg-white">
						<h3>Home Loan</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 bg-blue-400 text-white rounded-b">
						<p>Feature o& Benefits</p>
						<p>EMI Calculator</p>
						<p>Eligibility and Documentation</p>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div class="flex flex-col rounded border-2 border-blue-400 ">
					<div class="py-5 text-blue-700 bg-white">
						<h3>Home Loan</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 bg-blue-400 text-white rounded-b">
						<p>Feature o& Benefits</p>
						<p>EMI Calculator</p>
						<p>Eligibility and Documentation</p>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>
			<!-- advanced plan -->
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div
					class="flex flex-col rounded border-2 border-blue-400 bg-blue-400">
					<div class="py-5 text-blue-700 bg-white">
						<h3>Gold Loan</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 bg-blue-400 text-white rounded-b">
						<p>Feature of the plan</p>
						<p>Another feature plan feature</p>
						<p>Charges and Rate</p>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div
					class="flex flex-col rounded border-2 border-blue-400 bg-blue-400">
					<div class="py-5 text-blue-700 bg-white">
						<h3>Gold Loan</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 bg-blue-400 text-white rounded-b">
						<p>Feature of the plan</p>
						<p>Another feature plan feature</p>
						<p>Charges and Rate</p>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div
					class="flex flex-col rounded border-2 border-blue-400 bg-blue-400">
					<div class="py-5 text-blue-700 bg-white">
						<h3>Gold Loan</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 bg-blue-400 text-white rounded-b">
						<p>Feature of the plan</p>
						<p>Another feature plan feature</p>
						<p>Charges and Rate</p>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>


			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div
					class="flex flex-col rounded border-2 border-blue-400 bg-blue-400">
					<div class="py-4 text-blue-700 bg-white">
						<h3>Senior citizen account</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 text-white rounded-b">
						<ul>
							<li>Feature And Benefits</li>
							<li>FAQs</li>
							<li>Advantages</li>
						</ul>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>
			<div class="w-full p-4 md:w-1/3 lg:w-1/4">
				<div
					class="flex flex-col rounded border-2 border-blue-400 bg-blue-400">
					<div class="py-4 text-blue-700 bg-white">
						<h3>Senior citizen account</h3>
						<p class="text-5xl font-bold">$</p>
						<p class="text-xs uppercase">Per Month</p>
					</div>
					<div class="py-5 text-white rounded-b">
						<ul>
							<li>Feature And Benefits</li>
							<li>FAQs</li>
							<li>Advantages</li>
						</ul>
						<button
							class="px-5 py-2 mt-5 uppercase rounded bg-white text-blue-700 font-semibold hover:bg-blue-900 hover:text-white">
							Apply Now</button>
					</div>
				</div>
			</div>

		</div>
	</div>

</body>
</html>