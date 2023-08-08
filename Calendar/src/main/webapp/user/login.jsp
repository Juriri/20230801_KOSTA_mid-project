<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<h3>로그인</h3>
<form name="L" action="${pageContext.request.contextPath }/LoginController" method="post">
<table>
<tr>
<td>아이디</td>
<td><input type="text" name="id"></td>
</tr>
<tr>
<td>비밀번호</td>
<td><input type="password" name="pwd"></td>
</tr>
<tr>
<td colspan="2"><input type="submit" value="로그인">
<a href="${pageContext.request.contextPath }/user/form.jsp">회원가입</a>
</td>
</tr>
</table>
</body>
</html>