
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="repository.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy Products</title>
</head>
<body>
	<h1>List of Available Products</h1>
	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Current Bid</th>
			<th>Enter the Bidding amount to participate</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String GET_PRODUCT_DATA = "SELECT * FROM product where status = \"active\";";
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				ResultSet rs = statement.executeQuery(GET_PRODUCT_DATA);
				while(rs.next()){
					//read the data and display the products in front end
					out.println("<tr>");
					out.println("<td>" + rs.getString("product_title") + "</td>");
					out.println("<td>" + rs.getString("product_desc") + "</td>");
					out.println("<td>" + rs.getString("product_type") + "</td>");
					out.println("<td>" + rs.getString("product_brand") + "</td>");
					out.println("<td>" + rs.getString("product_model") + "</td>");
					out.println("<td>" + rs.getString("product_color") + "</td>");
					//If its a first bid for a product, then pick the starting bid price
					//else pick the latest bid for that product as current_bid
					out.println("<td>" + rs.getString("starting_bid_price") + "</td>");
					out.println("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"post\">");
					out.println("<td><input type = \"number\" name = \"bid_amount\" placeholder = \"Bid Amount\" required /></td>");
					out.println("<td><input type = \"submit\" value = \"Place Bid\" placeholder = \"Place Bid\"/></td>");
					out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
					//If its a first bid for a product, then pick the starting bid price
					//else pick the latest bid for that product as current_bid
					out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+rs.getString("starting_bid_price")+"\"/>");
					out.println("</form>");
					out.println("</tr>");
				}
			}catch(Exception e){
				
			}
		%>
	</table>
</body>
</html>