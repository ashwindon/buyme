package service;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.ProductModel;
import repository.DatabaseConnection;

public class ProductService {
	
	public int createNewProduct(ProductModel product) throws ClassNotFoundException
	{
		
		String CREATE_NEW_PRODUCT_QUERY = "INSERT INTO product"+"(email,product_title,product_desc,product_type,product_color,product_model,starting_bid_price,secret_min_price,min_bid_increment) VALUES"
		+ " (?,?,?,?,?,?,?,?,?);";
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_PRODUCT_QUERY);
			
			//PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_STAFF_QUERY);
			preparedStatement.setString(1, product.getEmail());
			preparedStatement.setString(2, product.getProduct_title());
			preparedStatement.setString(3, product.getProduct_desc());
			preparedStatement.setString(4, product.getProduct_type());
			preparedStatement.setString(5, product.getProduct_color());
			preparedStatement.setString(6, product.getProduct_model());
			preparedStatement.setDouble(7, product.getStarting_bid_price());
			preparedStatement.setDouble(8, product.getSecret_min_price());
			preparedStatement.setDouble(9, product.getMin_bid_increment());


			System.out.println(preparedStatement);
			
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
	}
	
}
