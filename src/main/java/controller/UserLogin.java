package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import service.UserService;
import model.UserModel;

/**
 * Servlet implementation class UserLogin
 */
@WebServlet("/login")
public class UserLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserService userService = new UserService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Login.jsp");
		dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String email = request.getParameter("email");
		//System.out.println("Input from Login page email as :" + email);
		String password = request.getParameter("password");
		//System.out.println("Input from Login page password as :" + password);
		//System.out.println("Received Login request");
		UserModel userModel = new UserModel();
		userModel.setEmail(email);
		userModel.setPassword_hash(password); //using the UserModel class temporarily to send email and password to User Login Service
		int success = 0;
		try {
			//System.out.println("Calling login function");
			success = userService.loginUser(userModel);
			//System.out.println("After Calling login function");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(success == 1) {
			//System.out.println("User login was successful and returned success = 1 ... redirecting to dashboard");
			HttpSession session=request.getSession();
			session.setAttribute("email",email);
//			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Dashboard.jsp");
//			dispathcer.forward(request,response);
			response.sendRedirect("/BuyMe/Dashboard");
		}else {
			//login failed try again
			//redirect to same page
			//System.out.println("Login failed");
//			RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Login.jsp");
//			dispathcer.forward(request,response);
			
			
			
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");  

			out.println("alert(\"Incorrect Credentials! Login Failed!\");") ; 
			out.println("window.location.href = \"/BuyMe/login\";");
			out.println("</script>;");

		}
		
	}

}
