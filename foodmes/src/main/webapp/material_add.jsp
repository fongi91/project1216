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
<link rel="stylesheet" href="./css/insert_style.css">  
<style>
#write_id {

   background-color: rgb(197, 198, 216);
   cursor: not-allowed;
}   

#write_dt {
   background-color: rgb(197, 198, 216);
   cursor: not-allowed;
}

       
</style> 
</head>
<body>
<form id ="search-form" action="./material_insert.jsp" method="POST">
    <div class="sidebar">
        <h3><a href="./main.jsp">사조떡볶이 제조시스템</a></h3>
        <div class = "sidebar1">
           <a href="./user_manage.jsp">사용자관리</a>
           <a href="./product_manage.jsp">제품기준관리</a>
           <a href="./material_manage.jsp">자재기준관리</a>
           <a href="#contact">Version</a>
        </div>
    </div>

    <div class="content">
       <div>
           <h1>자재기준관리</h1>      
        </div>
        <hr>
        
        </div>
      


   <div class="create_contain">
   
       <div class="essential_in">
       	<h2>필수정보</h2>
       	<hr class="hr">
       	<div class="box">
       		<div class="box1">
       			<p class="table_nm">자재코드</p>     
       			<input class="input_in" id="MAT_CD" name="MAT_CD">
       		</div>
       	<div class="box1">
       		<p class="table_nm">자재명</p>
       		<input class="input_in" id="MAT_NM" name="MAT_NM">
       	</div>
       </div>
      </div>
       
       <div class="detail_in">
       <h2>상세정보</h2>
       <hr class="hr">
       <div class="box">
       <div class="box1">
       <p class="table_nm">규격</p>
       <input class="input_in" id="STAND_CALL" name="STAND_CALL">
       </div>
       <div class="box1">
        <p class="table_nm">규격정보</p>
       <input class="input_in" id="STAND_BIGO" name="STAND_BIGO">
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">중량</p>
       <input class="input_in" id="WEIGHT_CALL" name="WEIGHT_CALL">
       </div>
       <div class="box1">
       <p class="table_nm">자재처</p>
       <input class="input_in" id="CUST_CD" name="CUST_CD">
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">입고단가</p>
       <input class="input_in" id="IN_PRICE" name="IN_PRICE">
       </div>
       <div class="box1">
       <p class="table_nm">비고</p>
       <input class="input_in" id="BIGO" name="BIGO">
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">등록자</p>
       <input class="input_in" id="WRITE_ID" name="WRITE_ID" disabled>
       
       
      <p class="table_nm">등록일시</p>
       <input class="input_in" id="WRITE_DT" name="WRITE_DT" disabled>      
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <button class="register_button">저장</button>
       </div>
       <div class="box1">
       <button class="register_button">닫기</button>
       </div>
       </div>
       </div>
       </form>
</body>
</html>