package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	public Connection getConnection(){
		
		//Create a connection string
		//String connectionUrl = "jdbc:mysql://localhost:3306/BarBeerDrinkerSample";
		String connectionUrl = "jdbc:mysql://localhost:3306/cs527project";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			connection = DriverManager.getConnection(connectionUrl,"root", "Aaplsp1997");
		} catch (SQLException e) {
			System.out.println("\n\n\n\\n\n\nLOLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL\n\n\n\n\\n\n\n");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("\n\n\n\\n\n\nLOLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL\n\n\n\n\\n\n\n");
			e.printStackTrace();
		}
	}
	
	
	
	
	
//	public static void main(String[] args) {
//		DatabaseConnection dao = new DatabaseConnection();
//		Connection connection = dao.getConnection();
//		
//		System.out.println(connection);		
//		dao.closeConnection(connection);
//	}
}
