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
		int success = 0;
		try {
			DatabaseConnection db = new DatabaseConnection();	
			Connection con = db.getConnection();
			PreparedStatement preparedStatement = con.prepareStatement(ANSWER_QUESTION);
			success = preparedStatement.executeUpdate();
			db.closeConnection(con);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;
	}
}