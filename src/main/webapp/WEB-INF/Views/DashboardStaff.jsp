<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Staff Dashboard</title>
</head>
<body>
<h1>Welcome to Staff Dashboard!</h1>
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
	<button onclick="window.location.href='AnswerQuestions'">Answer User Questions</button>
	<br><br>
	<button onclick="window.location.href='ProductDeletionRequests'">Product Deletion Request</button>
	<br><br>
	<button onclick="window.location.href='login'">Logout</button>
</body>
</html>