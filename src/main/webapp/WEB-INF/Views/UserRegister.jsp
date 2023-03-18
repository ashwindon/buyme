<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<div align = "center">
		<h1>User Sign Up Form</h1>
		
		<form action="<%= request.getContextPath() %>/createNewUser" method = "post" >
			<input type = "text" name = "name" placeholder = "Name"/>
			<input type = "text" name = "email" placeholder = "Email"/>
			<input type = "text" name = "phone_no" placeholder = "Phone Number"/>
			<input type = "password" name = "password" placeholder = "Password"/>
			<input type = "submit" value = "Submit"/>
		</form>
	
	</div>

</body>
</html>