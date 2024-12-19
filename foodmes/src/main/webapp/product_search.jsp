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
    	    
        .item_price{
        	text-align: right;
        }
        
        .cust_price{
        text-align: right;
        }
   
		.create-button{
		border-radius: 5px;
  		width: 50px;
  		height: 30px;
  		cursor: pointer;	
  		background-color: black;
  		color: white;
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
        	<h1>제품기준관리</h1>
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
	      
	     <span class="search">
	     
          <form id="search-form" action="./product_search.jsp" method="POST">
          <span class="search">
     	     <input class="searchbox" type="search" id="search" name="search1" placeholder="제품명을 입력하세요">
     	     <button class="search-button" type="submit"></button>
     	     </span>
          </form>   
          
        
	    </div>
	</div>
	   


	<div class="table_contain">
    	<table>
    	 	<tr>
				<th>NO</th>
    			<th>제품코드</th>
    			<th>제품명</th>
    			<th>규격</th>
    			<th>단가</th>
    			<th>외주단가</th>
    			 <th>비고</th>
    			 <th>등록자</th>
    			 <th>등록일시</th>	
    		</tr>
    	
    	<%
    	
    	    String search = request.getParameter("search1");
    	   	if(search==null){
    	   		
    	   		search="";
    	   	}
    		
    	   
    	   
    	
    		Connection conn = DBManager.getDBConnection();
    		String sql = " SELECT rownum AS ROWNO, ITEM_CD, ITEM_NM, ITEM_STAND, "+
    				" to_char(item_price,'FM999,999,999') AS item_price, "+
    				 " to_char(cust_price,'FM999,999,999') AS cust_price, "+
    				" BIGO, WRITE_ID as WRITE_ID ,to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT"+
    				" FROM MEITEM WHERE ITEM_NM LIKE ?";
    		
    		try{
    			PreparedStatement pstmt = conn.prepareStatement(sql);
    			pstmt.setString(1, "%"+search+"%");
				
    			
    			
    			ResultSet rs = pstmt.executeQuery();
    			while(rs.next()){
    	%>
    	<tr>
    	    <td><%= rs.getString("ROWNO") %></td>
    		<td><a href=""><%= rs.getString("ITEM_CD") %></a></td>
    		<td><%= rs.getString("ITEM_NM") %></td>
    		<td><%= rs.getString("ITEM_STAND") %></td>    		
    		<td class="item_price"><%= rs.getString("ITEM_PRICE") %></a></td>
    		<td class="cust_price"><%= rs.getString("CUST_PRICE") %></a></td>
    		<td><%= rs.getString("BIGO") %></td>
    		<td><%= rs.getString("WRITE_ID") == null ? "" : rs.getString("WRITE_ID") %></td>
    		<td><%= rs.getString("WRITE_DT") == null ? "" : rs.getString("WRITE_DT") %></td>

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
	</div>
	 
     
</body>
</html>