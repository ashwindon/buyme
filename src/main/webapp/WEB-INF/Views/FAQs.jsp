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
<title>QnA</title>
</head>
<body>
	<h1>Welcome to BuyMe QnA</h1>
	<button onclick="window.location.href='Dashboard'">Back to Dashboard</button><br>
	<%
		DatabaseConnection db = new DatabaseConnection();	
		Connection con = db.getConnection();
		Statement statement = con.createStatement();
		out.println("<form action=\""+request.getContextPath()+"/qna\" method=\"get\">");
		out.print("<br><input type=\"input\" name=\"keyword\" placeholder = \"Enter the keyword\"/>&nbsp&nbsp" + 
					"<input type = \"submit\" name = \"search\" value = \"Search\"/></form><br>");
	%>
	
	<% 
		if(request.getParameter("keyword") == null || request.getParameter("keyword").isEmpty())
		{
			String SEARCH_KEYWORD_QUERY1 = "select * from questionAndAnswers limit 10";
			ResultSet rs = statement.executeQuery(SEARCH_KEYWORD_QUERY1);
			boolean display = false;
			while(rs.next()){
                display = true;
                out.println("<hr>");
                out.println("<p><i>Question:</i>&nbsp" + rs.getString("question") + "</p>");
                out.println("<p><i>Answer:</i>&nbsp&nbsp" + rs.getString("answer") + "</p>");
            }
            if(!display) {
                out.println("<h3>No Prior Question Exists</h3>");
                //Direct to Customer - Rep to raise a question
            }
		}
    %>
    
    
    <%
		try{
			String user_email = session.getAttribute("email").toString();
			String SEARCH_KEYWORD_QUERY = "select * from questionAndAnswers where question like '%";

			

               if(request.getParameter("keyword") != null && !request.getParameter("keyword").isEmpty()) {
                   String keyword = request.getParameter("keyword");
                   if(!keyword.isEmpty()) {
                	   SEARCH_KEYWORD_QUERY += keyword + "%';";
                       boolean display = false;
                       ResultSet rs = statement.executeQuery(SEARCH_KEYWORD_QUERY);
                       //System.out.println(SEARCH_KEYWORD_QUERY);
                       while(rs.next()){
                           display = true;
                           out.println("<hr>");
                           out.println("<p><i>Question:</i>&nbsp" + rs.getString("question") + "</p>");
                           out.println("<p><i>Answer:</i>&nbsp&nbsp" + rs.getString("answer") + "</p>");
                       }
                       if(!display) {
                           out.println("<h3>No Prior Question Exists</h3>");
                           //Direct to Customer - Rep to raise a question
                       }
                   }
                   else {
                       out.println("<h3>Keyword entered incorrectly</h3>");
                   }
               }
			
		}catch(Exception e){
			
		}
		%>
    
	
</body>
</html>