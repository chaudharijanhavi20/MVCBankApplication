<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<script src="https://cdn.tailwindcss.com"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="https://cdn.tailwindcss.com"></script>
<title>Login</title>
</head>
<body>
	<form action="LoginServlet" method="post">
		<div
			class="min-h-screen bg-gray-100 py-6 flex flex-col justify-center sm:py-12">
			<div class="relative py-3 sm:max-w-xl sm:mx-auto">
				<div
					class="absolute inset-0 bg-gradient-to-r from-blue-400 to-sky-500 shadow-lg transform -skew-y-6 sm:skew-y-0 sm:-rotate-6 sm:rounded-3xl">
				</div>
				<div
					class="relative px-4 py-10 bg-white shadow-lg sm:rounded-3xl sm:p-20">

					<div class="max-w-md mx-auto">
						<div>
							<h1 class="text-2xl font-semibold">Login</h1>
						</div>
						<div class="divide-y divide-gray-200">
							<div
								class="py-8 text-base leading-6 space-y-4 text-gray-700 sm:text-lg sm:leading-7">
								<div class="relative">
									<input autocomplete="off" id="email" name="email" type="text"
										class="peer placeholder-transparent h-10 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:borer-rose-600"
										placeholder="Email address" /> <label for="email"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">Username
									</label>
								</div>

								<div class="relative">
									<input autocomplete="off" id="password" name="password"
										type="password"
										class="peer placeholder-transparent h-10 w-full border-b-2 border-gray-300 text-gray-900 focus:outline-none focus:borer-rose-600"
										placeholder="Password" /> <label for="password"
										class="absolute left-0 -top-3.5 text-gray-600 text-sm peer-placeholder-shown:text-base peer-placeholder-shown:text-gray-440 peer-placeholder-shown:top-2 transition-all peer-focus:-top-3.5 peer-focus:text-gray-600 peer-focus:text-sm">Password</label>
								</div>
								<div class="flex space-x-4">
									<div>
										<input type="radio" id="admin" name="role" value="admin"
											required> <label for="admin"
											class="text-sm text-gray-700 dark:text-gray-300">Admin</label>
									</div>
									<div>
										<input type="radio" id="customer" name="role" value="customer"
											required> <label for="customer"
											class="text-sm text-gray-700 dark:text-gray-300">Customer</label>
									</div>
								</div>
								<div class="relative">
									<button class="bg-blue-500 text-white rounded-md px-2 py-1">Login
										as Admin/Customer</button>

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