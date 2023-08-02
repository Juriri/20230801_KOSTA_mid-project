package calendar.control;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import calendar.service.Service;
import calendar.service.ServiceImpl;
import model.CalendarEvent;

/**
 * Servlet implementation class UpdateController
 */
@WebServlet("/calendar/Update")
public class UpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateController() {
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
		CalendarEvent event = null;
		Service service = new ServiceImpl();
		
		if (action != null && action.equals("updateDone")) {
			request.setAttribute("msg", "일정이 수정되었습니다. ");
		} 
		
		int event_id = Integer.parseInt(request.getParameter("event_id"));
		event = service.getById(event_id);
		request.setAttribute("event", event);
		
		path = "/calendar/Update_schedule.jsp";
		
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
