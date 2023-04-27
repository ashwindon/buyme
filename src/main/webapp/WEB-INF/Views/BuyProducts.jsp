
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
	<h1>List of Available Products</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br><br>
	<%
		out.println("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"get\">");
		out.println("Sort By: " + "<input type = \"submit\" name = \"price\" value = \"price\"/>&nbsp&nbsp<input type = \"submit\" name=\"brand\" value = \"brand\"/>");
		out.print("<br><br>Search Product: <input type=\"input\" name=\"brand_search\" placeholder = \"brand name\"/>&nbsp&nbsp<input type=\"input\" name=\"type_search\" placeholder = \"type\"/>" + 
					"&nbsp&nbsp<input type=\"input\" name=\"model_search\" placeholder = \"model\"/>&nbsp&nbsp<input type=\"input\" name=\"color_search\" placeholder = \"color\"/>" + 
					"&nbsp&nbsp <input type = \"submit\" name = \"search\" value = \"search\"/>");
		out.print("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"get\"> <input type = \"submit\" value=\"clear\"/> </form></form>");
	%>

	<table border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Title</th>
			<th>Description</th>
			<th>Type</th>
			<th>Brand</th>
			<th>Model</th>
			<th>Colour</th>
			<th>Current Highest Bid</th>
			<th>Min Amount You Must Bid</th>
			<th>Max Amount For Autobidding</th>
			<th>Action</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_PRODUCT_DATA = "SELECT * FROM product where status = \"active\"";
				//String GET_DISTINCT_PRODUCT_BID_DATA = "select pid, current_bid, bid_time from (select *, row_number() over(partition by pid order by bid_time desc) as rn from biddings where status = \"active\")a where a.rn=1;";
				
				String GET_DISTINCT_PRODUCT_BID_DATA = "select pid, current_bid, bid_time from( select bid.*, row_number() over(partition by bid.pid order by bid.bid_time desc) as rn from biddings bid join product prod on bid.pid = prod.pid where prod.status = \"active\")a where a.rn=1;";
				String GET_ALL_DISTINCT_USER_BIDS = "select distinct bid.pid, bid.email from biddings bid join product prod on bid.pid = prod.pid where prod.status = \"active\"";
				
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs2 = statement.executeQuery(GET_DISTINCT_PRODUCT_BID_DATA);
				HashMap<Integer,Double> map = new HashMap<Integer,Double>();
				while(rs2.next()){
					map.put(rs2.getInt("pid"), rs2.getDouble("current_bid"));
				}
				
				
				ResultSet rs3 = statement.executeQuery(GET_ALL_DISTINCT_USER_BIDS);
				//HashSet<Integer> set = new HashSet<Integer>();
				HashMap<String,HashSet<Integer>> email_bid_mapping = new HashMap<String,HashSet<Integer>>();
				while(rs3.next())
				{
					String email = rs3.getString("email");
					int pid = rs3.getInt("pid");
					if(email_bid_mapping.containsKey(email)){
						HashSet<Integer> curr_set = email_bid_mapping.get(email);
						curr_set.add(pid);
						email_bid_mapping.put(email, curr_set);
					}
					else
					{
						HashSet<Integer> curr_set = new HashSet<Integer>();
						curr_set.add(pid);
						email_bid_mapping.put(email,curr_set);
					}
				}
				
				if(request.getParameter("price") != null) {
					GET_PRODUCT_DATA = "SELECT * FROM product where status = \"active\" ORDER BY starting_bid_price, product_brand;";
				}

				if(request.getParameter("brand") != null) {
					GET_PRODUCT_DATA = "SELECT * FROM product where status = \"active\" ORDER BY product_brand, starting_bid_price;";
				}

				if(request.getParameter("brand_search") != null && !request.getParameter("brand_search").isEmpty()) {
					GET_PRODUCT_DATA += " AND product_brand LIKE \"%" + request.getParameter("brand_search") + "%\"";
				}

				if(request.getParameter("type_search") != null && !request.getParameter("type_search").isEmpty()) {
					GET_PRODUCT_DATA += " AND product_type LIKE \"%" + request.getParameter("type_search") + "%\"";
				}

				if(request.getParameter("model_search") != null && !request.getParameter("model_search").isEmpty()) {
					GET_PRODUCT_DATA += " AND product_model LIKE \"%" + request.getParameter("model_search") + "%\"";
				}

				if(request.getParameter("color_search") != null && !request.getParameter("color_search").isEmpty()) {
					GET_PRODUCT_DATA += " AND product_color LIKE \"%" + request.getParameter("color_search") + "%\"";
				}

				
				GET_PRODUCT_DATA += ";";

				ResultSet rs = statement.executeQuery(GET_PRODUCT_DATA);
				boolean display = false;
				while(rs.next()){
					//read the data and display the products in front end
					int current_pid = rs.getInt("pid");
					String curr_email = rs.getString("email");
					double min_bid_increment = rs.getDouble("min_bid_increment");
					double min_amount_you_must_bid = 0.0;
					double current_highest_bid = 0.0;
					if(map.containsKey(current_pid)){
						current_highest_bid = map.get(current_pid);
						min_amount_you_must_bid = current_highest_bid+min_bid_increment;
					}else{
						current_highest_bid = rs.getDouble("starting_bid_price");
						min_amount_you_must_bid = current_highest_bid;
					}
					
					if(!curr_email.equals(user_email))
					{					
						if(email_bid_mapping.containsKey(user_email))
						{
							if(!email_bid_mapping.get(user_email).contains(current_pid))
							{
								display = true;
								out.println("<tr>");
								out.println("<td>" + rs.getString("product_title") + "</td>");
								out.println("<td>" + rs.getString("product_desc") + "</td>");
								out.println("<td>" + rs.getString("product_type") + "</td>");
								out.println("<td>" + rs.getString("product_brand") + "</td>");
								out.println("<td>" + rs.getString("product_model") + "</td>");
								out.println("<td>" + rs.getString("product_color") + "</td>");
								//If its a first bid for a product, then pick the starting bid price
								//else pick the latest bid for that product as current_bid
								//out.println("<td>" + rs.getString("starting_bid_price") + "</td>");
								out.println("<td>" + current_highest_bid + "</td>");
								out.println("<td>" + min_amount_you_must_bid + "</td>");
								out.println("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"post\">");
								out.println("<td><input type = \"number\" name = \"bid_amount\" placeholder = \"Bid Amount\"/></td>");
								out.println("<td><input type = \"submit\" name = \"bid_action\" value = \"Auto Bid\"/>&nbsp<input type = \"submit\" name=\"bid_action\" value = \"Manual bid\"/></td>");
								//out.println("<td><input type = \"submit\" name=\"manual_bid\" value = \"Place Manual Bid\" placeholder = \"Place Manual Bid\"/></td>");
								out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
								//If its a first bid for a product, then pick the starting bid price
								//else pick the latest bid for that product as current_bid
								//out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+rs.getString("starting_bid_price")+"\"/>");
								out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+current_highest_bid+"\"/>");
								out.println("<input type = \"hidden\" name = \"min_amount_you_must_bid\" value=\""+min_amount_you_must_bid+"\"/>");
								out.println("</form>");
								out.println("</tr>");
							}
						}
						else
						{
							display = true;
							out.println("<tr>");
							out.println("<td>" + rs.getString("product_title") + "</td>");
							out.println("<td>" + rs.getString("product_desc") + "</td>");
							out.println("<td>" + rs.getString("product_type") + "</td>");
							out.println("<td>" + rs.getString("product_brand") + "</td>");
							out.println("<td>" + rs.getString("product_model") + "</td>");
							out.println("<td>" + rs.getString("product_color") + "</td>");
							//If its a first bid for a product, then pick the starting bid price
							//else pick the latest bid for that product as current_bid
							//out.println("<td>" + rs.getString("starting_bid_price") + "</td>");
							out.println("<td>" + current_highest_bid + "</td>");
							out.println("<td>" + min_amount_you_must_bid + "</td>");
							out.println("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"post\">");
							out.println("<td><input type = \"number\" name = \"bid_amount\" placeholder = \"Bid Amount\"/></td>");
							out.println("<td><input type = \"submit\" name = \"bid_action\" value = \"Auto Bid\"/>&nbsp<input type = \"submit\" name=\"bid_action\" value = \"Manual bid\"/></td>");
							//out.println("<td><input type = \"submit\" value = \"Place Bid\" placeholder = \"Place Bid\"/></td>");
							out.println("<input type = \"hidden\" name = \"pid\" value=\""+rs.getString("pid")+"\"/>");
							//If its a first bid for a product, then pick the starting bid price
							//else pick the latest bid for that product as current_bid
							//out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+rs.getString("starting_bid_price")+"\"/>");
							out.println("<input type = \"hidden\" name = \"current_bid\" value=\""+current_highest_bid+"\"/>");
							out.println("<input type = \"hidden\" name = \"min_amount_you_must_bid\" value=\""+min_amount_you_must_bid+"\"/>");
							out.println("</form>");
							out.println("</tr>");
						}
					}
				}
				
				if(!display)
				{
					out.println("<h3>No Listings avaiable! Try again Later</h3>");
				}
				else
				{
					out.println("<p>* In order to Enter Automatic Bidding, please enter the Max. upper limit you are comfortable with</p>");
					out.println("<p>** Clicking on Manual Bidding Would place a bid equal to amount in \"Min Amount You Must Bid Column\" in the above table</p>");
				}
				
			}catch(Exception e){
				
			}
			
			
		
		%>
	</table>
</body>
</html>