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
</head>
<body>
<body>

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
       	    <h1>사용자 추가</h1>      
      	 </div>
         <hr>  
 	</div>
 	
	
 	   
	<form id ="search-form" action="./user_insert.jsp" method="POST">
		<div class="create_contain">
			<div class="essential_in">
			  	<h2>필수정보(ID / Password)</h2>
			  	<hr>
			  	<!-- wrap을 걸어서 화면이 커지면 옆으로, 작아지면 밑으로 가지도록 구성 -->
			  	<div class = "box">
			  		<div>
			  			<p class="table_nm">ID</p>
			  			<input class = input_in id="id" name="id" placeholder="아이디"/>
			  		</div>
			  		<div>
			  			<p class="table_nm">Password</p>
						<input class = input_in id="passwd" name="passwd" placeholder="비밀번호"/>
			  		</div>	  		
			  	</div>
			</div>
			<br><br><br><br>
			
			
			<div class="detail_in">
				<h2>상세정보</h2>
				<hr>
				<div class="box">
					<div>
				  		<p class="table_nm">이름</p>
						<input class = input_in id="name" name="name" placeholder="이름"/>
					</div>
					<div>	
				  		<p class="table_nm">사번</p>
						<input class = input_in id="sabun" name="sabun" placeholder="사번"/>
					</div>
				</div>
				<div class="box">	
				  	<div>
				  		<p class="table_nm">부서</p>
						<input class = input_in id="depart_nm" name="depart_nm" placeholder="부서"/>
					</div>	
					<div>
						<p class="table_nm">직급</p>
						<input class = input_in id="jik_nm" name="jik_nm" placeholder="직급"/>
					</div>
				</div>	
				<div class="box">
					<div>
						<p class="table_nm">이메일</p>
						<input class = input_in id="email" name="email" placeholder="이메일"/>
					</div>	
					<div>
						<p class="table_nm">휴대전화번호</p>
						<input class = input_in id="mobile" name="mobile" placeholder="휴대전화번호"/>
					</div>
				</div>
				<div class="box">	
					<div>
						<p class="table_nm">등록자</p>
						<input class = input_in id="write_id" name="write_id" placeholder="등록자"/>
					</div>	 
				</div>
			</div>
		<button class="register_button">등록</button>
    </div>

</form>

</body>
</html>