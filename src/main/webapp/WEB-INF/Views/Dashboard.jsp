<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<% 
		String email = (String) session.getAttribute("email");
		if(email==null)
		{
			response.sendRedirect("Login.jsp");
		}
	%>
	<h1>Welcome <%=email %> </h1>
	<a href="login">Logout</a>
</body>
</html>