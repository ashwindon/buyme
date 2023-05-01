<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Staff Registration</title>
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
	  height:320px; 
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
	<div class="header"><h1>Buy Me</h1></div>
	<ul class="topnav">
		<li><a class="active" href="Dashboard">Home</a></li>
	</ul>
	<div class="login">
	<h1>Staff Registration</h1>
		
	<form action="<%= request.getContextPath() %>/createNewUser" method = "post" >
		<input type = "text" name = "name" placeholder = "Name"/><br><br>
		<input type = "text" name = "email" placeholder = "Email"/><br><br>
		<input type = "text" name = "phone_no" placeholder = "Phone Number"/><br><br>
		<input type = "password" name = "password" placeholder = "Password"/><br><br>
		<input class="button1" type = "submit" value = "Submit"/>
		<br><br>
	</form>
	</div>

</body>
</html>