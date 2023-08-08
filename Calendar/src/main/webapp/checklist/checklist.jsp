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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/insert.css">
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
	<h2 id="currentMonthText"><%= currentYear %>년 <%= currentMonth %>월 일정 목록</h2>
	<a href="${pageContext.request.contextPath}/calendar/Cal">달력보기</a>
	<form>
			<select name="month" id="selectMonth">
				<option value="">---</option>
				<option value="01">1월</option>
				<option value="02">2월</option>
				<option value="03">3월</option>
				<option value="04">4월</option>
				<option value="05">5월</option>
				<option value="06">6월</option>
				<option value="07">7월</option>
				<option value="08">8월</option>
				<option value="09">9월</option>
				<option value="10">10월</option>
				<option value="11">11월</option>
				<option value="12">12월</option>
			</select>
			<button id="search" type="button" class="sBtn">검색</button>
	</form>
	</div>
	
	<div id="eventListContainer">
		<table>
		    <tr>
		        <th>Event Date</th>
		        <th>Event Title</th>
		        <th>Event Description</th>
		    </tr>
		    <tbody id="eventTableBody">
		        <!-- This is where the event data rows will be populated -->
		    </tbody>
		</table>
	</div>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    //버튼이 눌리면 current month 변경
    function selectCheck(selectedMonth) {
        var currentYear = <%=currentYear%>;

        if (selectedMonth === "") {
            alert("해당 월을 선택하세요.");
        } else if (selectedMonth !== "") {

            var currentMonth = selectedMonth;
            var h2Element = $("#currentMonthText");
            h2Element.text(currentYear + "년 " + currentMonth + "월 일정 목록");

            $.ajax({
                url: "${pageContext.request.contextPath}/calendar/List.do?action=titleBymonth&currentYear=" + currentYear + "&currentMonth=" + currentMonth,
                method: "GET",
                dataType: "json",
                success: function(events) {
                    var eventTableBody = $("#eventTableBody");
                    eventTableBody.empty(); // Clear the table body before displaying the events

                    for (var i = 0; i < events.length; i++) {
                    	var event = events[i];
                        var row = $("<tr></tr>");

                        var dateCell = $("<td></td>").text(event.event_date);
                        row.append(dateCell);

                        var titleCell = $("<td></td>");
                        var titleLink = $("<a></a>").text(event.event_title);
                        titleLink.attr("href", "${pageContext.request.contextPath}/calendar/Update?event_id=" + event.event_id);
                        titleCell.append(titleLink);
                        row.append(titleCell);

                        var descriptionCell = $("<td></td>").text(event.event_description);
                        row.append(descriptionCell);

                        eventTableBody.append(row);
                    }
                },
                error: function(xhr, status, error) {
                    alert("Error fetching data: " + error);
                }
            });
        }
    }

    // 문서 로드가 완료되면 실행
    $(document).ready(function() {
        // 검색 버튼 클릭 시 selectCheck 함수 호출
        $("#search").on("click", function() {
            var selectedMonth = $("#selectMonth").val();
            selectCheck(selectedMonth);
        });
    });
</script>
	
</body>
</html>