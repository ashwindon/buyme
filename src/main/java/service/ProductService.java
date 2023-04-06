package service;

import java.sql.Connection;
import java.sql.*;
import java.sql.PreparedStatement;

import model.ProductModel;
import repository.DatabaseConnection;

public class ProductService {
	
	public int createNewProduct(ProductModel product) throws ClassNotFoundException
	{
		
		String CREATE_NEW_PRODUCT_QUERY = "INSERT INTO product"+"(email,product_title,product_desc,product_type,product_brand,product_color,product_model,starting_bid_price,secret_min_price,min_bid_increment,end_date,end_time,status) VALUES"
		+ " (?,?,?,?,?,?,?,?,?,?,?,?,?);";
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_PRODUCT_QUERY);
			//System.out.println("Product.getProductBrandddddddddd : "+product.getProduct_brand());
			//PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_STAFF_QUERY);
			preparedStatement.setString(1, product.getEmail());
			preparedStatement.setString(2, product.getProduct_title());
			preparedStatement.setString(3, product.getProduct_desc());
			preparedStatement.setString(4, product.getProduct_type());
			preparedStatement.setString(5, product.getProduct_brand());
			preparedStatement.setString(6, product.getProduct_color());
			preparedStatement.setString(7, product.getProduct_model());
			preparedStatement.setDouble(8, product.getStarting_bid_price());
			preparedStatement.setDouble(9, product.getSecret_min_price());
			preparedStatement.setDouble(10, product.getMin_bid_increment());
			//convert java date to sql date
			preparedStatement.setDate(11, new java.sql.Date(product.getEnd_date().getTime()));

			preparedStatement.setString(12, product.getEnd_time());
			preparedStatement.setString(13, product.getStatus());


			System.out.println(preparedStatement);
			
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
	}
	
}
