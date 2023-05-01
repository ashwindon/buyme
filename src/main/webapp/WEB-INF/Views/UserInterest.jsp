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
<title>My Interests</title>
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
	<h1 align="center">User Interests</h1>
	
	<table align="center" border="5px" cellspacing="10px" cellpadding="10px">
		<tr>
			<th>Brand</th>
			<th>Type</th>
			<th>Model</th>
            <th>Color</th>
            <th>Actions</th>
		</tr>
		<%
			try{
				String user_email = session.getAttribute("email").toString();
				String GET_USER_INTERESTS = "SELECT * FROM interest where email = \""+user_email+"\"";
				
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				
				ResultSet rs = statement.executeQuery(GET_USER_INTERESTS); 
                while(rs.next()){
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("product_brand") + "</td>");
                    out.println("<td>" + rs.getString("product_type") + "</td>");
                    out.println("<td>" + rs.getString("brand_model") + "</td>");
                    out.println("<td>" + rs.getString("product_color") + "</td>");
                    out.println("<td>");
                    String brand = rs.getString("product_brand");
                    String type = rs.getString("product_type");
                    String model = rs.getString("brand_model");
                    String color = rs.getString("product_color");

                    String CHECK_PRODUCT = "SELECT * FROM product where status = \"active\"";

                    if(!brand.isEmpty()) {
                        CHECK_PRODUCT += " AND product_brand LIKE \"%" + brand + "%\"";
                    }
    
                    if(!type.isEmpty()) {
                        CHECK_PRODUCT += " AND product_type LIKE \"%" + type + "%\"";
                    }

                    if(!model.isEmpty()) {
                        CHECK_PRODUCT += " AND product_type LIKE \"%" + model + "%\"";
                    }

                    if(!color.isEmpty()) {
                        CHECK_PRODUCT += " AND product_type LIKE \"%" + color + "%\"";
                    }

                    CHECK_PRODUCT += ";";

                    
				    Statement statement1 = con.createStatement();
                    ResultSet rs1 = statement1.executeQuery(CHECK_PRODUCT);
                    if(rs1.isBeforeFirst()) {
                        out.println("<form action=\""+request.getContextPath()+"/BuyProduct\" method=\"get\">");
                        out.println("<input class= \"button1\" type = \"submit\" name = \"show_products\" value = \"Show Products\"/>");
                        out.println("<input type = \"hidden\" name = \"brand_search\" value=\""+brand+"\"/>");
                        out.println("<input type = \"hidden\" name = \"type_search\" value=\""+type+"\"/>");
                        out.println("<input type = \"hidden\" name = \"model_search\" value=\""+model+"\"/>");
                        out.println("<input type = \"hidden\" name = \"color_search\" value=\""+color+"\"/></form>");
                        out.println("<form action=\""+request.getContextPath()+"/UserInterest\" method=\"post\">");
                        out.println("<input class= \"button1\" type = \"submit\" name = \"remove\" value = \"Remove\"/>");
                        out.println("<input type = \"hidden\" name = \"brand_search\" value=\""+brand+"\"/>");
                        out.println("<input type = \"hidden\" name = \"type_search\" value=\""+type+"\"/>");
                        out.println("<input type = \"hidden\" name = \"model_search\" value=\""+model+"\"/>");
                        out.println("<input type = \"hidden\" name = \"color_search\" value=\""+color+"\"/>");
                        out.println("<input type = \"hidden\" name = \"email\" value=\""+user_email+"\"/>");
                        out.println("</form>");
                    }
                    else {
                        out.println("Product not available");
                        out.println("<form action=\""+request.getContextPath()+"/UserInterest\" method=\"post\">");
                        out.println("<input class= \"button1\" type = \"submit\" name = \"remove\" value = \"Remove\"/>");
                        out.println("<input type = \"hidden\" name = \"brand_search\" value=\""+brand+"\"/>");
                        out.println("<input type = \"hidden\" name = \"type_search\" value=\""+type+"\"/>");
                        out.println("<input type = \"hidden\" name = \"model_search\" value=\""+model+"\"/>");
                        out.println("<input type = \"hidden\" name = \"color_search\" value=\""+color+"\"/>");
                        out.println("<input type = \"hidden\" name = \"email\" value=\""+user_email+"\"/>");
                        out.println("</form>");
                    }
                    out.println("</td></tr>");
                }
			}catch(Exception e){
				e.printStackTrace();
			}
		%>
	</table>
</body>
</html>