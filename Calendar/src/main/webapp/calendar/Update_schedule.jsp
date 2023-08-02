<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.CalendarEvent" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>일정 수정</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/insert.css">
</head>
<body>
<%
    CalendarEvent event = (CalendarEvent) request.getAttribute("event");
    String origin_title = event.getEvent_title(); // To-do::2
    String[] titleParts = origin_title.split("::");
    String event_title_dropdown = titleParts[0];
    String event_title = titleParts[1];
    request.setAttribute("event_title_dropdown",event_title_dropdown);
    request.setAttribute("event_title",event_title);
%>
  
    <a href="${pageContext.request.contextPath}/calendar/Cal">달력보기</a>
	
    <c:if test="${not empty requestScope.event }">
        <form name="updateForm" action="${pageContext.request.contextPath }/calendar/Update.do" method="POST">
            <input type="hidden" name="event_id" value="${event.event_id }">
            <label for="event_title">event_title:</label>
		        <select id="event_title_dropdown" name="event_title_dropdown">
		            <option value="To-do" ${event_title_dropdown eq 'To-do' ? 'selected' : ''}>To-do</option>
		            <option value="과제" ${event_title_dropdown eq '과제' ? 'selected' : ''}>과제</option>
		        </select>
            <input type="text" id="event_title" name="event_title" value="${event_title}" required><br>
            <label for="event_date">event_date:</label>
            <input type="text" id="event_date" name="event_date" value="${event.event_date }" required><br>
            <label for="event_description">event_description:</label>
            <input type="text" id="event_description" name="event_description" value="${event.event_description }" required><br>
            <input class="insert-button" type="submit" value="일정 업데이트" onclick="return checkInsert(this.form);">
        </form>
    </c:if>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
	   
        function checkInsert(form) {
            var r = form;
            if (form.event_title.value === '' || form.event_date.value === '' || form.event_description.value === '') {
                alert("빈칸이 있습니다. 모두 입력해주세요.");
                return false;
            }
            return true;
        }
 
    </script>
</body>
</html>