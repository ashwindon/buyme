package service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.*;

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

	public int updateMaxBid(BidModel bidmodel) throws ClassNotFoundException
	{
		String UPDATE_BID_QUERY = "UPDATE biddings SET max_bid_amount = '" + bidmodel.getMax_bid_limit() + "', bid_time = '" + bidmodel.getBid_time() + "' WHERE (pid = '" + bidmodel.getPid() + "') and (email = '" + bidmodel.getEmail() + "')";
;
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(UPDATE_BID_QUERY);
			System.out.println(preparedStatement);
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
	}

	public int updateBids() throws ClassNotFoundException
	{
		//execute query to get updated bids
		String query = "select distinct inter2.email, inter2.pid,\n" +
				"case when inter2.second_max_bid_amount='' and inter2.second_max_bid_amount_rn=1 then inter2.current_bid\n" +
				"when inter2.second_max_bid_amount='' and inter2.second_max_bid_amount_rn<>1 then inter2.user_max_bid\n" +
				"	when inter2.user_max_bid < inter2.prod_max_bid_amount then inter2.user_max_bid\n" +
				"	else\n" + 
				"		case when  inter2.second_max_bid_amount + inter2.min_incr < inter2.user_max_bid then inter2.second_max_bid_amount + inter2.min_incr\n" +
				"		else inter2.user_max_bid end\n" +
				"end as current_bid,\n" +
				"inter2.user_max_bid\n" +
				"from \n" +
				"(\n" +
				"	select inter.email,inter.pid,inter.current_bid, inter.max_bid_amount as user_max_bid,\n" +
				"	inter.prod_max_bid_amount, inter.second_max_bid_amount, inter.min_incr, inter.second_max_bid_amount_rn\n" +
				"	from \n" +
				"	(\n" +
				"		select A.*, coalesce(B.max_bid_amount,'') as prod_max_bid_amount, \n" +
				"		coalesce(C.max_bid_amount,'') as second_max_bid_amount, coalesce(C.rn, 1) as second_max_bid_amount_rn  \n" +
				"		from\n" +
				"		(\n" +
				"			select bid.*,prod.min_bid_increment as min_incr from biddings bid \n" +
				"			join product prod on bid.pid = prod.pid\n" +
				"			and upper(trim(prod.status)) = \"active\" \n" +
				"		)A\n" +
				"		join \n" +
				"		(\n" +
				"			select A.* from \n" +
				"			(\n" +
				"				select *,row_number() over(partition by pid order by max_bid_amount desc) as rn\n" +
				"				from biddings \n" +
				"			)A where A.rn = 1\n" +
				"		)B on B.pid = A.pid\n" +
				"		left join\n" +
				"		(\n" +
				"			select A.* from \n" +
				"			(\n" +
				"				select *,row_number() over(partition by pid order by max_bid_amount desc) as rn\n" +
				"				from biddings \n" +
				"			)A where A.rn = 2\n" +
				"		)C on A.pid = C.pid\n" +
				"	)inter\n" +
				")inter2\n;";
//		String query = "select distinct inter2.email, inter2.pid,\n" +
//						"case when inter2.second_max_bid_amount='' then inter2.current_bid\n" +
//						"	when inter2.user_max_bid < inter2.prod_max_bid_amount then inter2.user_max_bid\n" +
//						"	else\n" + 
//						"		case when  inter2.second_max_bid_amount + inter2.min_incr < inter2.user_max_bid then inter2.second_max_bid_amount + inter2.min_incr\n" +
//						"		else inter2.user_max_bid end\n" +
//						"end as current_bid,\n" +
//						"inter2.user_max_bid\n" +
//						"from \n" +
//						"(\n" +
//						"	select inter.email,inter.pid,inter.current_bid, inter.max_bid_amount as user_max_bid,\n" +
//						"	inter.prod_max_bid_amount, inter.second_max_bid_amount, inter.min_incr\n" +
//						"	from \n" +
//						"	(\n" +
//						"		select A.*, coalesce(B.max_bid_amount,'') as prod_max_bid_amount, \n" +
//						"		coalesce(C.max_bid_amount,'') as second_max_bid_amount  \n" +
//						"		from\n" +
//						"		(\n" +
//						"			select bid.*,prod.min_bid_increment as min_incr from biddings bid \n" +
//						"			join product prod on bid.pid = prod.pid\n" +
//						"			and upper(trim(prod.status)) = \"active\" \n" +
//						"		)A\n" +
//						"		join \n" +
//						"		(\n" +
//						"			select A.* from \n" +
//						"			(\n" +
//						"				select *,row_number() over(partition by pid order by max_bid_amount desc) as rn\n" +
//						"				from biddings \n" +
//						"			)A where A.rn = 1\n" +
//						"		)B on B.pid = A.pid\n" +
//						"		left join\n" +
//						"		(\n" +
//						"			select A.* from \n" +
//						"			(\n" +
//						"				select *,dense_rank() over(partition by pid order by max_bid_amount desc) as rn\n" +
//						"				from biddings \n" +
//						"			)A where A.rn = 2\n" +
//						"		)C on A.pid = C.pid\n" +
//						"	)inter\n" +
//						")inter2\n;";
		

		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(query);
			while(rs.next()) {
				System.out.println(rs.getString("email") + " " + rs.getString("pid") + " " + rs.getString("current_bid") + " " + rs.getString("user_max_bid"));
				String email = rs.getString("email");
				String pid = rs.getString("pid");
				String currentBid = rs.getString("current_bid");
				String updateQuery = "UPDATE biddings SET current_bid = '"+ currentBid + "' WHERE (pid = '" + pid + "') and (email = '" + email + "');";
				PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
				System.out.println(preparedStatement);
				success = preparedStatement.executeUpdate();
			}
			success = 1;
		}catch(Exception e){
			e.printStackTrace();
			success = -1;
		}

		return success;

		//update each enrty with the new current bid
	}
}
