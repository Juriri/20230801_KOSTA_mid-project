package model;

public class ChecklistItem {
	
	private int item_id;
	private String item_title;
	private String item_description;
	private int event_id;
	
	public ChecklistItem(int item_id, String item_title, String item_description, int event_id) {
		super();
		this.item_id = item_id;
		this.item_title = item_title;
		this.item_description = item_description;
		this.event_id = event_id;
	}
	public int getItem_id() {
		return item_id;
	}
	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	public String getItem_title() {
		return item_title;
	}
	public void setItem_title(String item_title) {
		this.item_title = item_title;
	}
	public String getItem_description() {
		return item_description;
	}
	public void setItem_description(String item_description) {
		this.item_description = item_description;
	}
	public int getEvent_id() {
		return event_id;
	}
	public void setEvent_id(int event_id) {
		this.event_id = event_id;
	}
	@Override
	public String toString() {
		return "ChecklistItem [item_id=" + item_id + ", item_title=" + item_title + ", item_description="
				+ item_description + ", event_id=" + event_id + "]";
	}
	
	

}
