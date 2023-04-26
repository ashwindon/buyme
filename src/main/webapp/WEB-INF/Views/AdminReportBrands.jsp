
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
	<h1>Admin Reports: Brand Sales Report </h1>
		<%
			try{
                //String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price) AS total_earnings FROM buys;";
				String GET_TOTAL_EARNINGS = "SELECT SUM(b.final_price-p.starting_bid_price) AS total_earnings FROM buys b, product p WHERE p.pid=b.pid;";
                //String GET_TOTAL_BY_BRAND = "SELECT p.product_brand, SUM(b.final_price) AS total_price FROM product p, buys b WHERE p.pid=b.pid GROUP BY p.product_brand ORDER BY total_price DESC;";
                String GET_TOTAL_BY_BRAND = "SELECT p.product_brand, SUM(b.final_price-p.starting_bid_price) AS total_price FROM product p, buys b WHERE p.pid=b.pid GROUP BY p.product_brand ORDER BY total_price DESC;";
				
                DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_TOTAL_EARNINGS);
				
                while(rs.next()){
                    out.println("<h2>Total Earnings = $" + rs.getString("total_earnings") + "</h2>");
                }

                ResultSet rs1 = statement.executeQuery(GET_TOTAL_BY_BRAND);
                
                out.println("<table border=\"5px\" cellspacing=\"10px\" cellpadding=\"10px\">");
                out.println("<tr>");
                out.println("<th>Brand</th>");
                out.println("<th>Total Sales</th></tr>");
                while(rs1.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs1.getString("product_brand") + "</td>");
                    out.println("<td>" + rs1.getString("total_price") + "</td></tr>");    
                }
                out.println("</table>");
                out.println("<br>*table is sorted in descending order of total sales");

			}catch(Exception e){
				
			}
		%>
</body>
</html>