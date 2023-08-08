<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${sessionScope.id }님 로그인<br>
<a href = "${pageContext.request.contextPath}/SearchController">내 정보 수정</a>
<a href = "${pageContext.request.contextPath}/LogoutController">로그아웃</a>
<a href = "${pageContext.request.contextPath}/calendar/Cal">달력보기</a>
<a href = "${pageContext.request.contextPath}/CheckController">일정 확인하기</a>
</body>
</html>