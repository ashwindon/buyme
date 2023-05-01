<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
body {
	margin: 0;
	background: #6cc9c7;
}

ul.topnav {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

ul.topnav li {float: left;}

ul.topnav li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

ul.topnav li a:hover:not(.active) {background-color: #111;}

ul.topnav li a.active {background-color: #04AA6D;}

ul.topnav li.right {float: right;}

@media screen and (max-width: 600px) {
  ul.topnav li.right, 
  ul.topnav li {float: none;}
}

.header {
  padding: 10px;
  text-align: center;
  background: #6cc9c7;
}

.login {
  margin: auto;
  width: 60%;
  padding: 10px;
  margin-top:10%; 
  width:400px; 
  height:220px; 
  border: 3px solid ; 
  text-align: center; 
  border-radius:5px;
  background-color: #04AA6D;
}

.button1{
  background-color: #333;
  border: none;
  color: white;
  padding: 5px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  margin: 4px 2px;
  cursor: pointer;
  font-size: small;
  border-radius: 8px;
}
</style>
</head>
<body>
	<%
	session.setAttribute("email",null);
	session.setAttribute("role",null);
	session.invalidate();
	%>
	<div class="header"><h1>Buy Me</h1></div>
	<!--  <ul class="topnav">
		<li><a class="active" href="">Home</a></li>
	</ul>-->
	<div class="login">
		<h1>User Login</h1>
		<form action="<%= request.getContextPath() %>/login" method = "post">
			<!-- <input type = "text" name = "email" placeholder = "Email"/>> -->
			<input type = "text" name = "email" placeholder = "Email"/>
			<br><br>
			<input type = "password" name = "password" placeholder = "Password"/>
			<br><br>
			<input class="button1" type = "submit" value = "Submit" placeholder = "Login"/>&nbsp
			<a class="button1" href = "/BuyMe/createNewUser">New User?</a>
		</form>
	</div>
</body>
</html>