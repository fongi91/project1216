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
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>사조떡볶이</title>
<link rel="stylesheet" href="./css/popup_style.css">  
</head>
<body>
	<form id ="search-form" action="./user_insert.jsp" method="POST">
	<div> 	
			<input id="id" name="id" placeholder="아이디"/>
			<input id="passwd" name="passwd" placeholder="비밀번호"/>
			<input id="name" name="name" placeholder="이름"/>

			<input id="sabun" name="sabun" placeholder="사번"/>
			<input id="depart_nm" name="depart_nm" placeholder="부서"/> 
			<input id="jik_nm" name="jik_nm" placeholder="직급"/>

			<input id="email" name="email" placeholder="이메일"/>
			<input id="mobile" name="mobile" placeholder="휴대전화번호"/>
			<input id="write_id" name="write_id" placeholder="등록자"/>
	
    </div>
	<div>
		<button>등록</button>
	</div>
	</form>

</body>
</html>