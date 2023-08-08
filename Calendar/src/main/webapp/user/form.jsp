<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<h3>회원가입</h3>
<form name="L" action="${pageContext.request.contextPath }/JoinController" method="post">
<table border="1">
<tr>
<td>아이디</td>
<td><input type="text" name="id"></td>
</tr>
<tr>
<td>비밀번호</td>
<td><input type="password" name="pwd"></td>
</tr>
<tr>
<td>이름</td>
<td><input type="text" name="name"></td>
</tr>
<tr>
<td>이메일</td>
<td><input type="text" name="email"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="가입">
<a href="${pageContext.request.contextPath}/calendar/Cal">돌아가기</a>
</td>
</tr>
</body>
</html>