<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Registration</title>
</head>
<body>

	<div style = "display: flex; justify-content: center;">
	<div align='center' style="margin-top:10%; width:400px; height:320px;border:solid ; background-color" >
	
		<h1>BuyMe SignUp!!</h1>
		
		<form action="<%= request.getContextPath() %>/createNewUser" method = "post" >
			<input type = "text" name = "name" placeholder = "Name"/><br><br>
			<input type = "text" name = "email" placeholder = "Email"/><br><br>
			<input type = "text" name = "phone_no" placeholder = "Phone Number"/><br><br>
			<input type = "password" name = "password" placeholder = "Password"/><br><br>
			<input type = "submit" value = "Submit"/>
			<br><br>
			<a href = "/BuyMe/login">Already Registered User?</a>
		</form>
	
	</div>
	</div>

</body>
</html>