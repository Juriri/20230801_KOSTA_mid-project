package user.service;

import model.User;

public interface Service {
	
	void join(User u);
	User getMember(String id);
	void editMember(User u);
	void remMember(String id);
	boolean login(String id, String pwd);
}
