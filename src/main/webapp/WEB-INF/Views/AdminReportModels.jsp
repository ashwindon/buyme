
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
<title>Admin Report</title>
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
    <div class="header"><h2>Model Sales Report</h2></div>
		<%
			try{
                //String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price) AS total_earnings FROM buys;";
				String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price-p.starting_bid_price) AS total_earnings FROM buys b, product p WHERE p.pid=b.pid;";
                
                //String GET_TOTAL_BY_MODEL = "SELECT p.product_brand, p.product_model, SUM(b.final_price) AS total_price FROM product p, buys b WHERE p.pid=b.pid GROUP BY p.product_brand,p.product_model ORDER BY total_price DESC;";
				String GET_TOTAL_BY_MODEL = "SELECT p.product_brand, p.product_model, SUM(b.final_price-p.starting_bid_price) AS total_price FROM product p, buys b WHERE p.pid=b.pid GROUP BY p.product_brand,p.product_model ORDER BY total_price DESC;";

                String GET_BEST_MODEL = "SELECT p.product_brand, p.product_model, COUNT(*) AS no_of_sells FROM product p, buys b WHERE p.pid=b.pid GROUP BY p.product_brand,p.product_model;";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_TOTAL_EARNINGS);
				
                while(rs.next()){
                    out.println("<h3 style=\"text-align:center\">Total Earnings = $" + rs.getString("total_earnings") + "</h3>");
                }

                ResultSet rs2 = statement.executeQuery(GET_BEST_MODEL);

                while(rs2.next()){
                    out.println("<p style=\"text-align: center;\"><b>The best model is: " + rs2.getString("product_brand") + " - " + rs2.getString("product_model") + " (No. of items sold: " + rs2.getString("no_of_sells") + ")</b></p><br><br>");
                    break;   
                }

                ResultSet rs1 = statement.executeQuery(GET_TOTAL_BY_MODEL);
                
                out.println("<table align=\"center\" border=\"5px\" cellspacing=\"10px\" cellpadding=\"10px\">");
                out.println("<tr>");
                out.println("<th>Brand</th>");
                out.println("<th>Model</th>");
                out.println("<th>Total Sales</th></tr>");
                while(rs1.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs1.getString("product_brand") + "</td>");
                    out.println("<td>" + rs1.getString("product_model") + "</td>");
                    out.println("<td>" + rs1.getString("total_price") + "</td></tr>");    
                }
                out.println("</table>");
                out.println("<br><p style=\"text-align: center;\">*table is sorted in descending order of total sales</p>");

			}catch(Exception e){
				
			}
		%>
</body>
</html>