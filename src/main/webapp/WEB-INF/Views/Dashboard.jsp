<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>MyDashboard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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

/* Header/Logo Title */
.header {
  padding: 20px;
  text-align: center;
  background: #6cc9c7;
}

.header2 {
  padding: 40px;
  text-align: center;
  background: #6cc9c7;
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
	<!-- <button onclick="window.location.href='UserNotifications'">My Notifications</button>
	<br><br>
	<button onclick="window.location.href='sell'">Auction your own product?</button>
	<br><br>
	<button onclick="window.location.href='BuyProduct'">Buy some products?</button>
	<br><br>
	<button onclick="window.location.href='UserInterest'">User interest</button>
	<br><br>
	<button onclick="window.location.href='UserBid'">Your Active Bids</button>
	<br><br>
	<button onclick="window.location.href='UserHistory'">User history</button>
	<br><br>
	<button onclick="window.location.href='AskQuestions'">Ask a Question to Staff</button>
	<br><br>
	<button onclick="window.location.href='MyQuestionAnswers'">My Questions and Answers</button>
	<br><br>
	<button onclick="window.location.href='login'">Logout</button> -->

	<ul class="topnav">
		<li><a class="active" href="">Home</a></li>
		<li><a href="UserNotifications">Notifications</a></li>
		<li><a href="sell">Sell Products</a></li>
		<li><a href="BuyProduct">Buy Products</a></li>
		<li><a href="UserInterest">Interested</a></li>
		<li><a href="UserBid">Your Active Bids</a></li>
		<li><a href="UserHistory">Your History</a></li>
		<li><a href="AskQuestions">Ask a Question to Staff</a></li>
		<li><a href="MyQuestionAnswers">My Questions and Answers</a></li>
		<li><a href="qna">QnA</a></li>
		<li class="right"><a href="login">Logout</a></li>
	  </ul>

	  <div class="header2"><h2>Welcome <%=email %></h2></div>
	
</body>
</html>