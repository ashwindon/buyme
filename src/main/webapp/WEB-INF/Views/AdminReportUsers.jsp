
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
	<h1>Admin Reports: User Sales Report </h1>
    <button onclick="window.location.href='Dashboard'">Dashboard</button><br>
		<%
			try{
				//String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price) AS total_earnings FROM buys;";
				String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price-p.starting_bid_price) AS total_earnings FROM buys b, product p WHERE p.pid=b.pid;";
                
                //String GET_TOTAL_BY_USER = "SELECT buyer_id, SUM(final_price) AS total_spent FROM buys GROUP BY buyer_id ORDER BY total_spent DESC;";
                String GET_TOTAL_BY_USER = "SELECT b.buyer_id, SUM(b.final_price-p.starting_bid_price) AS total_spent FROM buys b, product p WHERE p.pid=b.pid GROUP BY b.buyer_id ORDER BY total_spent DESC;";
				
                String GET_BEST_BUYER = "SELECT buyer_id, COUNT(*) AS no_of_buys FROM buys GROUP BY buyer_id;";

				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_TOTAL_EARNINGS);
				
                while(rs.next()){
                    out.println("<h2>Total Earnings = $" + rs.getString("total_earnings") + "</h2>");
                }

                ResultSet rs2 = statement.executeQuery(GET_BEST_BUYER);

                while(rs2.next()){
                    out.println("<b>The best buyer is: " + rs2.getString("buyer_id") + " (No. of items bought: " + rs2.getString("no_of_buys") + ")</b><br><br>");
                    break;   
                }

                ResultSet rs1 = statement.executeQuery(GET_TOTAL_BY_USER);
                
                out.println("<table border=\"5px\" cellspacing=\"10px\" cellpadding=\"10px\">");
                out.println("<tr>");
                out.println("<th>User</th>");
                out.println("<th>Total Sales</th></tr>");
                while(rs1.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs1.getString("buyer_id") + "</td>");
                    out.println("<td>" + rs1.getString("total_spent") + "</td></tr>");    
                }
                out.println("</table>");
                out.println("<br>*table is sorted in descending order of total sales");

			}catch(Exception e){
				
			}
		%>
</body>
</html>