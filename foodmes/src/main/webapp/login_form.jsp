<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>
<%
   //한글 처리
   request.setCharacterEncoding("UTF-8");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사조떡볶이</title>
<link rel="stylesheet" href="./css/style.css">
</head>
<body>
<section>
<div class="container">
<div class ="login_container">
 <form id="login-form" action="./login.jsp" method="POST">
<h1>로그인</h1>
	 <div class="id_password">
	 	<input type="text" name="user_id" id="user_id" autocomplete="off" required  placeholder="id"><label for ="user_id"></label>        

	 </div>
	 <div class="id_password">
		<input type="password" name="user_pwd" id="user_pwd" autocomplete="off" required placeholder="password"><label for = "user_pwd" ></label>
	 </div>

<button id="login-button" style="cursor: pointer;">로그인</button>
</form>
<div class="image-container">
    <div class="title">
    <img src="./images/1.png" class="image1">
    </div>
</div>
</div>
</div>
</section>
</body>
</html>