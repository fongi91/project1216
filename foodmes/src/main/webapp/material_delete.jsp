<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="com.company1.DBManager" %>
<%
    // 한글 처리
    request.setCharacterEncoding("UTF-8");


	String login_id = request.getParameter("login_id");
    // URL에서 전달된 자재 코드(Matcd) 파라미터를 가져옵니다.
    String cmatcd = request.getParameter("Matcd");
    

    Connection conn = DBManager.getDBConnection();
    
    // DELETE 쿼리 준비
    String sql = "DELETE FROM MEMATERIAL WHERE MAT_CD = ?";
    
    int rows = 0;  // 삭제된 행의 수
    
    try {
        // PreparedStatement 사용하여 DELETE 쿼리 실행
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, cmatcd);  // 전달된 자재 코드로 DELETE 실행
        
        // 실행
        rows = pstmt.executeUpdate();
        
        // 연결 종료
        DBManager.dbClose(conn, pstmt, null);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
    // 삭제 결과에 따른 메시지 처리
    if(<%= rows %> == 1){
        alert("<%= cmatcd %> 자재가 삭제되었습니다.");
    } else {
        alert("삭제 실패하였습니다.");
    }
    
    // 삭제 후 자재 관리 페이지로 리디렉션
    window.location.href = './material_manage.jsp?login_id=<%= login_id %>';
</script>
