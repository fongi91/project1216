<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>

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


<%
   //한글 처리
   request.setCharacterEncoding("UTF-8");
   String login_id = request.getParameter("login_id");


	String postCountStr = request.getParameter("numb");
	int postCount = (postCountStr != null) ? Integer.parseInt(postCountStr) : 10; // 기본값 10
	String pageStr = request.getParameter("page");
	int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
	
	// DBManager.getDBConnection() 을 호출하여 데이터베이스 연결을 시도하고, 그 결과를 
	// conn 변수에 저장한다.
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalCount = 0;
    int totalPages = 0;
			
	
	try{
		conn = DBManager.getDBConnection();
        String countSql = "SELECT COUNT(*) FROM MEUSER";
        pstmt = conn.prepareStatement(countSql);
		rs = pstmt.executeQuery();
        if (rs.next()) {
            totalCount = rs.getInt(1);
        }
        
		//전체페이지 수 계산
        totalPages = (int) Math.ceil((double) totalCount / postCount);
		
		// 시작 인덱스 계산(0부터)
        int startIndex = (currentPage - 1) * postCount + 1;
        int endIndex = currentPage * postCount;
		
		
		
	    String sql = "SELECT * FROM ("
	               + "SELECT rownum AS ROWNO, LOGIN_ID, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, MOBILE_NO, "
	               + "WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
	               + "FROM MEUSER "
	               + "WHERE rownum <= ?) "
	               + "WHERE ROWNO >= ?";
	
		pstmt = conn.prepareStatement(sql);
	    pstmt.setInt(1, endIndex);  // rownum을 endIndex까지 설정
	    pstmt.setInt(2, startIndex);  // rownum을 startIndex 이상으로 설정
        rs = pstmt.executeQuery();
%>
    

    <div class="sidebar">
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        <div class="sidebar1">
            <a href="./user_manage.jsp?login_id=<%= login_id %>">사용자관리</a>
            <a href="./product_manage.jsp?login_id=<%= login_id %>">제품기준관리</a>
            <a href="./material_manage.jsp?login_id=<%= login_id %>">자재기준관리</a>
            <a href="#contact">Version</a>
            <div class="logout">
                <p class=loginCheck>현재 로그인: <%= login_id %>님</p>
                <a href="./login_form.jsp">로그아웃</a>
            </div>
        </div>
    </div>
    
    
    <div class="content">
        <div>
            <h1>사용자관리</h1>
            <div class="button-container">
                <%-- 로그인한 사용자가 "admin"일 경우에만 사용자 생성 버튼을 보이게 함 --%>
                <% if ("admin".equals(login_id)) { %>
                    <button id="user_add_button">사용자 생성</button>
                <% } else { %>
                    <p>관리자만 사용자를 생성할 수 있습니다.</p>
                <% } %>
            </div>
        </div>

            
        <hr>
        
        
        <script>
        document.addEventListener("DOMContentLoaded", function() {   // 웹 페이지가 로딩되면 실행
            const button = document.getElementById("user_add_button");  // 버튼 요소 가져오기
            button.addEventListener("click", function () {  // 버튼을 클릭하면 실행
              	window.location.href = './user_add.jsp?login_id=<%= login_id %>';
              	// window.open("./user_add.jsp", "팝업창이름", "width=650, height=500, left=100, top=200");
              	// newRegister();   // 새로운 주제를 등록하는 함수 호출  
            	});
        });      
   		 </script>
        
        
	    <div class="right-side">
	    	<form action="./user_manage.jsp?login_id=<%= login_id %>" method="POST">
			    show
			    <select name="numb" id="numb" onchange="this.form.submit()">
			        <option value="10" <% if ("10".equals(request.getParameter("numb"))) out.print("selected"); %>>10</option>
			        <option value="20" <% if ("20".equals(request.getParameter("numb"))) out.print("selected"); %>>20</option>
			        <option value="30" <% if ("30".equals(request.getParameter("numb"))) out.print("selected"); %>>30</option>
			    </select>
			    entries
			</form>      
	      <!-- ******************** 이부분 추가하시면 됩니다.(각 구역별 select 모두 출력되는 코드에서 수정하시는겁니다.)******************** 
	      form 태그 생성 후 action="./검색결과 출력 할 페이지" method="POST" 
	      input 태그 작성 간 name을 잘 써주세요. 출력페이지에서 받아와야됩니다. -->
	        <form id ="search-form" action="./user_search.jsp?login_id=<%= login_id %>" method="POST">
	        	 <span class="search">
					<input class="searchbox" type="search" id="search" name="search1" placeholder="이름을 입력하세요">
					<button class="search-button"></button>
				</span>
            </form>	        
	    </div>
	</div>
	   
	     
	<div class="table_contain">
    	<table>
    	 	<tr>
				<th>NO</th>
    			<th>ID</th>
    			<th>이름</th>
    			<th>사원번호</th>
    			<th>부서</th>
    			<th>직급</th>
    			<th>mobile</th>
    			<th>등록자</th>
    			<th>등록일시</th>
    		</tr>
    	   <%
                // 데이터 출력
                while (rs.next()) {
            %>

    		<tr>
	    	    <td><%= rs.getInt("ROWNO") %></td>
	    	    
    	    <% 
    	    if(login_id.equals("admin")){ %>
				<td> <a href="user_change.jsp?login_id=<%= login_id %>&user_id=<%= rs.getString("LOGIN_ID") %>"> <%= rs.getString("LOGIN_ID") %> </a> </td>	   
                <% }
            else{ %>
                <td><%= rs.getString("LOGIN_ID") %></td>
                <% } %>
	    	    <!-- LOGIN_ID가 sql문에서 getString으로 가져온건데, 이걸 클릭하면 user_chage.jsp 화면으로 이동. 
	    	          ?부터시작되는 문장을 옆에 붙여줘야 원하는 user에 대한 수정+삭제가 가능합니다.  -->	   
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
          

    
    
    <!-- 페이지 -->
    <div class="pagination">
        <%
            // totalPages 변수가 제대로 선언되고, 값이 계산되었는지 확인 후 출력
            for (int i = 1; i <= totalPages; i++) {
                String activeClass = (i == currentPage) ? "active" : "";
        %>
        <a href="?login_id=<%= login_id %>&page=<%= i %>&numb=<%= postCount %>" class="<%= activeClass %>"><%= i %></a>
        <%
            }
        %>
    </div>
</body>
</html>