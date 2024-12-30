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
</style> 
</head>
<body>
<body>
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

    <div class="content">
       	 <div>
       	    <h1>사용자 추가</h1>      
      	 </div>
         <hr>  
 	</div>
 	
	
 	   
	<form id ="form" method="POST">
		<div class="create_contain">
			<div class="essential_in">
			  	<h2>필수정보(ID / Password)</h2>
			  	<hr>
			  	
			  	<div class = "box">
			  		<div class="box1">
			  			<p class="table_nm">ID</p>
			  			<input class = input_in id="id" name="id"/>
			  		</div>
			  		<div class="box1">
			  			<p class="table_nm">Password</p>
						<input class = input_in id="passwd" name="passwd"/>
			  		</div>	  		
			  	</div>
			</div>
			<br><br><br><br>
			
			
			<div class="detail_in">
				<h2>상세정보</h2>
				<hr>
				<div class="box">
					<div class="box1">
				  		<p class="table_nm">이름</p>
						<input class = input_in id="name" name="name"/>
					</div>
					<div class="box1">	
				  		<p class="table_nm">사번</p>
						<input class = input_in id="sabun" name="sabun"/>
					</div>
				</div>
				<div class="box">	
				  	<div class="box1">
				  		<p class="table_nm">부서</p>
						<input class = input_in id="depart_nm" name="depart_nm"/>
					</div>	
					<div class="box1">
						<p class="table_nm">직급</p>
						<input class = input_in id="jik_nm" name="jik_nm"/>
					</div>
				</div>	
				<div class="box">
					<div class="box1">
						<p class="table_nm">이메일</p>
						<input class = input_in id="email" name="email"/>
					</div>	
					<div class="box1">
						<p class="table_nm">휴대전화번호</p>
						<input class = input_in id="mobile" name="mobile"/>
					</div>
				</div>
				<div class="box">	
					<div class="box1">
						<p class="table_nm">등록자</p>
						<input class = input_in id="write_id" name="write_id" value="admin" disabled/>
					</div>	 
				</div>
			</div>
       <div class="box">
       		<div class="box1">
       			<button id = "product_insert_button" class="register_button">추가</button>
       		</div>
      		<div class="box1">
       			<button id = "product_cancel_button"class="register_button">취소</button>
       		</div>
       </div>
       </div>
       
       <script>
         document.addEventListener("DOMContentLoaded", function(event) {   // 웹 페이지가 로딩되면 실행
         const insertButton = document.getElementById("product_insert_button");  // 버튼 요소 가져오기
         const cancelButton = document.getElementById("product_cancel_button");  // 버튼 요소 가져오기
            
         const insertForm = document.getElementById('form');
         insertButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
           	insertForm.action = "./user_insert.jsp?login_id=<%= login_id %>";  
         	});   
         
        
         const cancelForm = document.getElementById('form');
         cancelButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
         	cancelForm.action = "./user_manage.jsp?login_id=<%= login_id %>";  
         	});       
        });    
        </script>
       
       </form>
          
       
</body>
</html>