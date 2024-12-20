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
	String cWriteId = null;
	String cWriteDt = null;
	 
	
	Connection conn = DBManager.getDBConnection();
	String sql = " SELECT rownum AS ROWNO, ITEM_CD, ITEM_NM, ITEM_STAND, "+
			" to_char(item_price,'FM999,999,999') AS item_price, "+
			 " to_char(cust_price,'FM999,999,999') AS cust_price, "+
			" BIGO, WRITE_ID as WRITE_ID ,to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT"+
			" FROM MEITEM WHERE ITEM_CD = ?";
	
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
		cWriteId = rs.getString("WRITE_ID");
		cWriteDt = rs.getString("WRITE_DT");
		
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
   justify-content: space-between;
    align-items: center;
}          
   
   
   
.create_contain{
       
    padding: 20px;
     margin-left: 250px;
       
}


.box{
   display: flex;
   justify-content: center;
   margin-top :20px;
}

.box1{
   margin-right:20px;
}

.register_button {
   width: 450px;
   height: 50px;

}

.table_nm{
   
   
   margin: 5px;
   width: 100px;

}


.input_in:focus{

   background-color: white;
   border: 0.5px solid black;
}


.input_in{
   padding-left: 20px;
   width: 450px;
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
   cursor: cursor;

}   


#write_dt {

   background-color: rgb(197, 198, 216);
   cursor: cursor;

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
           <h1>제품 수정/삭제</h1>      
       </div>
        <hr>      
      </div>
  
  	<form id ="form1" action="./product_update.jsp" method="POST">
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
       <br>
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
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">등록자</p>
       <input class="input_in" id="write_id" name="write_id" autofocus value="<%= cWriteId %>">  
       </div>
       <div class="box1">
       <p class="table_nm">등록일시</p>
       <input class="input_in" id="write_dt" name="write_dt" autofocus value="<%= cWriteDt %>">      
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <button class="crud_button" id="update_button" >수정</button>
       </div>
       <div class="box1">
       <button class="crud_button" id="delete_button" >삭제</button>
       </div>
       
       </div>
       </div>
       </div>
    
       </form>
</body>
</html>