<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sell</title>
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
	<div class="header"><h1>Buy Me</h1></div>
    <ul class="topnav">
		<li><a class="active" href="Dashboard">Home</a></li>
	</ul>
<h4 align="center">Enter the product details to list it:</h4>

<form align="center" action="<%= request.getContextPath() %>/sell" method = "post" >	
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
			<input class="button1" type = "submit" value = "List My Product"/>
			<br><br>
		</form>

</body>
</html>