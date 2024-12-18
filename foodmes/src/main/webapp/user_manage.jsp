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
        table {
        	margin-left: 300px;
        	border: solid white;
        	width: 70%;
        	border-collapse:collapse;
        }
        th {
       		 text-align: left;
             padding: 5px;
             color:white;
        	 background-color: #3a08c2;         	
        }
        td {
        	border-bottom: solid lightgrey;
        	text-align: left;
        	padding: 5px;    
        }
        .right-side{
        	display: flex;
        	justify-content: space-between;
        }
    </style> 
</head>
<body>

    <div class="sidebar">
        <h3><a href="./main.jsp">사조떡볶이 제조시스템</a></h3>
        <div class = "sidebar1">
        	<a href="./user_manage.jsp">사용자관리</a>
        	<a href="#about">제품기준관리</a>
        	<a href="#services">자재기준관리</a>
        	<a href="#contact">Version</a>
        </div>
    </div>

    <div class="content">
        <h1>사용자관리</h1>
        <hr>
	    <div class="right-side">
	      <form action="#">
	        show
	        <select name="numb" id="numb">
	            <option value ="25" seleted>25</option>
	            <option value ="50">50</option>
	            <option value ="100">100</option>
	        </select>
	        entries
	      </form>
	      <span>
	           <input class="searchbox" type="search" id="search" placeholder="이름을 입력하세요"'>
	           <button>검색</button>
	      </span>
	    </div>
	</div>
	   


	<div>
    	<table>
    	 	<tr>
				<th>NO</th>
    			<th>ID</th>
    			<th>이름</th>
    			<th>사원번호</th>
    			<th>부서번호</th>
    			<th>직급</th>
    			<th>mobile</th>
    			 <th>등록자</th>
    			 <th>등록일시</th>

  
    			
    		</tr>
    	
    	<%
    	
    		Connection conn = DBManager.getDBConnection();
    		String sql = "SELECT rownum AS ROWNO, LOGIN_ID, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, MOBILE_NO, "
    				+ " WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT FROM MEUSER ORDER BY LOGIN_ID";
    		
    		try{
    			PreparedStatement pstmt = conn.prepareStatement(sql);
    			
    			ResultSet rs = pstmt.executeQuery();
    			while(rs.next()){
    	%>
    	<tr>
    	    <td><%= rs.getString("ROWNO") %></td>
    		<td><%= rs.getString("LOGIN_ID") %></td>
    		<td><%= rs.getString("LOGIN_NAME") %></td>
    		<td><%= rs.getString("SABUN_ID") %></td>
    		<td><%= rs.getString("DEPART_NM") %></td>
    		<td><%= rs.getString("JIK_NM") %></td>
    		<td><%= rs.getString("MOBILE_NO") %></td>
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