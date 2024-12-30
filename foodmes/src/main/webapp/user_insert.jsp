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
	String login_id = request.getParameter("login_id");
	
	String userId = request.getParameter("id");
	String userPassword = request.getParameter("passwd");
	String userName = request.getParameter("name");
	String userSabun = request.getParameter("sabun");
	String userDepartnm = request.getParameter("depart_nm");
	String userJiknm = request.getParameter("jik_nm");
	String userEmail = request.getParameter("email");	
	String userMobile = request.getParameter("mobile");
	String userWriteid = request.getParameter("write_id");
	String userWritedt = request.getParameter("write_dt");
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "INSERT INTO MEUSER(LOGIN_ID, PASS_WD, LOGIN_NAME, SABUN_ID, DEPART_NM, JIK_NM, EMAIL, MOBILE_NO, WRITE_ID, WRITE_DT) " 
			   + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
	
	int rows = 0;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, userId);
		pstmt.setString(2, userPassword);
		pstmt.setString(3, userName);
		pstmt.setString(4, userSabun);
		pstmt.setString(5, userDepartnm);
		pstmt.setString(6, userJiknm);
		pstmt.setString(7, userEmail);
		pstmt.setString(8, userMobile);
		pstmt.setString(9, "admin");
		
		// sql문 실행
		// 실제 insert 한 행의 개수로 rows의 값은 1이 됩니다.
		rows = pstmt.executeUpdate();
		
		// db 정리
		DBManager.dbClose(conn, pstmt, null);
	} catch (Exception e){
		e.printStackTrace();	
	}
%>
<script>
	if(<%= rows %> == 1){
		alert("사용자 입력이 완료되었습니다.");
	} else{
		alert("사용자 입력에 실패하였습니다.");
	}
	window.location.href = './user_manage.jsp?login_id=<%= login_id %>';
</script>
