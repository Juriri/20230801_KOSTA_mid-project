<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.time.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 관리</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board_style.css">
	<script type="text/javascript">
	</script>
</head>
<body>
    <% 
        LocalDate currentDate = LocalDate.now();
        int year = currentDate.getYear();
        int month = currentDate.getMonthValue();
        DayOfWeek dayOfWeek = currentDate.getDayOfWeek();
        String dayOfWeekStr = dayOfWeek.name();
    
     	// 현재 월의 첫날과 마지막 날을 구합니다.
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
        LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth()); 
     %>
    <h1><%=year %>년 <%=month %>월</h1>
    <a href="${pageContext.request.contextPath }/calender/Cal?action=previous&currentDate=<%= currentDate %>">이전 달</a>
  	<a href="${pageContext.request.contextPath }/calender/Cal?action=next&currentDate=<%= currentDate %>">다음 달</a>
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
        <tr>
            <%-- 첫 주의 공백 셀 만들기 --%>
            <% for (int i = 1; i < firstDayOfMonth.getDayOfWeek().getValue(); i++) { %>
                <td></td>
            <% } %>

            <%-- 해당 월의 날짜 출력 --%>
            <% for (LocalDate date = firstDayOfMonth; date.isBefore(lastDayOfMonth.plusDays(1)); date = date.plusDays(1)) { %>
                <td><%= date.getDayOfMonth() %></td>

                <%-- 토요일이면 줄 바꾸기 --%>
                <% if (date.getDayOfWeek() == DayOfWeek.SATURDAY) { %>
                    </tr><tr>
                <% } %>
            <% } %>

            <%-- 마지막 주의 공백 셀 만들기 --%>
            <% for (int i = lastDayOfMonth.getDayOfWeek().getValue(); i < 7; i++) { %>
                <td></td>
            <% } %>
        </tr>
    </table>
</body>
</html>