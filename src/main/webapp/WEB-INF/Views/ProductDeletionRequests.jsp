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
<title>Delete Product Requests</title>
</head>
<body>
<h1>User's Product Delete Requests!</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br><br>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>User Email</th>
			<th>Product ID</th>
			<th>Approve</th>
			<th>Deny</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_QUESTIONS = "SELECT * FROM product_requests;";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_USER_QUESTIONS); 
                while(rs.next()){
	                out.println("<tr>");
	                out.println("<td>" + rs.getString("email") + "</td>");
	                out.println("<td>" + rs.getString("pid") + "</td>");
	                out.println("<form action=\""+request.getContextPath()+"/ProductDeletionRequests\" method=\"post\">");
	                out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
	                out.println("<td><input style = \"color:\"green\";\" type = \"submit\" name = \"decision\" value = \"Approve\"/></td>");
	                out.println("<td><input style = \"color:\"red\";\" type = \"submit\" name = \"decision\" value = \"Deny\"/></td>");	                
	                out.println("</form>");
	                out.println("</tr>");
                }
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
	</table>
</body>
</html>