package service;

import java.sql.Connection;
import java.sql.PreparedStatement;

import model.BidModel;
import repository.DatabaseConnection;

public class BidService {
	public int createNewBid(BidModel bidmodel) throws ClassNotFoundException
	{
		
		String CREATE_NEW_BID_QUERY = "INSERT INTO biddings"+"(pid, email, current_bid, max_bid_amount, bid_time) VALUES" + " (?,?,?,?,?);";
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_BID_QUERY);
			//System.out.println("Product.getProductBrandddddddddd : "+product.getProduct_brand());
			//PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_STAFF_QUERY);
			preparedStatement.setInt(1, bidmodel.getPid());
			preparedStatement.setString(2, bidmodel.getEmail());
			preparedStatement.setDouble(3, bidmodel.getCurrent_bid());
			preparedStatement.setDouble(4, bidmodel.getMax_bid_limit());
			preparedStatement.setTimestamp(5, bidmodel.getBid_time());
			//convert java date to sql date
//			preparedStatement.setDate(11, new java.sql.Date(product.getEnd_date().getTime()));
//
//			preparedStatement.setString(12, product.getEnd_time());
//			preparedStatement.setString(13, product.getStatus());


			System.out.println(preparedStatement);
			
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
	}
}
