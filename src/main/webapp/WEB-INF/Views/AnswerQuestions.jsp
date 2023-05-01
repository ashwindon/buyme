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
	<div class="header"><h1>Buy Me</h1></div>
    <ul class="topnav">
		<li><a class="active" href="Dashboard">Home</a></li>
	</ul>
	<h1 align="center">Answer User Questions!</h1>
	<table align="center" border="5px" cellspacing="10px" cellpadding="10px">
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
	                	out.println("<td><input class= \"button1\" type = \"submit\" name = \"mark_as_answered\" value = \"Submit Answer!\"/></td>");
	                
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