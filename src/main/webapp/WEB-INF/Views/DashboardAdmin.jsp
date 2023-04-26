<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>
</head>
<body>
	<h1>This is Admin Dashboard!</h1>
	<% 
		response.setHeader("Cache-Control","no-cache");
	  	response.setHeader("Cache-Control","no-store");
	  	response.setHeader("Pragma","no-cache");
	  	response.setDateHeader ("Expires", 0);
		String email = (String) session.getAttribute("email");
		
		if(email==null)
		{
			response.sendRedirect("/BuyMe/login");
		}
	%>
	<h1>Welcome <%=email %> </h1>
	<button onclick="window.location.href='createNewUser'">Create New Staff Member Profile</button>
	<br><br>
	<button onclick="window.location.href='AdminReportBrands'">Brand Sales Report</button>
	<br><br>
	<button onclick="window.location.href='AdminReportModels'">Model Sales Report</button>
	<br><br>
	<button onclick="window.location.href='AdminReportUsers'">User Sales Report</button>
	<br><br>
	<button onclick="window.location.href='login'">Logout</button>
</body>
</html>