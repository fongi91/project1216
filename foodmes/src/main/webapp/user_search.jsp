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
        	<h1>사용자관리</h1>
        	<div class = button>
        		<button>사용자생성</button>
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
	      
	      
	      <form id ="search-form" action="./user_search.jsp" method="POST">
	      	<span class="search">
				<input class="searchbox" type="search" id="search" name="search1" placeholder="이름을 입력하세요">
				<button class="search-button"></button>
			</span>
          </form>	
                       
	    </div>
	</div>
	   

	<div class = "table_contain">
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
    	    // **** String 변수 하나 만들어줘서 form 태그에서 가져온 값을 넣어줍니다. ******
    		// **** name에서 가져온 이름을 getParameter안에 넣어줍니다.ex) "search1" ****
    		
  		%>

  		<%	
  			String search = request.getParameter("search1");
  			if(search == null){
  				search = "";
  			}
    		Connection conn = DBManager.getDBConnection();
  			// 각 구역별로 컬럼이 다 다를겁니다. 이부분 수정해주세요
  			// 예를들어 저는 이름을 검색할 것이기때문에 WHERE LOGIN_NAME = ? 로 만들어주었습니다.
	    	String sql = "SELECT rownum AS ROWNO, LOGIN_ID, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, MOBILE_NO, "
	    				+ " WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
	    				+ " FROM MEUSER WHERE LOGIN_NAME like ?";
    		
	    	try{ 		
	    		PreparedStatement pstmt = conn.prepareStatement(sql);    		
	    		// 위에서 선언한 변수를(저는 search) 1, 옆에 넣어줍니다. 
    			pstmt.setString(1, "%"+search+"%");			
    			ResultSet rs = pstmt.executeQuery();
    			while(rs.next()){
    					%>			
    			    	<tr>
    			    	    <td><%= rs.getInt("ROWNO") %></td>
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