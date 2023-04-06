
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="repository.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy Products</title>
</head>
<body>
	<h1>List of Available Products</h1>
	<table border="0px" cellspacing="10px" cellpadding="10px">
		<tr>
		<%
			try{
				String GET_PRODUCT_DATA = "SELECT * FROM product where status = \"active\";";
				DatabaseConnection db = new DatabaseConnection();	
				Connection con = db.getConnection();
				Statement statement = con.createStatement();
				ResultSet resultSet = statement.executeQuery(GET_PRODUCT_DATA);
				while(resultSet.next()){
					//read the data and display the products in front end
				}
			}catch(Exception e){
				
			}
		%>
	</table>
</body>
</html>