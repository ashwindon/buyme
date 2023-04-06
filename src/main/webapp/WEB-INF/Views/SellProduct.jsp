<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sell</title>
</head>
<body>
<% 
		response.setHeader("Cache-Control","no-cache");
	  	response.setHeader("Cache-Control","no-store");
	  	response.setHeader("Pragma","no-cache");
	  	response.setDateHeader ("Expires", 0);
		String email = (String) session.getAttribute("email");
		
		if(email==null)
		{
			response.sendRedirect("/BuyMe/login");
		}
	%>
<h1>Welcome <%=email %> to BuyMe!</h1>
<h4>Enter the product details to list it:</h4>

<form action="<%= request.getContextPath() %>/sell" method = "post" >	
			<input type = "text" name = "product_title" placeholder = "Product Title" required /><br><br>
			<input type = "text" name = "product_desc" placeholder = "Product Description" required /><br><br>
			<input type = "text" name = "product_type" placeholder = "Product Type" required /><br><br>
			<input type = "text" name = "product_brand" placeholder = "Product Brand" required /><br><br>
			<input type = "text" name = "product_color" placeholder = "Product Color" required /><br><br>
			<input type = "text" name = "product_model" placeholder = "Product Model" required /><br><br>
			<input type = "number" name = "starting_bid_price" placeholder = "Starting Bid Amount" required /><br><br>
			<input type = "number" name = "secret_min_price" placeholder = "Secret Min Selling Price" required /><br><br>
			<input type = "number" name = "min_bid_increment" placeholder = "Min Bid Increment" required /><br><br>
			<input type = "date" name = "end_date" placeholder = "Bid End Date" required /><br><br>
			<input type = "time" name = "end_time" placeholder = "Bid End Time" required /><br><br>
			<input type = "submit" value = "List My Product"/>
			<br><br>
		</form>

	<a href="login">Logout</a>

</body>
</html>