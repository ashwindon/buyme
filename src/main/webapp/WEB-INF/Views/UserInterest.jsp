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
</head>
<body>
	<h1>User Interests</h1>
	<button onclick="window.location.href='Dashboard'">Dashboard</button><br>

    <h2>Saved Search</h2>
	
	<table border="5px" cellspacing="10px" cellpadding="10px">
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
                        out.println("<input type = \"submit\" name = \"show_products\" value = \"Show Products\"/>");
                        out.println("<input type = \"hidden\" name = \"brand_search\" value=\""+brand+"\"/>");
                        out.println("<input type = \"hidden\" name = \"type_search\" value=\""+type+"\"/>");
                        out.println("<input type = \"hidden\" name = \"model_search\" value=\""+model+"\"/>");
                        out.println("<input type = \"hidden\" name = \"color_search\" value=\""+color+"\"/></form>");
                        out.println("<form action=\""+request.getContextPath()+"/UserInterest\" method=\"post\">");
                        out.println("<input type = \"submit\" name = \"remove\" value = \"Remove\"/>");
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
                        out.println("<input type = \"submit\" name = \"remove\" value = \"Remove\"/>");
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