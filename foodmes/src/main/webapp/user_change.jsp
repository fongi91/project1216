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
	String loginId = request.getParameter("login_id");

	
	// input 태그에 초기값으로 기존 정보를 보여주기 위해 null값 변수를 만들었습니다.
	// 이후 코드 작성 중 sql에서 받아온 수정 전의 정보들이 하단의 변수들 안에 저장될 예정입니다.
	String cuserId = null;
	String cuserPassword = null;
	String cuserName = null;
	String cuserSabun = null;
	String cuserDepartnm = null;
	String cuserJiknm = null;
	String cuserEmail = null;	
	String cuserMobile = null;
	String cuserWriteid = null;
	String cuserWritedt = null;
	 
	
	Connection conn = DBManager.getDBConnection();
	String sqlSelect = "SELECT rownum AS ROWNO, LOGIN_ID, PASS_WD, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, EMAIL, MOBILE_NO, "
            + " WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
            + " FROM MEUSER WHERE LOGIN_ID = ?";
	//System.out.println("sql: " + sqlSelect);
	
	int rows = 0;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sqlSelect);
		pstmt.setString(1, loginId);
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()){
			// null값이였던 변수들은 sql문으로 가져온 각 컬럼에 해당하는 값으로 저장됩니다.
			// 코드를 내리다보면 input 태그 안에 autofocus value 가 있을겁니다. 이 기능을 사용하여 기존값을 받아옵니다. 향후 수정or삭제예정 
			cuserId = rs.getString("LOGIN_ID");
			cuserPassword = rs.getString("PASS_WD");
			cuserName = rs.getString("LOGIN_NAME");
			cuserSabun = rs.getString("SABUN_ID");
			cuserDepartnm = rs.getString("DEPART_NM");
			cuserJiknm = rs.getString("JIK_NM");
			cuserEmail = rs.getString("EMAIL");
			cuserMobile = rs.getString("MOBILE_NO");
			cuserWriteid = rs.getString("WRITE_ID");
			//cuserWritedt = rs.getString("to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS')");
			cuserWritedt = rs.getString("write_dt");
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
<style>
*{
   box-sizing: border-box;
}
body {
    margin: 0;
    font-family: Arial, sans-serif;
}

.sidebar {
    width: 200px;
    height: 100vh; /* Full height */
   
    background-color: #575757;
    color: white;
    position: fixed; /* Stay fixed on the left */
    top: 0;
    left: 0;
    padding-top: 20px;
}

.sidebar a{
   display: block;
   text-decoration: none;
   color: white;    
}

.sidebar .sidebar1 a {
    display: block;
    color: white;
    text-decoration: none;
    padding: 10px 20px;
    transition: background-color 0.3s;
}

.sidebar .sidebar1 a:hover {
    background-color: #d1740a;
    
}

.content {
    margin-left: 250px; /* Same as the sidebar width */
    padding: 20px;
}

hr{
   width: 100%;
}


.content div {
   display: flex;
    align-items: center;
}          
   
   
   
.create_contain{
       
    padding: 20px;
     margin-left: 250px;      
}


.box{
   background-color: blue;
   /*
   justify-content: space-between;
   display: flex;
   flex-wrap: wrap; */
   height: 100px;
   width: 100%;
   text-align: center;
   margin-top: 20px;
}
.box div{
width: 40%;
}

.register_button{
   margin-right: 20px;
   width: 600px;
   height: 50px;
   background-color: black;
   color: white;
   cursor: pointer;
   border-radius: 10px; 
   }

.table_nm{
   margin: 5px;
   width: 100px;
   text-align: left;
}

.input_in:focus{
   background-color: white;
   border: 0.5px solid black;
}


.input_in{
	
   margin-right: 20px;
   padding-left: 20px;
   width: 100%;
   height: 40px;
   font-size: 20px;
   border-radius: 8px;
   background-color: rgb(228, 236, 247);
   border: none;
}

.input_in:hover {
   border: 3px solid rgb(177, 208, 250);
}

.register_button{
   background-color: black;
   color: white;
   cursor: pointer;
   border-radius: 10px;
   }
   
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
       	    <h1>사용자 수정/삭제</h1>      
      	 </div>
         <hr>  
 	</div>
 	   
	<form id ="changeForm" method="POST">
		<div class="create_contain">
			<div class="essential_in">
			  	<h2>필수정보(ID / Password)</h2>
			  	<hr>
			  	<div class = "box">
			  		<div>
			  			<p class="table_nm">ID</p>
			  			<input class = input_in id="loginid" name="loginid" autofocus value="<%= cuserId %>"/>
			  		</div>
			  		<div>
			  			<p class="table_nm">Password</p>
						<input class = input_in id="passwd" name="passwd" autofocus value="<%= cuserPassword %>"/>
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
						<input class = input_in id="name" name="name" autofocus value="<%= cuserName %>"/>
					</div>
					<div>	
				  		<p class="table_nm">사번</p>
						<input class = input_in id="sabun" name="sabun" autofocus value="<%= cuserSabun %>"/>
					</div>
				</div>
				<div class="box">	
				  	<div>
				  		<p class="table_nm">부서</p>
						<input class = input_in id="depart_nm" name="depart_nm" autofocus value="<%= cuserDepartnm %>"/>
					</div>	
					<div>
						<p class="table_nm">직급</p>
						<input class = input_in id="jik_nm" name="jik_nm" autofocus value="<%= cuserJiknm %>"/>
					</div>
				</div>	
				<div class="box">
					<div>
						<p class="table_nm">이메일</p>
						<input class = input_in id="email" name="email" autofocus value="<%= cuserEmail %>"/>
					</div>	
					<div>
						<p class="table_nm">휴대전화번호</p>
						<input class = input_in id="mobile" name="mobile" autofocus value="<%= cuserMobile %>"/>
					</div>
				</div>
				<div class="box">	
					<div>
						<p class="table_nm">등록자</p>
						<input class = input_in id="write_id" name="write_id" autofocus value="<%= cuserWriteid %>"/>
					</div>
					<div>
						<p class="table_nm">등록날짜</p>
						<input class = input_in id="write_dt" name="write_dt" autofocus value="<%= cuserWritedt %>"/>
					</div>	 	 
				</div>
			</div>
		<button id="user_update_button" class="register_button">수정</button>
		<button id="user_delete_button" class="register_button">삭제</button>
    </div>
    
    
-
		<script>
        document.addEventListener("DOMContentLoaded", function(event) {   // 웹 페이지가 로딩되면 실행
            const updateButton = document.getElementById("user_update_button");  // 버튼 요소 가져오기
            const deleteButton = document.getElementById("user_delete_button");  // 버튼 요소 가져오기
          
            
            const updateForm = document.getElementById('changeForm');
            updateButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	updateForm.action = "./user_update.jsp?login_id=<%= cuserId %>";  
            	});   
            
           
            const deleteForm = document.getElementById('changeForm');
            deleteButton.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	deleteForm.action = "./user_delete.jsp?login_id=<%= cuserId %>";  
            	});       
        });       
   </script>
  
</form>


</body>
</html>