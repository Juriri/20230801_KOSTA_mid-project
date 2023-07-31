<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" import="java.time.*, javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>���� ����</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/board_style.css">

</head>
<body>
    <% // ���� ��¥ ������ JavaScript ������ ����
    	LocalDate currentDate = (LocalDate)session.getAttribute("nextDate");
        // �Ķ���ͷ� ���޹��� year�� month ���� �̿��Ͽ� ���ϴ� �⵵�� ���� �޷��� ����մϴ�.     	
	    int currentYear = currentDate.getYear();
	    int currentMonth = currentDate.getMonthValue();
        
        String dayOfWeekStr = currentDate.getDayOfWeek().name();
       
     	// ���� ���� ù���� ������ ���� ���մϴ�.
        LocalDate firstDayOfMonth = currentDate.withDayOfMonth(1);
        LocalDate lastDayOfMonth = currentDate.withDayOfMonth(currentDate.lengthOfMonth());
     	
        // �ش� ���� ���� ������ �����ɴϴ�.
        DayOfWeek firstDayOfWeek = firstDayOfMonth.getDayOfWeek();
        // Ķ���� ���� ������ �Ͽ���(SUNDAY)�� ����
        int startDayValue = firstDayOfWeek.getValue() % 7;
        
     %>
    <h1><%=currentYear %>�� <%=currentMonth %>��</h1>
    <a href="${pageContext.request.contextPath }/calender/Cal?action=previous&currentDate=<%= currentDate %>">���� ��</a>
  	<a href="${pageContext.request.contextPath }/calender/Cal?action=next&currentDate=<%= currentDate %>">���� ��</a>
  
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
        <tr>
            <%-- ���� ���ϱ��� �� �� ���� --%>
            <% for (int i = 0; i < startDayValue; i++) { %>
                <td></td>
            <% } %>

            <%-- �ش� ���� ��¥ ��� --%>
            <% for (LocalDate date = firstDayOfMonth; date.isBefore(lastDayOfMonth.plusDays(1)); date = date.plusDays(1)) { %>
                <td><%= date.getDayOfMonth() %></td>
                
                <%-- ������̸� �� �ٲٱ� --%>
                <% if (date.getDayOfWeek() == DayOfWeek.SATURDAY) { %>
                    </tr><tr>
                <% } %>
            <% } %>

            <%-- ������ ���� ������ �� �� ���� --%>
            <% int remainingEmptyCells = 7 - lastDayOfMonth.getDayOfWeek().getValue();
            for (int i = 0; i < remainingEmptyCells; i++) { %>
                <td></td>
            <% } %>
        </tr>
    </table>
</body>
</html>