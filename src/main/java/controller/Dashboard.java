package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Dashboard
 */
@WebServlet("/Dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Dashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session=request.getSession(false);
		if(session == null) {
			System.out.println("Session is nulllllllllllllllllllllllllllllllllllllllllllllllllllll");
			response.sendRedirect("/BuyMe/login");
			//response.sendRedirect("/BuyMe/login");
			//RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Login.jsp");
			//dispathcer.forward(request,response);
		}else {
			int role = (int) session.getAttribute("role");
			System.out.println("User logged in - role : "+role);
			response.getWriter().append("Served at: ").append(request.getContextPath());
			//System.out.println("Email in dashboard : +++" +request.getSession().getAttribute("email"));
			
			if(role == 1) { //role = end user
				RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Dashboard.jsp");
				dispathcer.forward(request,response);
			}else if (role == 2){ //role = staff
				RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/DashboardStaff.jsp");
				dispathcer.forward(request,response);
			}else { //role == 3 = admin
				RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/DashboardAdmin.jsp");
				dispathcer.forward(request,response);
			}
		}
				
		//RequestDispatcher dispathcer = request.getRequestDispatcher("/WEB-INF/Views/Dashboard.jsp");
		//dispathcer.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//System.out.println("Email in dashboard : +++" +request.getSession().getAttribute("email"));
		doGet(request, response);
	}

}
