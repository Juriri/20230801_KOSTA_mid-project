<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.DayOfWeek" %>
<%@ page import="java.sql.Date" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<title>일정 확인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checkinput.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/checklist.css">
<script>
	function selectCheck(){
		var m = document.calendar.month;
		if(m.value == ""){
			alert("해당 월을 선택하세요.");
		}
	}
</script>
</head>
<body>
<%
	Date currentDate = (Date) session.getAttribute("currentDate");
	if (currentDate == null) {
    	currentDate = java.sql.Date.valueOf(LocalDate.now());
    	session.setAttribute("nextDate", currentDate);
	}

	int currentYear = currentDate.getYear() + 1900;
	int currentMonth = currentDate.getMonth() + 1;
%>
	<div id="wrapper">
	<h2><%= currentYear %>년 <%= currentMonth %>월 일정 목록</h2>
	<a href="${pageContext.request.contextPath}/calendar/Cal">달력보기</a>
		<form >
			<select name="month" onchange="selectCheck()">
				<option value="">---</option>
				<option value="1">1월</option>
				<option value="2">2월</option>
				<option value="3">3월</option>
				<option value="4">4월</option>
				<option value="5">5월</option>
				<option value="6">6월</option>
				<option value="7">7월</option>
				<option value="8">8월</option>
				<option value="9">9월</option>
				<option value="10">10월</option>
				<option value="11">11월</option>
				<option value="12">12월</option>
			</select>
			<button type="button" id="search" class="sBtn">검색</button>
		</form>
		<div id="itemList"></div>
	</div>
	
</body>
</html>