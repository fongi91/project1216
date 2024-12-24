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
<form id ="search-form" action="./product_insert.jsp" method="POST">
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
           <h1>제품 추가</h1>      
        </div>
        <hr>
        
        </div>
      


   <div class="create_contain">
   
       <div class="essential_in">
       <h2>필수정보</h2>
       <hr class="hr">
       <div class="box">
       <div class="box1">
       <p class="table_nm">제품코드</p>     
       <input class="input_in" id="item_cd" name="item_cd">
       </div>
       <div class="box1">
       <p class="table_nm">제품명</p>
       <input class="input_in" id="item_nm" name="item_nm">
       </div>
       </div>
       </div>
       
       <div class="detail_in">
       <h2>상세정보</h2>
       <hr class="hr">
       <div class="box">
       <div class="box1">
       <p class="table_nm">규격</p>
       <input class="input_in" id="item_stand" name="item_stand">
       </div>
       <div class="box1">
        <p class="table_nm">단가</p>
       <input class="input_in" id="item_price" name="item_price">
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">외주단가</p>
       <input class="input_in" id="cust_price" name="cust_price">
       </div>
       <div class="box1">
       <p class="table_nm">비고</p>
       <input class="input_in" id="bigo" name="bigo">
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <p class="table_nm">등록자</p>
       <input class="input_in" id="write_id" name="write_id" disabled>  
       </div>
       <div class="box1">
       <p class="table_nm">등록일시</p>
       <input class="input_in" id="write_dt" name="write_dt" disabled>      
       </div>
       </div>
       <br>
       <div class="box">
       <div class="box1">
       <button class="register_button">추가</button>
       </div>
       <div class="box1">
       <button class="register_button">취소</button>
       </div>

       </div>
       </div>
       </div>
       </form>
       
</body>
</html>