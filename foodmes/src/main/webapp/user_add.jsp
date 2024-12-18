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
    <title>Left Sidebar Menu</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .sidebar {
            width: 200px;
            height: 100vh; /* Full height */
            background-color: #3a08c2 ;
            color: white;
            position: fixed; /* Stay fixed on the left */
            top: 0;
            left: 0;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }
    
        .sidebar a:hover {
            background-color: #575757;
        }

        .content {
            margin-left: 250px; /* Same as the sidebar width */
            padding: 20px;
        }
        .div1{
        	display: flex;
        	justify-content: space-between;
        	margin: 10px 0 10px 0;
        	padding: 10px 0; 	
        }
        .div1 p{
        	margin: 10px 0 10px 0;
        }
        .div1 button{
        	background-color: black;
        	color: white;
        	font-weight: bold;
        	cursor: pointer;
        }
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
    </style>
</head>
<body>

    <div class="sidebar">
        <h3>사조떡볶이 제조시스템</h3>
        <a href="./user_manage.jsp">사용자관리</a>
        <a href="#about">제품기준관리</a>
        <a href="#services">자재기준관리</a>
        <a href="#contact">Version</a>
    </div>

    <div class="content">
        <h1>사용자관리</h1>
        <hr>
        <div class="div1" >
        	<p> ※사용자 수정을 원하시는 분은 관리자에게 문의하시기 바랍니다. </p>
        	<button href="#insert">사용자추가</button>
    	</div>
    </div>
    

    	<table>
    	 	<tr>
    			<th>ID</th>
    			<th>사원번호</th>
    			<th>부서번호</th>
    			<th>직급</th>
    			<th>mobile</th>
    		</tr>
    	
    	<%
    	
    		Connection conn = DBManager.getDBConnection();
    		String sql = "SELECT LOGIN_ID, SABUN_ID, DEPART_NM, JIK_NM, MOBILE_NO "
    				+ " FROM MEUSER ORDER BY SABUN_ID";
    		
    		try{
    			PreparedStatement pstmt = conn.prepareStatement(sql);
    			
    			ResultSet rs = pstmt.executeQuery();
    			while(rs.next()){
    	%>
    	<tr>
    		<td><%= rs.getString("LOGIN_ID") %></td>
    		<td><%= rs.getString("SABUN_ID") %></td>
    		<td><%= rs.getString("DEPART_NM") %></td>
    		<td><%= rs.getString("JIK_NM") %></td>
    		<td><%= rs.getString("MOBILE_NO") %></td>
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