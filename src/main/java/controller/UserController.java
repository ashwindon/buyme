package controller;
import service.UserService;
import model.UserModel;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

		HttpSession session=request.getSession(false);  
		if(session == null) {
			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserRegister.jsp");
			dispathcer.forward(request,response);
		}else {
			int role = (int) session.getAttribute("role");
			if(role == 3) {
				RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/StaffRegister.jsp");
				dispathcer.forward(request,response);
			}else if(role == 1){
				response.sendRedirect("/BuyMe/Dashboard");
				//RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserRegister.jsp");
				//dispathcer.forward(request,response);
			}
		}
		
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
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session=request.getSession(false);
		int success = 0,role = 0;
		if(session == null){
			
			try {
				role = 1;
				userModel.setIsAdmin(role);
				success = userService.createNewUser(userModel);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}else {
			role = (int) session.getAttribute("role");
			userModel.setIsAdmin(role);
			
			try {
				success = userService.createNewUser(userModel);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		//role = (int) session.getAttribute("role");
		
		if(success == 1) {
			if(role == 3) {
				//response.sendRedirect("/BuyMe/login");
				PrintWriter out = response.getWriter();
				out.println("<script type=\"text/javascript\">");  

				out.println("alert(\"Success Creating New Staff Member!\");") ; 
				out.println("window.location.href = \"/BuyMe/Dashboard\";");
				out.println("</script>;");
			}else {
				RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Login.jsp");
				dispathcer.forward(request,response);	
			}
						
		}else {
			//there was an error during user registration
			//redirect to same page
			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/UserRegister.jsp");
			dispathcer.forward(request,response);
		}

		
	}

}
