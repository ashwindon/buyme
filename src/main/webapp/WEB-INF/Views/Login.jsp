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
	session.setAttribute("email",null);
	session.invalidate();
	//out.println(response.toString());
	%>
	<h1>User Login</h1>
	<div>
		<form action="<%= request.getContextPath() %>/login" method = "post">
			<!-- <input type = "text" name = "email" placeholder = "Email"/>> -->
			<input type = "text" name = "email" placeholder = "Email"/>
			<input type = "password" name = "password" placeholder = "Password"/>
			<input type = "submit" value = "Submit" placeholder = "Login"/>
		</form>
	</div>
</body>
</html>