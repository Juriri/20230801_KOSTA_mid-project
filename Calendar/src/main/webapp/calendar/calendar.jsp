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
<title>일정 관리</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/calendar_style.css">
</head>
<body>
    <%-- 현재 날짜 정보를 JavaScript 변수에 저장 --%>
    <% Date currentDate = (Date) session.getAttribute("nextDate");
    if (currentDate == null) {
    	// currentDate가 null인 경우, 세션에 현재 날짜를 저장합니다.
        currentDate = java.sql.Date.valueOf(LocalDate.now());
        session.setAttribute("nextDate", currentDate);
    }

    // 파라미터로 전달받은 year와 month 값을 이용하여 원하는 년도와 월의 달력을 출력합니다.
    int currentYear = currentDate.getYear() + 1900; // 1900을 더해서 연도를 구합니다.
    int currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해서 원래 월을 구합니다.

    String dayOfWeekStr = currentDate.toLocalDate().getDayOfWeek().name();

    // 현재 월의 첫날과 마지막 날을 구합니다.
    Date firstDayOfMonth = Date.valueOf(LocalDate.of(currentYear, currentMonth, 1));
    Date lastDayOfMonth = Date.valueOf(LocalDate.of(currentYear, currentMonth, LocalDate.of(currentYear, currentMonth, 1).lengthOfMonth()));

    // 해당 월의 시작 요일을 가져옵니다.
    DayOfWeek firstDayOfWeek = firstDayOfMonth.toLocalDate().getDayOfWeek();
    // 캘린더 시작 요일을 일요일(SUNDAY)로 변경
    int startDayValue = firstDayOfWeek.getValue() % 7;
    %>
	<div class="container">
		<div class="menu-container">
			    <h1><%= currentYear %>년 <%= currentMonth %>월</h1>
			    <a href="${pageContext.request.contextPath}/calendar/Cal?action=previous&currentDate=<%= currentDate %>">◀</a>
  				<a href="${pageContext.request.contextPath}/calendar/Cal?action=next&currentDate=<%= currentDate %>">▶</a>
			    <a href="${pageContext.request.contextPath}/calendar/Cal?action=now">오늘 날짜</a>
			    <table border="1">
			        <tr>
			            <th>일</th>
			            <th>월</th>
			            <th>화</th>
			            <th>수</th>
			            <th>목</th>
			            <th>금</th>
			            <th>토</th>
			        </tr>
			        <!-- 출력할 날짜 값 -->
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
				                <% dayOfMonth++; // 다음 날짜로 변경 %>
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
	        	///calendar/List?action=title 에서 현재 달력의 일정이 있는 배열을 가져옴
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
