package checklist.dao;

import java.util.List;

import model.CalendarEvent;


public interface Dao {
	
	List<CalendarEvent> selectAll();
	

}
