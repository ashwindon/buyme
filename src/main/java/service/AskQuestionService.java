package service;
import java.sql.*;

import repository.DatabaseConnection;
public class AskQuestionService {

	public int RegisterQuestion(String email, String question) {
		String MARK_AS_READ_QUERY = "INSERT INTO user_qa (user_question,staff_answer,email,status) values (\""+question+"\",\"Question Not Answered By Staff Yet!\",\""+email+"\",\"not-answered\");";
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
		return success;
	}
	
	public int AnswerQuestion(int qid, String staff_answer) {
		
		String ANSWER_QUESTION = "UPDATE user_qa SET status = \"answered\", staff_answer = \""+staff_answer+"\" where qid = "+qid+";";
		String GET_QUESTION = "SELECT user_question from user_qa where qid ="+qid+";";
		
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(ANSWER_QUESTION);
			
			success = preparedStatement.executeUpdate();
			Statement statement = con.createStatement();
			ResultSet rs = statement.executeQuery(GET_QUESTION);
			String temp_question = "";
			while(rs.next()) {
				temp_question = rs.getString("user_question");
			}
			String INSERT_INTO_FAQ = "INSERT INTO questionandanswers (question,answer) VALUES (\""+temp_question+"\",\""+staff_answer+"\");";
			PreparedStatement preparedStatement2 = con.prepareStatement(INSERT_INTO_FAQ);
			success = preparedStatement.executeUpdate();
			if(success > 0) {
				//insert into FAQ
				success = preparedStatement2.executeUpdate();
			}
			
			db.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;
	}
}