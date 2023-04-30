package service;

import java.sql.Connection;
import java.sql.*;
import java.sql.PreparedStatement;

import model.InterestModel;
import repository.DatabaseConnection;

public class InterestService {

    public int addInterestedProduct(InterestModel product) throws ClassNotFoundException
    {
        String CREATE_NEW_INTEREST_QUERY = "INSERT INTO interest"+"(email, product_brand, product_type, product_color, brand_model) VALUES" + " (?,?,?,?,?);";
        int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_INTEREST_QUERY);
			preparedStatement.setString(1, product.getEmail());
			preparedStatement.setString(2, product.getBrand());
			preparedStatement.setString(3, product.getType());
			preparedStatement.setString(4, product.getColor());
			preparedStatement.setString(5, product.getModel());
			System.out.println(preparedStatement);
			
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
    }

    public int removeInterestedProduct(InterestModel product) throws ClassNotFoundException
    {
        String DELETE_INTEREST = "DELETE FROM interest WHERE (email = '" + product.getEmail() + 
                                  "') AND (product_brand = '" + product.getBrand() +
                                  "') AND (product_type = '" + product.getType() +
                                  "') AND (product_color = '" + product.getColor() +
                                  "') AND (brand_model = '" + product.getModel() + "');";

        System.out.println(DELETE_INTEREST);
        int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(DELETE_INTEREST);
            success = preparedStatement.executeUpdate();
        }catch(Exception e){
			e.printStackTrace();
		}
		return success;
    }
}
