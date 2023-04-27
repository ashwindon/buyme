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
	<h1>Your Bids</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br><br>
	<table border="5px" cellspacing="10px" cellpadding="10px">
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
				out.println("<h1>" + user_email+ "</h1>");

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
                    out.println("<td><input type = \"submit\" value = \"Place Bid\" placeholder = \"Place Bid\"/></td>");
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