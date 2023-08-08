<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="javax.servlet.http.HttpSession" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="${pageContext.request.contextPath }/EditController" method="post">
	<table botder="1">
		
		<tr>
		<td>아이디</td>
		<td><input type="text" name="id" value="${u.id }" readonly></td>
		</tr>
		
		<tr>
		<td>비밀번호</td>
		<td><input type="password" name="pwd" value="${u.pwd }"></td>
		</tr>
		
		<tr>
		<td>이름</td>
		<td><input type="text" name="name" value="${u.name }" readonly></td>
		</tr>
		
		<tr>
		<td>이메일</td>
		<td><input type="text" name="email" value="${u.email }"></td>
		</tr>
		
		<tr>
		<td colspan="2"><input type="submit" value="수정"></td>
		</tr>
	
	</table>
</form>

</body>
</html>