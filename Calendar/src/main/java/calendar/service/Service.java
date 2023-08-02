package calendar.service;

import java.sql.Date;
import java.util.List;

import model.CalendarEvent;

public interface Service {
	public void insert(CalendarEvent cal);
	public List<CalendarEvent> getAll();
	public List<CalendarEvent> getAllBymonth(int year, int month);
	public List<CalendarEvent> getAllBydate(Date date);
	void deleteEvent(int event_id);
}
