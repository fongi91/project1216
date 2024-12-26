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
   String itemCd = request.getParameter("item_cd");
	/*
	String item_nm = request.getParameter("item_nm");
	String item_stand = request.getParameter("item_stand");	
	String item_price = request.getParameter("item_price");
	Integer item_priceNum = Integer.parseInt(item_price);
	String cust_price = request.getParameter("cust_price");
	Integer cust_priceNum = Integer.parseInt(cust_price);
	String bigo = request.getParameter("bigo");
	String write_id = request.getParameter("write_id");
	String write_dt = request.getParameter("write_dt");
	
	*/
	String citemCd = null;
	String citemNm = null;
	String citemStand = null;
	String citemPrice = null;
	String ccustPrice = null;
	String cbigo = null;
	String cWriteid = null;
	String cWritedt = null;
	 
	
	Connection conn = DBManager.getDBConnection();
	String sql = " SELECT rownum AS ROWNO, ITEM_CD, ITEM_NM, ITEM_STAND, "
	+ " to_char(ITEM_PRICE,'FM999,999,999') AS ITEM_PRICE, "
	+ " to_char(CUST_PRICE,'FM999,999,999') AS CUST_PRICE, "
	+ " BIGO, WRITE_ID, "
	+ " to_char(WRITE_DT, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
	+ " FROM MEITEM WHERE ITEM_CD = ?";
	
	int rows = 0;
	
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, itemCd);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()){
		citemCd = rs.getString("ITEM_CD");
		citemNm = rs.getString("ITEM_NM");
		citemStand = rs.getString("ITEM_STAND");
		citemPrice = rs.getString("ITEM_PRICE");
		ccustPrice = rs.getString("CUST_PRICE");
		cbigo = rs.getString("BIGO");
		cWriteid = rs.getString("WRITE_ID");
		cWritedt = rs.getString("WRITE_DT");
		
		}
		rows = pstmt.executeUpdate();
		DBManager.dbClose(conn, null, null);
	} catch(Exception e) {
		e.printStackTrace();
	}


%>     
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>사조떡볶이</title>
<link rel="stylesheet" href="./css/crud_style.css">
</head>
<body>
    <div class="sidebar">
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        <div class = "sidebar1">
        	<a href="./user_manage.jsp?login_id=<%= login_id %>">사용자관리</a>
        	<a href="./product_manage.jsp?login_id=<%= login_id %>">제품기준관리</a>
        	<a href="./material_manage.jsp?login_id=<%= login_id %>">자재기준관리</a>
        	<a href="#contact">Version</a>
        </div>
    </div>

    <div class="content">
    	<div>
           <h1>제품 수정/삭제</h1>      
      	</div>
        <hr>      
    </div>
  
  	<form id ="changeForm" method="POST">
  		<div class="create_contain">
  			<div class="essential_in">
       			<h2>필수정보</h2>
       			<hr class="hr">
       			<div class="box">
       				<div class="box1">
       					<p class="table_nm">제품코드</p>     
       					<input class="input_in" id="item_cd" name="item_cd" autofocus value="<%= citemCd  %>">
       				</div>
       				<div class="box1">
       					<p class="table_nm">제품명</p>
       					<input class="input_in" id="item_nm" name="item_nm" autofocus value="<%= citemNm %>">
       				</div>
       			</div>
       		</div>
       
       
       
       
       <div class="detail_in">
       		<h2>상세정보</h2>
       		<hr class="hr">
       			<div class="box">
       				<div class="box1">
       					<p class="table_nm">규격</p>
       					<input class="input_in" id="item_stand" name="item_stand" autofocus value="<%= citemStand %>">
       				</div>
       				<div class="box1">
        				<p class="table_nm">단가</p>
       					<input class="input_in" id="item_price" name="item_price" autofocus value="<%= citemPrice %>">
       				</div>
      		 	</div>
       
       			<div class="box">
       				<div class="box1">
       					<p class="table_nm">외주단가</p>
       					<input class="input_in" id="cust_price" name="cust_price" autofocus value="<%= ccustPrice %>">
       				</div>
      				 <div class="box1">
       					<p class="table_nm">비고</p>
       					<input class="input_in" id="bigo" name="bigo" autofocus value="<%= cbigo %>">
       				</div>
       			</div>
       
       			<div class="box">
       				<div class="box1">
       					<p class="table_nm">등록자</p>
       					<input class="input_in" id="write_id" name="write_id" autofocus value="<%= cWriteid %>" disabled>  
       				</div>
       				<div class="box1">
       					<p class="table_nm">등록일시</p>
       					<input class="input_in" id="write_dt" name="write_dt" autofocus value="<%= cWritedt %>" disabled>      
       				</div>
       			</div>
       
      			<div class="box">
       				<div class="box1">
       					<button class="register_button" id="product_update_button" >수정</button>
       				</div>
      				<div class="box1">
      					<button class="register_button" id="product_delete_button" >삭제</button>
      				</div>
      				<div class="box1">
      					<button class="register_button" id="product_cancel_button" >취소</button>
      				</div>
      			</div>
       		</div>
     	</div>
    
    <script>
        document.addEventListener("DOMContentLoaded", function(event) {   // 웹 페이지가 로딩되면 실행
            const updateButton = document.getElementById("product_update_button");  // 버튼 요소 가져오기
            const deleteButton = document.getElementById("product_delete_button");  // 버튼 요소 가져오기
            const cancelButton = document.getElementById("product_cancel_button");
          
            
            const updateForm = document.getElementById('changeForm');
            updateButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	updateForm.action = "./product_update.jsp?login_id=<%= login_id %>";   
            	});   
            
           
            const deleteForm = document.getElementById('changeForm');
            deleteButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	deleteForm.action = "./product_delete.jsp?login_id=<%= login_id %>";  
            	});
            
            const cancelForm = document.getElementById('changeForm');
            cancelButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	cancelForm.action = "./product_manage.jsp?login_id=<%= login_id %>";  
            	});
            
            
            
            
            
        });       
   </script>
</form>
</body>
</html>