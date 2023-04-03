<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%
	session.setAttribute("email",null);
	session.setAttribute("role",null);
	session.invalidate();
	%>
	<div style = "display: flex; justify-content: center;">
	<div align='center' style="margin-top:10%; width:400px; height:220px;border:solid ; background-color:#ededed; border-radius:5px" >
		<h1>User Login</h1>
		<form action="<%= request.getContextPath() %>/login" method = "post">
			<!-- <input type = "text" name = "email" placeholder = "Email"/>> -->
			<input type = "text" name = "email" placeholder = "Email"/>
			<br><br>
			<input type = "password" name = "password" placeholder = "Password"/>
			<br><br>
			<input type = "submit" value = "Submit" placeholder = "Login"/>&nbsp
			<a href = "/BuyMe/createNewUser">New User?</a>
		</form>
	</div>
	</div>
</body>
</html>