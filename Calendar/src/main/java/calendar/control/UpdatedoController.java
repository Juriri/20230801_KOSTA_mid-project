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

import calendar.service.*;
import model.CalendarEvent;

/**
 * Servlet implementation class InsertdoController
 */
@WebServlet("/calendar/Update.do")

public class UpdatedoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdatedoController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		/*event_id: 일정 고유 ID (Primary Key)
		event_title: 일정 제목
		event_date: 일정 날짜와 시간
		event_description: 일정 설명*/
		
		int event_id = Integer.parseInt(request.getParameter("event_id"));
		Service service = new ServiceImpl();
		CalendarEvent event = service.getById(event_id);
		
		
		String event_title_dropdown = request.getParameter("event_title_dropdown");
		String event_title = event_title_dropdown + "::"+request.getParameter("event_title");
		Date event_date = Date.valueOf(request.getParameter("event_date"));
		String event_description = request.getParameter("event_description");

		event.setEvent_title(event_title);
		event.setEvent_date(event_date);
		event.setEvent_description(event_description);
		
		service.updateEvent(event);

		String path = request.getContextPath() + "/calendar/Update?action=updateDone&event_id="+event_id;
		response.sendRedirect(path);
	}

}
