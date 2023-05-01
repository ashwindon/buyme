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
<title>My Questions and Answers</title>
</head>
<body>
	<h1>My Questions and Answers</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br>
	
	<h2>My Q/A History</h2>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Your Question</th>
			<th>Staff Answer</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_QUESTIONS = "SELECT * FROM user_qa where email = \""+user_email+"\"";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_USER_QUESTIONS); 
                while(rs.next()){
	                out.println("<tr>");
	                out.println("<td>" + rs.getString("user_question") + "</td>");
	                out.println("<td>" + rs.getString("staff_answer") + "</td>");
	                out.println("</tr>");
                }
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
	</table>
    <br>
</body>
</html>