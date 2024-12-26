<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>

<%
    // 한글 처리
    request.setCharacterEncoding("UTF-8");
	String login_id = request.getParameter("login_id");



    // 페이지 크기와 현재 페이지 번호 받기
    String postCountStr = request.getParameter("numb");
    int postCount = (postCountStr != null) ? Integer.parseInt(postCountStr) : 10; // 기본값 10
    String pageStr = request.getParameter("page");
    int currentPage = (pageStr != null) ? Integer.parseInt(pageStr) : 1;

    // DB 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalCount = 0;
    int totalPages = 0;

    try {
        conn = DBManager.getDBConnection();

        // 전체 데이터 개수 계산 (총 데이터 수를 알아야 페이지 수를 계산할 수 있음)
        String countSql = "SELECT COUNT(*) FROM MEMATERIAL";
        pstmt = conn.prepareStatement(countSql);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            totalCount = rs.getInt(1);
        }

        // 전체 페이지 수 계산
        totalPages = (int) Math.ceil((double) totalCount / postCount);

        // 시작 인덱스 계산 (0부터 시작)
        int startIndex = (currentPage - 1) * postCount + 1;
        int endIndex = currentPage * postCount;

        // 데이터 가져오기 (OFFSET과 LIMIT을 사용하여 해당 페이지 데이터만 가져옴)
        String sql = "SELECT * FROM ("
                   + "SELECT rownum AS ROWNO, MAT_CD, MAT_NM, STAND_CALL, WEIGHT_CALL, STAND_BIGO, CUST_CD, "
                   + "to_char(IN_PRICE, 'FM999,999,999') AS IN_PRICE, BIGO, WRITE_ID, "
                   + "to_char(write_dt, 'YYYY/MM/DD HH24:MI:SS') AS WRITE_DT "
                   + "FROM MEMATERIAL "
                   + "WHERE rownum <= ?) "
                   + "WHERE ROWNO >= ?";
        
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, endIndex);  // rownum을 endIndex까지 설정
        pstmt.setInt(2, startIndex);  // rownum을 startIndex 이상으로 설정
        rs = pstmt.executeQuery();
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
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        <div class = "sidebar1">
        	<a href="./user_manage.jsp?login_id=<%= login_id %>">사용자관리</a>
        	<a href="./product_manage.jsp?login_id=<%= login_id %>">제품기준관리</a>
        	<a href="./material_manage.jsp?login_id=<%= login_id %>">자재기준관리</a>
        	<a href="#contact">Version</a>
        </div>
    </div>



    <div class="content">
        <div>
        	<h1>자재기준관리</h1>
        	<div class="button">
            	<button id="user_add_button">자재 생성</button>
        	</div>
        </div>
        
        <hr>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const button = document.getElementById("user_add_button");
                button.addEventListener("click", function () {
                    window.location.href = "./material_add.jsp?login_id=<%= login_id %>"; // 자재 추가 페이지로 이동
                });
            });
        </script>

    	<div class="right-side">
            <form action="material_manage.jsp" method="GET">
                show
                <select name="numb" id="numb" onchange="this.form.submit()">
                    <option value="10" <% if ("10".equals(request.getParameter("numb"))) out.print("selected"); %>>10</option>
                    <option value="20" <% if ("20".equals(request.getParameter("numb"))) out.print("selected"); %>>20</option>
                    <option value="30" <% if ("30".equals(request.getParameter("numb"))) out.print("selected"); %>>30</option>
                </select>
                entries
            </form>

            <form id="search-form" action="./material_search.jsp" method="POST">
                <span class="search">
                    <input class="searchbox" type="search" id="search" name="search1" placeholder="자재검색">
                    <button class="search-button"></button>
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
                // 데이터 출력
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("ROWNO") %></td>
                <td> <a href="material_change.jsp?login_id=<%= login_id %>&MATCD=<%= rs.getString("MAT_CD") %>"><%= rs.getString("MAT_CD") %></a></td>
                <td><%= rs.getString("MAT_NM") %></td>
                <td><%= rs.getString("STAND_CALL") %></td>
                <td><%= rs.getString("WEIGHT_CALL") %></td>
                <td><%= rs.getString("STAND_BIGO") %></td>
                <td><%= rs.getString("CUST_CD") %></td>
                <td class="in_price"><%= rs.getString("IN_PRICE") %></td>
                <td><%= rs.getString("BIGO") %></td>
    		<td><%= rs.getString("WRITE_ID") == null ? "" : rs.getString("WRITE_ID") %></td>
    		<td><%= rs.getString("WRITE_DT") == null ? "" : rs.getString("WRITE_DT") %></td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <!-- 페이지 네비게이션 -->
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

<%
    } catch (SQLException se) {
        se.printStackTrace();
    } finally {
        // 자원 정리 (finally 블록에서 반드시 닫아야 함)
        DBManager.dbClose(conn, pstmt, rs);
    }
%>
