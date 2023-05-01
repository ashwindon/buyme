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
<title>History</title>
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
	<h1 align="center">User History</h1>

    <h2 align="center">Auction History</h2>
	<table align="center" border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Current User Bid</th>
			<th>Max Bid Limit</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_HISTORY = "SELECT * FROM product p, biddings b WHERE p.pid=b.pid AND b.email=\"";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();

                //if(request.getParameter("user_id") != null && !request.getParameter("user_id").isEmpty()) {
                    String user = user_email;
                    
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
                        
                   
                    
                //}
				
			}catch(Exception e){
				
			}
		%>
	</table>
    <br>
    <h2 align="center">Products History</h2>
	<table align="center" border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_HISTORY = "SELECT * FROM product WHERE email=\"";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();

                
                    	GET_USER_HISTORY += user_email + "\";";
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
                            out.println("<form action=\""+request.getContextPath()+"/RaiseProductDeleteRequest\" method=\"post\">");
                            String temp_status = rs.getString("status");
                            if(temp_status.equals("active")){
                            	out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
                            	out.println("<td><input class= \"button1\" type = \"submit\" name = \"raise_delete_request\" value = \"Request Product Deletion!\"/></td>");
                            }else{
                            	out.println("<td>" + temp_status.toUpperCase() + "</td>");
                            }
                            out.println("</tr>");
                        }
                    
                
				
			}catch(Exception e){
				
			}
		%>
        </table>
</body>
</html>