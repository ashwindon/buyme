package service;

import java.sql.Connection;
import java.sql.PreparedStatement;

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
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
