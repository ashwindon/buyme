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
<title>Buy Products</title>
</head>
<body>
	<h1>User History</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br>
	<%
		out.println("<form action=\""+request.getContextPath()+"/UserHistory\" method=\"get\">");
		out.print("<br>Search by User ID: <input type=\"input\" name=\"user_id\" placeholder = \"user id\"/>&nbsp&nbsp" + 
					"<input type = \"submit\" name = \"search\" value = \"search\"/></form><br>");
	%>

    <% if(request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()) {
        String user = request.getParameter("user_id");
        out.print("<h2>User: " + user + "</h2>");
    } %>

    <h2>Auction History</h2>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Highest Bid</th>
			<th>User Bid</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_HISTORY = "SELECT * FROM product p, biddings b WHERE p.pid=b.pid AND b.email=\"";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();

                if(request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()) {
                    String user = request.getParameter("user_id");
                    if(!user.isEmpty()) {
                    	GET_USER_HISTORY += user + "\";";
                        boolean display = false;
                        ResultSet rs = statement.executeQuery(GET_USER_HISTORY);
                        while(rs.next()){
                            display = true;
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("product_title") + "</td>");
                            out.println("<td>" + rs.getString("product_desc") + "</td>");
                            out.println("<td>" + rs.getString("product_type") + "</td>");
                            out.println("<td>" + rs.getString("product_brand") + "</td>");
                            out.println("<td>" + rs.getString("product_model") + "</td>");
                            out.println("<td>" + rs.getString("product_color") + "</td>");
                            out.println("<td>" + rs.getString("current_bid") + "</td>");
                            out.println("<td>" + rs.getString("max_bid_amount") + "</td>");
                            out.println("</tr>");
                        }
                        if(!display) {
                            out.println("<h3>User ID not correct</h3>");
                        }
                    }
                    else {
                        out.println("<h3>User ID not correct</h3>");
                    }
                }
				
			}catch(Exception e){
				
			}
		%>
	</table>
    <br>
    <h2>Products History</h2>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_HISTORY = "SELECT * FROM product WHERE email=\"";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();

                if(request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()) {
                    String user = request.getParameter("user_id");
                    if(!user.isEmpty()) {
                    	GET_USER_HISTORY += user + "\";";
                        boolean display = false;
                        ResultSet rs = statement.executeQuery(GET_USER_HISTORY);
                        while(rs.next()){
                            display = true;
                            out.println("<tr>");
                            out.println("<td>" + rs.getString("product_title") + "</td>");
                            out.println("<td>" + rs.getString("product_desc") + "</td>");
                            out.println("<td>" + rs.getString("product_type") + "</td>");
                            out.println("<td>" + rs.getString("product_brand") + "</td>");
                            out.println("<td>" + rs.getString("product_model") + "</td>");
                            out.println("<td>" + rs.getString("product_color") + "</td>");
                            out.println("</tr>");
                        }
                    }
                }
				
			}catch(Exception e){
				
			}
		%>
        </table>
</body>
</html>