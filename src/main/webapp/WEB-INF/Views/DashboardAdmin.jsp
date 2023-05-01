<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>
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

/* Header/Logo Title */
.header {
  padding: 20px;
  text-align: center;
  background: #6cc9c7;
}

.header2 {
  padding: 40px;
  text-align: center;
  background: #6cc9c7;
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
		<li><a class="active" href="">Home</a></li>
		<li><a href="createNewUser">Create Staff</a></li>
		<li><a href="AdminReportBrands">Brand Sales Report</a></li>
		<li><a href="AdminReportModels">Model Sales Report</a></li>
		<li><a href="AdminReportUsers">User Sales Report</a></li>
		<li class="right"><a href="login">Logout</a></li>
	  </ul>

	  <div class="header2"><h2>Welcome <%=email %></h2></div>
</body>
</html>