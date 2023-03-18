package controller;
import service.UserService;
import model.UserModel;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/createNewUser")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserService userService = new UserService();
    /**
     * Default constructor. 
     */
    public UserController() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserRegister.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone_no = request.getParameter("phone_no");
		String password = request.getParameter("password");
		
		UserModel userModel = new UserModel();
		userModel.setEmail(email);
		userModel.setName(name);
		userModel.setPhone_no(phone_no);
		userModel.setPassword_hash(password);
		int success = 0;
		try {
			success = userService.createNewUser(userModel);
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(success == 1) {
			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Login.jsp");
			dispathcer.forward(request,response);			
		}else {
			//there was an error during user registration
			//redirect to same page
			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserRegister.jsp");
			dispathcer.forward(request,response);
		}

		
	}

}
