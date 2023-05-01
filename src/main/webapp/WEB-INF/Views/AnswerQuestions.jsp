<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="repository.DatabaseConnection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer User Questions</title>
</head>
<body>
	<h1>Answer User Questions!</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br><br>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>User Question</th>
			<th>Staff Answer</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_QUESTIONS = "SELECT * FROM user_qa;";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_USER_QUESTIONS); 
                while(rs.next()){
	                out.println("<tr>");
	                out.println("<td>" + rs.getString("user_question") + "</td>");
	                out.println("<form action=\""+request.getContextPath()+"/AnswerQuestions\" method=\"post\">");
	                String status = rs.getString("status");
	                if(status.equals("not-answered")){
	                	out.println("<td><input type = \"text\" name = \"staff_answer\" placeholder = \"Answer question here! (500 character limit)\"/></td>");
	                	out.println("<input type = \"hidden\" name = \"qid\" value=\""+rs.getString("qid")+"\"/>");
	                	out.println("<td><input type = \"submit\" name = \"mark_as_answered\" value = \"Submit Answer!\"/></td>");
	                
	                }else{
	                	out.println("<td>" + rs.getString("staff_answer") + "</td>");
	                	out.println("<td> Answered! </td>");
	                }
	                
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