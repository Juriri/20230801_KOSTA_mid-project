package calendar.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import calendar.service.Service;
import calendar.service.ServiceImpl;
import model.CalendarEvent;

/**
 * Servlet implementation class insertController
 */
@WebServlet("/calendar/Insert")
public class InsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action  = request.getParameter("action");
		String path = "";
		if (action != null && action.equals("insertDone")) {
			request.setAttribute("msg", "일정이 등록되었습니다. ");
			path = "/calendar/calendar.jsp";
		}
		else {
			String currentDate_str = request.getParameter("selectedDate");
			java.sql.Date currentDate = java.sql.Date.valueOf(currentDate_str);
			request.setAttribute("currentDate", currentDate);
			
			Service service = new ServiceImpl();
			List<CalendarEvent> events = service.getAllBydate(currentDate);
			request.setAttribute("events", events);
			
			path = "/calendar/Insert_schedule.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(path);
		if (dispatcher != null) {
			dispatcher.forward(request, response);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
