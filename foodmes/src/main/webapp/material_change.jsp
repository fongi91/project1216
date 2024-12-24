<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>
<%@ page import="java.sql.Timestamp" %>
<%
   //한글 처리
   request.setCharacterEncoding("UTF-8");

    
    /* getParameter 는 jsp에서 제공하는 메서드로, http 요청에서 파라미터 값을 가져옵니다.
       크롬 주소창을 보면  "?"다음에 "단어1"="단어2" 가 나옵니다.
       단어1은 Parameter의 이름, 단어2는 Parameter의 값입니다.
       getParameter은 Parameter의 값 즉, "앞 페이지에서 단어2를 가져온다"라고 보시면 됩니다. */
   
      
    /* jsp가 getParameter를 사용할 때 자바 코드안에 있는 값을 가져올 수 없어서 HTML 단에서 가져오는데, 
       1. 대표적인 예로 HTML 태그 내의 name값으로 받아올 수 있습니다.
       2. button 클릭이벤트 시 data-id 속성값을 받을 수도 있다고 합니다.
         ex) <button ~~~ data-id="~~~"></button> 
     
       3. request.getParameter("login_id")의 "login_id"는      
       mamage.jsp파일의 a href="user_change.jsp?login_id= " 에서  ?다음에 나오는 log_id와 매칭됩니다.   */
	String matcd = request.getParameter("MATCD");

	
	// input 태그에 초기값으로 기존 정보를 보여주기 위해 null값 변수를 만들었습니다.
	// 이후 코드 작성 중 sql에서 받아온 수정 전의 정보들이 하단의 변수들 안에 저장될 예정입니다.
    String cmatcd = null;
	String cmatnm = null;
	String cstandcall = null;
	String cweightcall = null;
	String cstandbigo = null;
	String ccustcd = null;
	String cinprice = null;	
	String cbigo = null;
	String cWriteid = null;
	String cWritedt = null;
	 
	
	Connection conn = DBManager.getDBConnection();
	String sqlSelect = "SELECT rownum AS ROWNO, MAT_CD, MAT_NM, STAND_CALL, WEIGHT_CALL, STAND_BIGO, CUST_CD, to_char(IN_PRICE ,'FM999,999,999') AS IN_PRICE, "+
	                   "BIGO, WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
            + " FROM MEMATERIAL WHERE MAT_CD = ?";
	//System.out.println("sql: " + sqlSelect);
	
	int rows = 0;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sqlSelect);
		pstmt.setString(1, matcd);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			// null값이였던 변수들은 sql문으로 가져온 각 컬럼에 해당하는 값으로 저장됩니다.
			// 코드를 내리다보면 input 태그 안에 autofocus value 가 있을겁니다. 이 기능을 사용하여 기존값을 받아옵니다. 향후 수정or삭제예정 
			cmatcd = rs.getString("MAT_CD");
			cmatnm = rs.getString("MAT_NM");
			cstandcall = rs.getString("STAND_CALL");
			cweightcall = rs.getString("WEIGHT_CALL");
			cstandbigo = rs.getString("STAND_BIGO");
			ccustcd = rs.getString("CUST_CD");
			cinprice = rs.getString("IN_PRICE");
			cbigo = rs.getString("BIGO");
			cWriteid = rs.getString("WRITE_ID");
			//cuserWritedt = rs.getString("to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS')");
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
       	    <h1>자재 수정/삭제</h1>      
      	 </div>
         <hr>  
 	</div>
 	   
	<form id ="changeForm" method="POST">
		<div class="create_contain">
			<div class="essential_in">
			  	<h2>필수정보</h2>
			  	<hr class="hr">
			  	<div class = "box">
			  		<div class="box1">
			  			<p class="table_nm">자재코드</p>
			  			<input class = "input_in" id="Matcd" name="Matcd" autofocus value="<%= cmatcd  %>"/>
			  		</div>
			  		<div class="box1">
			  			<p class="table_nm">자재명</p>
						<input class = "input_in" id="Matnm" name="Matnm" autofocus value="<%= cmatnm   %>"/>
			  		</div>	  		
				</div>
			</div>
		
			
			
			<div class="detail_in">
				<h2>상세정보</h2>
				<hr class="hr">
					<div class="box">
						<div class="box1">
				  			<p class="table_nm">규격</p>
							<input class = "input_in" id="Standcall" name="Standcall" autofocus value="<%= cstandcall   %>"/>
						</div>
						<div class="box1">	
				  			<p class="table_nm">규격정보</p>
							<input class = "input_in" id="Standbigo" name="Standbigo" autofocus value="<%= cstandbigo   %>"/>
						</div>
					</div>
					<div class="box">	
				  		<div class="box1">
				  			<p class="table_nm">중량</p>
							<input class = "input_in" id="Weightcall" name="Weightcall" autofocus value="<%= cweightcall   %>"/>
						</div>	
						<div class="box1">
							<p class="table_nm">자재처</p>
							<input class = "input_in" id="Custcd" name="Custcd" autofocus value="<%= ccustcd   %>"/>
						</div>
					</div>	
					<div class="box">
						<div class="box1">
							<p class="table_nm">입고단가</p>
							<input class = "input_in" id="Inprice" name="Inprice" autofocus value="<%= cinprice   %>"/>
						</div>	
						<div class="box1">
							<p class="table_nm">비고</p>
							<input class = "input_in" id="Bigo" name="Bigo" autofocus value="<%= cbigo  %>"/>
						</div>
					</div>
					<div class="box">	
						<div class="box1">
							<p class="table_nm">등록자</p>
							<input class = "input_in" id="write_id" name="write_id" autofocus value="<%= cWriteid  %>" disabled/>
						</div>
						<div class="box1">
							<p class="table_nm">등록날짜</p>
							<input class = "input_in" id="write_dt" name="write_dt" autofocus value="<%= cWritedt  %>" disabled/>
						</div>
					</div>	 	 
					<div class="box">
       					<div class="box1">
       						<button class="register_button" id="material_update_button" >수정</button>
       					</div>
      					<div class="box1">
      						<button class="register_button" id="material_delete_button" >삭제</button>
      					</div>
      					<div class="box1">
      						<button class="register_button" id="material_cancle_button" >취소</button>
      					</div>
      				</div>
				</div>
			</div>
    
		<script>
        document.addEventListener("DOMContentLoaded", function(event) {   // 웹 페이지가 로딩되면 실행
            const updateButton = document.getElementById("user_update_button");  // 버튼 요소 가져오기
            const deleteButton = document.getElementById("user_delete_button");  // 버튼 요소 가져오기
          
            
            const updateForm = document.getElementById('changeForm');
            updateButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	updateForm.action = "./material_update.jsp?login_id=<%= matcd %>";  
            	});   
            
           
            const deleteForm = document.getElementById('changeForm');
            deleteButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	deleteForm.action = "./material_delete.jsp?login_id=<%= matcd %>";  
            	});       
        });       
   </script>
  
</form>


</body>
</html>