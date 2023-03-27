<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyDashboard</title>
</head>
<body>
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
	<a href="login">Logout</a>
</body>
</html>