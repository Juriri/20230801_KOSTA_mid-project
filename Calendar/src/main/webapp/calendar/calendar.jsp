<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.sql.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/calendar_style.css">
</head>
<body>
    <%-- ���� ��¥ ������ JavaScript ������ ���� --%>
    <% Date currentDate = (Date) session.getAttribute("nextDate");
    if (currentDate == null) {
    	// currentDate�� null�� ���, ���ǿ� ���� ��¥�� �����մϴ�.
        currentDate = java.sql.Date.valueOf(LocalDate.now());
        session.setAttribute("nextDate", currentDate);
    }

    // �Ķ���ͷ� ���޹��� year�� month ���� �̿��Ͽ� ���ϴ� �⵵�� ���� �޷��� ����մϴ�.
    int currentYear = currentDate.getYear() + 1900; // 1900�� ���ؼ� ������ ���մϴ�.
    int currentMonth = currentDate.getMonth() + 1; // ���� 0���� �����ϹǷ� 1�� ���ؼ� ���� ���� ���մϴ�.

    String dayOfWeekStr = currentDate.toLocalDate().getDayOfWeek().name();

    // ���� ���� ù���� ������ ���� ���մϴ�.
    Date firstDayOfMonth = Date.valueOf(LocalDate.of(currentYear, currentMonth, 1));
    Date lastDayOfMonth = Date.valueOf(LocalDate.of(currentYear, currentMonth, LocalDate.of(currentYear, currentMonth, 1).lengthOfMonth()));

    // �ش� ���� ���� ������ �����ɴϴ�.
    DayOfWeek firstDayOfWeek = firstDayOfMonth.toLocalDate().getDayOfWeek();
    // Ķ���� ���� ������ �Ͽ���(SUNDAY)�� ����
    int startDayValue = firstDayOfWeek.getValue() % 7;
    %>
	<div class="container">
		<div class="menu-container">
			    <h1><%= currentYear %>�� <%= currentMonth %>��</h1>
			    <a href="${pageContext.request.contextPath}/calendar/Cal?action=previous&currentDate=<%= currentDate %>">��</a>
  				<a href="${pageContext.request.contextPath}/calendar/Cal?action=next&currentDate=<%= currentDate %>">��</a>
			    <a href="${pageContext.request.contextPath}/calendar/Cal?action=now">���� ��¥</a>
			    <table border="1">
			        <tr>
			            <th>��</th>
			            <th>��</th>
			            <th>ȭ</th>
			            <th>��</th>
			            <th>��</th>
			            <th>��</th>
			            <th>��</th>
			        </tr>
			        <!-- ����� ��¥ �� -->
				    <% int dayOfMonth = 1; for (int row = 0; row < 6; row++) { %>
				        <tr>
				        <% for (int col = 0; col < 7; col++) { %>
				            <% if ((row == 0 && col < startDayValue) || dayOfMonth > lastDayOfMonth.getDate()) { %>
				                <td></td>
				            <% } else { %>
				                <% String todayClass = (dayOfMonth == LocalDate.now().getDayOfMonth() && currentYear == LocalDate.now().getYear() && currentMonth == LocalDate.now().getMonthValue()) ? "today" : ""; %>
	                            <td class="<%= todayClass %>">
	                                <button class="calButton" id="calButton" data-dayOfMonth="<%= dayOfMonth %>"
	                                onclick="location.href='${pageContext.request.contextPath}/calendar/Insert?selectedDate=<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(java.sql.Date.valueOf(LocalDate.of(currentYear, currentMonth, dayOfMonth))) %>'"><%= dayOfMonth %>
	                                </button>
	                            </td>
				                <% dayOfMonth++; // ���� ��¥�� ���� %>
				            <% } %>
				        <% } %>
				        </tr>
				    <% } %>
			    </table>
		</div>
	</div>
	
<script>
	window.onload = function() {
	    // This will be executed when the page finishes loading
	    // Send AJAX request to /calendar/List?action=title
	    var xhr = new XMLHttpRequest();
	    xhr.onreadystatechange = function() {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	        	///calendar/List?action=title ���� ���� �޷��� ������ �ִ� �迭�� ������
	        	 var events = JSON.parse(xhr.responseText);
	        	 
	        	 for (var i = 0; i < events.length; i++) {
	        		 
	                 var event = events[i];
	                 var title = event.event_title;
	              	// Truncate title to 10 characters if it's longer
	                 if (title.length > 5) {
	                     title = title.substring(0, 5);
	                 }
	              
	                 var day = event.event_date.split(" ")[1].replace(",", "");
	                 
	                 var cells = document.getElementsByClassName("calButton");
	               
	                 for(var j=1; j<=31; j++){
	                	 if (day == j){
	                		 cells[j-1].innerHTML += "<br>" + title;
	                	 }
	                 }
	             }
	        }
	    };
	    xhr.open("GET", "${pageContext.request.contextPath}/calendar/List.do?action=title&currentYear=<%= currentYear %>&currentMonth=<%= currentMonth %>", true);
	    xhr.send();
	};
	
	

	var resultMsg = '<%= request.getAttribute("msg") %>';
	if (resultMsg != "null" && resultMsg.trim() !== '') {
	    alert(resultMsg);
	}
</script>
</body>
</html>
