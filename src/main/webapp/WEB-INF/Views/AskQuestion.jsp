<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="repository.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask a Question</title>
</head>
<body>
	<h1>Ask a Question to BuyMe Staff member!</h1>
	
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br><br>
	<form action="<%= request.getContextPath() %>/AskQuestions" method = "post">
		<input style="height:200px; width:500px;padding:10px;" type = "text" name = "user_question" placeholder = "Ask us any question! (500 character limit)"/>
		<br><br>
		<input type = "submit" value = "Submit question!"/>
	</form>
	
</body>
</html>