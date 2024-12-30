<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, java.sql.ResultSet" %>
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
    // 한글 처리
    request.setCharacterEncoding("UTF-8");
    String login_id = request.getParameter("login_id");

    // 페이지 크기와 현재 페이지 번호 받기
    String postCountStr = request.getParameter("numb");
    // postCount 변수는 페이지당 표시할 데이터의 개수를 가져오며, 기본값은 10으로 설정합니다.
    int postCount = (postCountStr != null) ? Integer.parseInt(postCountStr) : 10; // 기본값 10
    String pageStr = request.getParameter("page");
    // currentPage 변수는 현재 페이지 번호를 가져오며, 기본값은 1입니다. (화면 밑부분 네모칸안에 1 2 3 얘네들입니다.)
    int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;
    System.out.println("currentPage= "+currentPage);

    // search 변수는 사용자가 입력한 검색어를 가져옵니다.(manage.jsp에서 input 태그 내 name이 search1인걸 받아왔습니다.)
    String search = request.getParameter("search1");
    if (search == null) {
        search = "";  // 기본값 빈 문자열
    }

    // DB 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalCount = 0;
    int totalPages = 0;

    try {
    	// DBManager.getDBConnection() 메서드를 호출하여 데이터베이스와 연결합니다.
        conn = DBManager.getDBConnection();

        // 1. 총 데이터 개수 계산 : 검색어에 맞는 LOGIN_NAME(사용자이름)을 필터링하여 MEUSER 테이블에서 데이터의 개수를 셉니다.
        String countSql = "SELECT COUNT(*) FROM MEUSER WHERE LOGIN_NAME LIKE ?";
        pstmt = conn.prepareStatement(countSql);
        pstmt.setString(1, "%" + search + "%");
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalCount = rs.getInt(1);
            System.out.println(totalCount);
        }

        // 2. 전체 페이지 수 계산 : 전체 데이터 개수를 기준으로 페이지의 수를 계산합니다.
        // ex. 이름에 "아" 가 붙는 사람을 검색하면, 3명이 나열되는데, totalCount는 3이고, 
        // postCount 기본값10이므로 나눈 후 실수값을 올림하여 가장 가까운 정수로 반환합니다. 즉 totalPages = 1입니다. 
        totalPages = (int) Math.ceil((double) totalCount / postCount);

        
        // 3. 시작 인덱스와 끝 인덱스 계산. startIndex는 1이고, endIndex는 postCount값을 어떻게하느냐에따라 달라집니다.
        // ex. 30 entries로 두면, startIndex는 1, endIndex는 30입니다. 
        int startIndex = (currentPage - 1) * postCount + 1;
        int endIndex = currentPage * postCount;
        System.out.println("currentPage = "+currentPage);
        System.out.println("startIndex = "+startIndex);
        System.out.println("endIndex = " +endIndex);
        

        // 4. 실제 데이터 가져오기 쿼리 (검색어에 맞춰서 필터링)
        //startIndex와 endIndex까지 검색한 결과 목록이 나올 수 있도록 sql쿼리문과 setInt를 설정하였습니다.
        String sql = "SELECT * FROM ("
                   + "SELECT rownum AS ROWNO, LOGIN_ID, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, MOBILE_NO, "
                   + "WRITE_ID, to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
                   + "FROM MEUSER "
                   + "WHERE LOGIN_NAME LIKE ?) "
                   + "WHERE ROWNO BETWEEN ? AND ?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + search + "%");
        pstmt.setInt(2, startIndex);
        pstmt.setInt(3, endIndex);
        //쿼리문 실행 후 결과 집합을 ResultSet 객체인 rs로 받습니다.
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
        <div class="header">
            <h1>사용자관리</h1>
            <%-- 로그인한 사용자가 "admin"일 경우에만 사용자 생성 버튼을 보이게 함 --%>
            <% if ("admin".equals(login_id)) { %>
                <button id="user_add_button" class="btn-user-add">사용자 생성</button>
            <% } else { %>
                <p>관리자만 사용자를 생성할 수 있습니다.</p>
            <% } %>
        </div>
        <hr>
        <script>
        document.addEventListener("DOMContentLoaded", function() {   // 웹 페이지가 로딩되면 실행
            const button = document.getElementById("user_add_button");  // 버튼 요소 가져오기
            button.addEventListener("click", function () {  // 버튼을 클릭하면 실행
            	});
        });      
    	</script>
        
        
        <div class="right-side">
        	<!-- 왜 POST? : 사용자는 드롭다운을 통해 numb 값을 선택하고 이를 서버에 전달하려고 합니다.
        	서버에서 이 값을 받아서 처리하는 데에는 POST 방식이 적합하다고 합니다. "데이터전송 -> 서버에서 처리 -> 결과 페이지에 반영"
        	 GET방식은 단순한 특정 페이지조회 등 검색리나 정보조회에 사용한다고 보시면 될것 같습니다. -->
     	  	 <form action="./user_search.jsp?login_id=<%= login_id %>" method="POST">
                <!-- 각 option 태그는 select 드롭다운 목록에 표시될 항목입니다. 
                request.getParameter("numb")로 받아온 값이 10, 20, 30과 맞는지 확인하고, 맞으면 option 태그에 selected 속성을 추가해서
                해당 항목이 기본적으로 선택된 상태로 표시됩니다.-->
                <!-- 조건이 참이면 selected 라는 문자열을 출력하도록 되어있는 코드입니다. selected 문자열이 jsp서버에서 처리되어
                html로 출력되는데 F12누르신 후 Elements에서 해당 코드를 보시면 option 태그가 선택한 것만 selected 가 쓰여져있음을 
                보실 수 있을 겁니다.-->
                show
                <select name="numb" id="numb" onchange="this.form.submit()">
                    <option value="10" <% if ("10".equals(request.getParameter("numb"))) out.print("selected"); %>>10</option>
                    <option value="20" <% if ("20".equals(request.getParameter("numb"))) out.print("selected"); %>>20</option>
                    <option value="30" <% if ("30".equals(request.getParameter("numb"))) out.print("selected"); %>>30</option>
                </select>
                entries
            </form>
            <form id="search-form" action="./user_search.jsp?login_id=<%= login_id %>" method="POST">
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
            <%-- 데이터 출력 --%>
            <% while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("ROWNO") %></td>
                    <% if (login_id.equals("admin")) { %>
                    	<!-- .jsp뒤에 ?로 시작되는 login_id     위쪽에 보시면 String login_id = request.getParameter("login_id");로
                    	파라미터를 받아왔습니다. 이전 페이지가 manage인지, change인지, main인지 어딘진 모르지만 이전 페이지에서 사용한 login_id를 
                    	받아와서 쓰겠다는 의미라고 생각하시면 됩니다. 
                    	
                    	<로그인 후 main을 거쳐 user_manage로 간 상황이라고 예를 들겠습니다.>
                    	
                    	1번. login_form.jsp 에서 admin으로 로그인을 했습니다.(로그인 input 태그의 name= "user_id" 이고, admin이라고 쓴 것이 user_id로 들어갑니다. ) 
                    	
                    	2번. login.jsp 코드 중  String userId = request.getParameter("user_id"); 문장을 통해 userId 변수에 이전 페이지에서 admin이라 입력한 것을 받아옵니다.
                    	   userId 변수 안에는 admin이 저장되어있습니다. location.href = "./main.jsp?login_id=<%= userId %>"; 는 ./main.jsp?login_id=admin 이라고 보시면 됩니다.
   
                    	3번. 정상 로그인 후 main.jsp 에서 String login_id = request.getParameter("login_id"); 문장을 보실 수 있습니다. 큰따옴표가 있는 부분 "login_id"는 
                    	     이는 세줄 위 2번에서 썼던 문장 ["./main.jsp?login_id=<%= userId %>";] 바로 이 문장에서 jsp? 다음 login_id 입니다. 즉, userId가 admin인데,
                    	     2번의 ?login_id가 admin이라는 값을 userId로부터 받았고, 3번의 String 변수 login_id 는 2번의 ?login_id로부터 받아온 것입니다.
                    	     
                    	4번. main.jsp에서도  <div class="buttonbox" id="user" onclick="window.location.href='user_manage.jsp?login_id=<%= login_id %>'">
                    	    처럼 클릭했을 때 ?login_id 속에 <%= login_id %> 를 넣겠다. 즉 <%= login_id %> 값이 admin 이니까 admin을 넣겠다는 것입니다.
                    	    
                    	5번. user_manage.jsp 에서도 String login_id = request.getParameter("login_id"); 문장이 있습니다. string 변수 login_id 를 통해
                    	     "이전페이지에 ?login_id 에 담겨있는 것 즉, admin을 받아오겠다" 라는 말이 됩니다.
                    	     
                    	user_search.jsp 는 이러한 과정을 한 번 더 거친 것이 됩니다.
                    	주석이 잘 먹히지 않는것 같으니 실행하실 땐 주석 지우고 쓰세요~    -->
                    	   
                    	                	
                    	
                        <td><a href="user_change.jsp?login_id=<%= login_id %>&user_id=<%= rs.getString("LOGIN_ID") %>"><%= rs.getString("LOGIN_ID") %></a></td>
                    <% } else { %>
                        <td><%= rs.getString("LOGIN_ID") %></td>
                    <% } %>
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
    		DBManager.dbClose(conn, pstmt, rs);
    		} catch(SQLException se) {
    			se.printStackTrace();
    			System.err.println("테이블 조회 에러");
    		}  
         %>
        </table>
    </div>

    <!-- 페이지 내비게이션 : 데이터를 페이지단위로 나누어 표시할 때 사용.
    totalPages는 앞서 선언된 변수로, 총 데이터 수입니다. 
    1부터 전체 페이지까지 반복하며 번호를 생성합니다. -->
    <div class="pagination">
        <%
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
