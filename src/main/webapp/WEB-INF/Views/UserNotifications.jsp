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
<title>My Notifications</title>
</head>
<body>
	<h1>User Notifications</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br>
	
	<h2>New Notifications</h2>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Alert Message</th>
			<th>Status</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_NOTIFICATIONS = "SELECT * FROM alert where email = \""+user_email+"\" and status = \"not-read\"";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_USER_NOTIFICATIONS); 
                while(rs.next()){
	                out.println("<tr>");
	                out.println("<td>" + rs.getString("alert_message") + "</td>");
	                out.println("<td>" + rs.getString("status") + "</td>");
	                out.println("<form action=\""+request.getContextPath()+"/UserNotifications\" method=\"post\">");
	                out.println("<td><input type = \"submit\" name = \"mark_as_read\" value = \"Mark As Read\"/></td>");
	                out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
	                out.println("</form>");
	                out.println("</tr>");
                }
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
	</table>
    <br>
    
    <h2>Past Notifications</h2>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Alert Message</th>
			<th>Status</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_NOTIFICATIONS = "SELECT * FROM alert where email = \""+user_email+"\" and status = \"read\"";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
                ResultSet rs = statement.executeQuery(GET_USER_NOTIFICATIONS);            
                while(rs.next()){
	                out.println("<tr>");
	                out.println("<td>" + rs.getString("alert_message") + "</td>");
	                out.println("<td>" + rs.getString("status") + "</td>");
	                out.println("</tr>");
                }      
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
	</table>
    <br>
	<script type="text/javascript">
		function hideMyRow(){
			console.log("LOL");
		} 
	</script>
</body>
</html>