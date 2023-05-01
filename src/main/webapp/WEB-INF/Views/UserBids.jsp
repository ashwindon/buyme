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
<title>Bids</title>
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
	<h1 align="center">Your Bids</h1>
	<table align="center" border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Current Highest Bid</th>
			<th>Your max highest Bid</th>
			<th>Edit Max Bid amount</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();

				String GET_ALL_DISTINCT_USER_BIDS = "select distinct bid.pid, product_title, product_type, product_brand, product_color, product_model, current_bid, max_bid_amount from biddings bid join product prod on bid.pid = prod.pid where prod.status = \"active\" and bid.email=\"" + user_email + "\";";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_ALL_DISTINCT_USER_BIDS);
				boolean display = false;
				while(rs.next()){
					//read the data and display the products in front end
					
                    display = true;
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("product_title") + "</td>");
                    out.println("<td>" + rs.getString("product_type") + "</td>");
                    out.println("<td>" + rs.getString("product_brand") + "</td>");
                    out.println("<td>" + rs.getString("product_model") + "</td>");
                    out.println("<td>" + rs.getString("product_color") + "</td>");
                    //If its a first bid for a product, then pick the starting bid price
                    //else pick the latest bid for that product as current_bid
                    //out.println("<td>" + rs.getString("starting_bid_price") + "</td>");
                    out.println("<td>" + rs.getString("current_bid") + "</td>");
                    out.println("<td>" + rs.getString("max_bid_amount") + "</td>");
                    out.println("<form action=\""+request.getContextPath()+"/UserBid\" method=\"post\">");
                    out.println("<td><input type = \"number\" name = \"bid_amount\" placeholder = \"Bid Amount\" required /></td>");
                    out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
					out.println("<input type = \"hidden\" name = \"email\" value=\""+user_email+"\"/>");
                    out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+rs.getString("current_bid")+"\"/>");
                    out.println("<td><input class= \"button1\" type = \"submit\" value = \"Place Bid\" placeholder = \"Place Bid\"/></td>");
                    out.println("</form>");
                    out.println("</tr>");
				}
				if(!display)
				{
					out.println("<h3>No Listings avaiable! Try again Later</h3>");
				}
				
			}catch(Exception e){
				
			}
			
			
		
		%>
	</table>
</body>
</html>