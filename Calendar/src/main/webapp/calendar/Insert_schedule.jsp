<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>일정 입력</title>
</head>
<body>
<a href="${pageContext.request.contextPath}/calendar/calendar.jsp">달력보기</a>
<c:if test="${not empty requestScope.currentDate }">
<form name="insertForm" action="${pageContext.request.contextPath }/calendar/Insert.do" method="POST">
event_title: <input type="text" name="event_title">
<input type="text" name="event_date" value="<%=request.getAttribute("currentDate")%>">
event_description: <input type="text" name="event_description">
<input type="submit" value="일정 등록" onclick="return checkInsert(this.form);">
</form>
</c:if>
<c:if test="${not empty requestScope.events}">
    <table>
        <tr>
            <th>Event Date</th>
            <th>Event Title</th>
            <th>Event Discripton</th>
        </tr>
        <c:forEach items="${requestScope.events}" var="event">
            <tr>
                <td>${event.event_date}</td>
                <td>${event.event_title}</td>
                <td>${event.event_description}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<c:if test="${empty requestScope.currentDate }">
뒤로 가서 날짜를 선택하세요

</c:if>

<script type="text/javascript">
function checkInsert(form) {
	var r = form;
    if (form.event_title.value === '' || form.event_date.value  === '' || form.event_description.value  === '') {
        alert("빈칸이 있습니다. 모두 입력해주세요.");
        return false;
    }
    return true;
}

</script>
</body>
</html>