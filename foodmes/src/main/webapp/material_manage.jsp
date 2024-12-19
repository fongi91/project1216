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
<link rel="stylesheet" href="./css/main_style.css"> 
<style>
	.in_price{
		text-align: right;
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
           <h1>자재관리</h1>
           <div class = button>
              <button>자재등록</button>
           </div>    
        </div>
        <hr>
       <div class="right-side">
         <form action="#">
           show
           <select name="numb" id="numb">
               <option value ="25" selected>25</option>
               <option value ="50">50</option>
               <option value ="100">100</option>
           </select>
           entries
         </form>
         

         <span class = "search">
                    
              <form id ="search-form" action="./material_search.jsp" method="GET">
                <span class="search">
               	 <input class="searchbox" type="search" id="search" name="search1" placeholder="자재코드를 입력하세요">
                 <button class="search-button" type="submit"></button>
           	   </span>
            </form>   
           
        
       </div>
   </div>
      

   <div class="table_contain">
       <table>
           <tr>
                <th>No</th>
				<th>자재코드</th>
    			<th>자재명</th>
    			<th>규격</th>
    			<th>중량</th>
    			<th>규격정보</th>
    			<th>자재처</th>
    			<th>입고단가</th>
    			<th>비고</th>
    			<th>등록자</th>
    			<th>등록일시</th> 
             
          </tr>
       
       <%
          // DBManager.getDBConnection() 을 호출하여 데이터베이스 연결을 시도하고, 그 결과를 
          // conn 변수에 저장한다.
          Connection conn = DBManager.getDBConnection();
          String sql = "SELECT rownum AS ROWNO, MAT_CD, MAT_NM, STAND_CALL," +
  	    		" WEIGHT_CALL, STAND_BIGO, CUST_CD, to_char(in_price,'FM999,999,999') AS IN_PRICE , " +
  	    		" BIGO,WRITE_ID,WRITE_DT "+
  				 " FROM MEMATERIAL";
          
          try{
             PreparedStatement pstmt = conn.prepareStatement(sql);
             
             ResultSet rs = pstmt.executeQuery();
             while(rs.next()){
       %>
       <tr>
            <td><%= rs.getString("ROWNO") %></td>
    		<td><%= rs.getString("MAT_CD") %></td>
    		<td><%= rs.getString("MAT_NM") %></td>
    		<td><%= rs.getString("STAND_CALL") %></td>
    		<td><%= rs.getString("WEIGHT_CALL") %></td>
    		<td><%= rs.getString("STAND_BIGO") %></td>
    		<td><%= rs.getString("CUST_CD") %></td>
    		<td class=in_price><%= rs.getString("IN_PRICE") %></td>
    		<td><%= rs.getString("BIGO") %></td> 
			<td><%= rs.getString("WRITE_ID") %></td>
			<td><%= rs.getString("WRITE_DT") %></td>
       </tr>
       <%
             }
             //자원정리
          DBManager.dbClose(conn, pstmt, rs);
          } catch(SQLException se) {
             se.printStackTrace();
             System.err.println("테이블 조회 에러");
          }
           %>
       </table>
    </div>

     
</body>
</html>