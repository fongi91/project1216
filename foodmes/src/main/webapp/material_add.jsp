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
   String login_id = request.getParameter("login_id");

%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>사조떡볶이</title>
<link rel="stylesheet" href="./css/crud_style.css"> 
<style>
		.logout {
            margin-top: 700px;
 		}
 
		.loginCheck {
   		padding-left:20px;
		}
</style> 
</head>
<body>
<form id ="form" method="POST">
    <div class="sidebar">
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        
    <div class="sidebar">
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        <div class="sidebar1">
            <a href="./user_manage.jsp?login_id=<%= login_id %>">사용자관리</a>
            <a href="./product_manage.jsp?login_id=<%= login_id %>">제품기준관리</a>
            <a href="./material_manage.jsp?login_id=<%= login_id %>">자재기준관리</a>
            <a href="#contact">Version</a>
            <div class="logout">
                <p class=loginCheck>현재 로그인: <%= login_id %>님</p>
                <a href="./login_form.jsp">로그아웃</a>
            </div>
        </div>
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
       
       		<div class="box">
       			<div class="box1">
       				<p class="table_nm">등록자</p>
       				<input class="input_in" id="write_id" name="WRITE_ID">
       			</div>
       			<div class="box1">
      				<p class="table_nm">등록일시</p>
       				<input class="input_in" id="write_dt" name="write_dt" disabled>      
       			</div>
       		</div>
       
       	</div>
       	<div class="box">
       		<div class="box1">
       			<button id = "material_insert_button" class="register_button">추가</button>
       		</div>
      		<div class="box1">
       			<button id = "material_cancel_button"class="register_button">취소</button>
       		</div>
       </div>
    </div>
    <script>
     	document.addEventListener("DOMContentLoaded", function(event) {   // 웹 페이지가 로딩되면 실행
     		const insertButton = document.getElementById("material_insert_button");  // 버튼 요소 가져오기
     		const cancelButton = document.getElementById("material_cancel_button");  // 버튼 요소 가져오기
        
     		const insertForm = document.getElementById('form');
     		insertButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
       			insertForm.action = "./material_insert.jsp?login_id=<%= login_id %>";  
     		});   
     
    
     		const cancelForm = document.getElementById('form');
     		cancelButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
	   			cancelForm.action = "./material_manage.jsp?login_id=<%= login_id %>";  
     		});       
    	}); 
     	
     	

     	
    </script>    
    
    
    
    
</form>
</body>
</html>