package service;

import java.sql.*;
import repository.DatabaseConnection;
import model.*;
import java.util.Base64;
import java.security.*;

public class UserService {
	
	public int createNewUser(UserModel user) throws ClassNotFoundException{
		String CREATE_NEW_USER_QUERY = "INSERT INTO user" + " (name, email, phone_no, password_hash, unique_salt) 	VALUES" + " (?,?,?,?,?);";
		
		int success = 0;
		
		
		
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			
			PreparedStatement preparedStatement = con.prepareStatement(CREATE_NEW_USER_QUERY);
			preparedStatement.setString(1, user.getName());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPhone_no());
			user.setUnique_salt(generateUniqueSalt());
			preparedStatement.setString(5, user.getUnique_salt());
			user.setPassword_hash(generatePasswordHash(user.getPassword_hash(),user.getUnique_salt()));
			preparedStatement.setString(4, user.getPassword_hash());

			System.out.println(preparedStatement);
			
			success = preparedStatement.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return success;
	}
	
	public String generateUniqueSalt() {
		SecureRandom randombytes = new SecureRandom();
        byte[] unique_salt = new byte[24];
        randombytes.nextBytes(unique_salt);
        return Base64.getEncoder().encodeToString(unique_salt);
        
	}
	
	public String generatePasswordHash(String user_password_string, String unique_salt) throws NoSuchAlgorithmException {
		try {
			MessageDigest d = MessageDigest.getInstance("SHA256");
			
			d.reset();
			d.update(Base64.getDecoder().decode(unique_salt));
			
			byte[] password_hash = d.digest(Base64.getDecoder().decode(user_password_string));
			
			return Base64.getEncoder().encodeToString(password_hash);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int loginUser(UserModel userModel) {
		int success = 0;
		System.out.println("Received Login request");
		//first get the user email and password from request
		
		String email = userModel.getEmail();
		System.out.println("Received email in service as : "+ email);
		String password = userModel.getPassword_hash();
		System.out.println("Received password in service as : "+password);
		//now first check if the user exists in the database
		String GET_USER_DATA = "SELECT * FROM user WHERE email = \"" + email +"\";";
		System.out.println("Printing query : " + GET_USER_DATA);
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			
			Statement statement = con.createStatement();
			System.out.println(statement);
			ResultSet resultSet = statement.executeQuery(GET_USER_DATA);
			System.out.println("Executed select query");
//			if(resultSet != null) {
//				System.out.println("ResultSet is not empty");
//			}else {
//				System.out.println("Resultset is empty");
//			}
			if(resultSet.next()) {
				//System.out.println("We did not come here!");
				String resultSetEmail = resultSet.getString("email");
				System.out.println("Printing email : "+resultSetEmail);
				if(resultSetEmail == null) {
					System.out.println("Got null in resultSet email");
					//user does not exist
					success = 0;
					return success;
				}else {
					System.out.println("retrieved user data from database successfully");
					//user exists ... now lets check the password
					String resultSetPassword = resultSet.getString("password_hash");
					String resultSetSalt = resultSet.getString("unique_salt");
					
					//now lets generate a hash using resultSetSalt and password from request and compare it with resultSetPassword(which is also a hash) 
					String generatedHash = generatePasswordHash(password,resultSetSalt);
					System.out.println("comparing password hash");
					boolean password_match = compareHash(resultSetPassword,generatedHash);
					if(password_match) {
						//password is correct ... login the user
						//create httpSession and stuff
						System.out.println("Password match successful returning success");
						success = 1;
						return success;
					}else {
						//password is wrong
						//return 0
						System.out.println("Password match failed returning zero");
						success = 0;
						return success;
					}
					
				}
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return success;
	}
	
	public boolean compareHash(String resultSetPassword, String generatedHash) {
		byte[] dbhash = resultSetPassword.getBytes();
		byte[] temphash = generatedHash.getBytes();
 		int difference = dbhash.length^temphash.length;
 		
 		for(int i = 0; i < dbhash.length && i < dbhash.length; i++)
            difference |= dbhash[i] ^ temphash[i];
		
		return difference == 0;
	}

}
