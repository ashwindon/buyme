package service;

import java.sql.*;
import repository.DatabaseConnection;

public class AuctionService {

    public void auctionProcess() {
        // check all active auctions
        String GET_ACTIVE_PRODUCTS = "SELECT * FROM product where status = \"available\";"; // replace available by active
        try {
		    DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();

            Statement statement = con.createStatement();
			System.out.println(statement);
			ResultSet resultSet = statement.executeQuery(GET_ACTIVE_PRODUCTS);

            // For all active auctions
            while(resultSet.next()){
                //get min add amount from the product table
                //get all bidders for the product in  sorted order of time
            }
        }
        catch(Exception e) {
			e.printStackTrace();
		}
    }

}