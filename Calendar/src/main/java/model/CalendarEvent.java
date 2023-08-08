package model;

import java.sql.Date;

public class CalendarEvent {
	
	private int event_id;
	private String event_title;
	private Date event_date;
	private String event_description;
	
	public CalendarEvent() {}
	public CalendarEvent(int event_id, String event_title, Date event_date, String event_description) {
		super();
		this.event_id = event_id;
		this.event_title = event_title;
		this.event_date = event_date;
		this.event_description = event_description;
	}
	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	public String getEvent_title() {
		return event_title;
	}
	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}
	public Date getEvent_date() {
		return event_date;
	}
	public void setEvent_date(Date event_date) {
		this.event_date = event_date;
	}
	public String getEvent_description() {
		return event_description;
	}
	public void setEvent_description(String event_description) {
		this.event_description = event_description;
	}
	@Override
	public String toString() {
		return "CalendarEvent [event_id=" + event_id + ", event_title=" + event_title + ", event_date=" + event_date
				+ ", event_description=" + event_description + "]";
	}
	
	
	
}