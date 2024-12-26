<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>
<%@ page import="java.sql.Timestamp" %>

<%
   //한글 처리
	request.setCharacterEncoding("UTF-8");
	
	String login_id = request.getParameter("loginid");
	
	
	String cuserPassword = request.getParameter("passwd");
	String cuserName = request.getParameter("name");
	String cuserSabun = request.getParameter("sabun");
	String cuserDepartnm = request.getParameter("depart_nm");
	String cuserJiknm = request.getParameter("jik_nm");
	String cuserEmail = request.getParameter("email");	
	String cuserMobile = request.getParameter("mobile");
	String cuserWriteid = request.getParameter("write_id");
	String cuserWritedt = request.getParameter("write_dt");
	
	
	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
	System.out.println(currentTimestamp);
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE MEUSER SET "
			+ "PASS_WD=?, LOGIN_NAME=?, SABUN_ID=?, DEPART_NM=?, JIK_NM=?, "
			+ "EMAIL=?, MOBILE_NO=?, WRITE_ID=?, WRITE_DT=? "
			+ "WHERE LOGIN_ID=?";
	
	int rows = 0;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cuserPassword);
		pstmt.setString(2, cuserName);
		pstmt.setString(3, cuserSabun);
		pstmt.setString(4, cuserDepartnm);
		pstmt.setString(5, cuserJiknm);
		pstmt.setString(6, cuserEmail);
		pstmt.setString(7, cuserMobile);
		pstmt.setString(8, cuserWriteid);
		
		
		pstmt.setTimestamp(9, currentTimestamp);
		pstmt.setString(10, login_id);
		
		rows = pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	}catch(Exception e){
		e.printStackTrace();
		
	}

%>
<script>
	if(<%= rows %> == 1){
		alert("<%= login_id %> 이(가) 수정되었습니다.");
	} else{
		alert("수정 실패하였습니다.");
	}
	window.location.href = './user_manage.jsp?login_id=<%= login_id %>';
</script>

