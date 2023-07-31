<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="java.time.*, javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>일정 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/calender_style.css">

</head>
<body>
    <% // 현재 날짜 정보를 JavaScript 변수에 저장
    	LocalDate currentDate = (LocalDate)session.getAttribute("nextDate");
    	 if (currentDate == null){
    		currentDate = LocalDate.now();
    	} 
    		
        // 파라미터로 전달받은 year와 month 값을 이용하여 원하는 년도와 월의 달력을 출력합니다.     	
	    int currentYear = currentDate.getYear();
	    int currentMonth = currentDate.getMonthValue();
        
        String dayOfWeekStr = currentDate.getDayOfWeek().name();
       
     	// 현재 월의 첫날과 마지막 날을 구합니다.
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
        LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth());
     	
        // 해당 월의 시작 요일을 가져옵니다.
        DayOfWeek firstDayOfWeek = firstDayOfMonth.getDayOfWeek();
        // 캘린더 시작 요일을 일요일(SUNDAY)로 변경
        int startDayValue = firstDayOfWeek.getValue() % 7;
        
     %>
    <h1><%=currentYear %>년 <%=currentMonth %>월</h1>
    <a href="${pageContext.request.contextPath }/calender/Cal?action=previous&currentDate=<%= currentDate %>">◀</a>
  	<a href="${pageContext.request.contextPath }/calender/Cal?action=next&currentDate=<%= currentDate %>">▶</a>
  
    <table>
        <tr>
            <th>일</th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
            <th>토</th>
        </tr>
        <tr>
            <%-- 시작 요일까지 빈 셀 생성 --%>
            <% for (int i = 0; i < startDayValue; i++) { %>
                <td></td>
            <% } %>

            <%-- 해당 월의 날짜 출력 --%>
            <% for (LocalDate date = firstDayOfMonth; date.isBefore(lastDayOfMonth.plusDays(1)); date = date.plusDays(1)) { %>
                <td>
                	<button class="calButton" onclick="location.href='${pageContext.request.contextPath }/calender/Insert?selectedDate=<%= date %>'"><%= date.getDayOfMonth() %></button>
                </td>
                
                <%-- 토요일이면 줄 바꾸기 --%>
                <% if (date.getDayOfWeek() == DayOfWeek.SATURDAY) { %>
                    </tr><tr>
                <% } %>
            <% } %>

            <%-- 마지막 주의 나머지 빈 셀 생성 --%>
            <% int remainingEmptyCells = 7 - lastDayOfMonth.getDayOfWeek().getValue();
            for (int i = 0; i < remainingEmptyCells; i++) { %>
                <td></td>
            <% } %>
        </tr>
    </table>
</body>
</html>