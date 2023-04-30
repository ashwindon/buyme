package service;

import java.sql.*;
import java.util.HashMap;



import repository.DatabaseConnection;

public class UserNotificationManager {
	public void MarkAsRead(int pid) {
		String MARK_AS_READ_QUERY = "UPDATE alert SET status = \"read\" where pid = "+pid+";";
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(MARK_AS_READ_QUERY);
			success = preparedStatement.executeUpdate();
			db.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void SendNotifications(int pid, String user_email) {
		String GET_ALL_BIDS = "SELECT * FROM biddings where pid = "+pid+" AND email not in (\""+user_email+"\");";
		System.out.println("GIVE ALL BIDS : " + GET_ALL_BIDS);
		String GET_INCOMING_BID_MAX_BID_AMOUNT = "SELECT * FROM biddings where pid = "+pid+" AND email = \""+user_email+"\";";
		System.out.println("GET_INCOMING_BID_MAX_BID_AMOUNT : " + GET_INCOMING_BID_MAX_BID_AMOUNT);
		String GET_PRODUCT_NAME = "SELECT product_title from product where pid = "+pid+";";
		System.out.println("GET_PRODUCT_NAME : " + GET_PRODUCT_NAME);
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		String temp_product_title = "";
		String alert_message = "";
		int current_users_temp_max_bid_limit = 0;
		//fill the hashmap with existing notifications pid and users
		
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			
			Statement statement = con.createStatement();
			
			ResultSet rs = statement.executeQuery(GET_ALL_BIDS);
			
			while(rs.next()) {
				map.put(rs.getString("email"),rs.getInt("max_bid_amount"));				
			}
			
			ResultSet rs2 = statement.executeQuery(GET_INCOMING_BID_MAX_BID_AMOUNT);
			while(rs2.next()) {
				current_users_temp_max_bid_limit = rs2.getInt("max_bid_amount");
			}
			
			ResultSet rs3 = statement.executeQuery(GET_PRODUCT_NAME);
			while(rs3.next()) {
				temp_product_title = rs3.getString("product_title");
			}
			
			for(String temp_email:map.keySet()) {
				int temp_max_bid_limit_amount = map.get(temp_email);
				int success = 0;
				String INSERT_HIGHER_BID_ALERT = "INSERT INTO alert (pid,email,alert_message,status) VALUES";
				if(temp_max_bid_limit_amount < current_users_temp_max_bid_limit) {
					//insert into alerts table
					alert_message = "Some other user has placed a higher bid than you on the product : "+temp_product_title+"!";
					System.out.println("alert_message : "+alert_message);
					INSERT_HIGHER_BID_ALERT += "( "+pid+",\""+temp_email+"\",\""+alert_message+"\",\"not-read\");";
					System.out.println("INSERT_HIGHER_BID_ALERT : "+INSERT_HIGHER_BID_ALERT);
					PreparedStatement preparedStatement = con.prepareStatement(INSERT_HIGHER_BID_ALERT);
					success = preparedStatement.executeUpdate();
				}
			}
			
			db.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//some other user has placed a bid higher than you
//		try {
//			DatabaseConnection db = new DatabaseConnection();	
//			Connection con = db.getConnection();
//			
//			Statement statement = con.createStatement();
//			
//			ResultSet rs = statement.executeQuery(GET_ALL_BIDS);
//			
//			while(rs.next()) {
//				int temp_pid = 0;
//				temp_pid = rs.getInt("pid");
//				
//			}
//			
//			db.closeConnection(con);
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
		
		//your bid has reached the max bid limit
		
	}
}
