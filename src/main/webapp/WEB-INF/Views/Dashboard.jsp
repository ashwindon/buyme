<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyDashboard</title>
</head>
<body>
<h1>This is User Dashboard!</h1>
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
	<h1>Welcome <%=email %> </h1>
	<button onclick="window.location.href='sell'">Auction your own product?</button>
	<br><br>
	<button onclick="window.location.href='BuyProduct'">Buy some products?</button>
	<br><br>
	<button onclick="window.location.href='UserBid'">Your Bids</button>
	<br><br>
	<button onclick="window.location.href='UserHistory'">Other users history</button>
	<br><br>
	<button onclick="window.location.href='login'">Logout</button>
	
</body>
</html>