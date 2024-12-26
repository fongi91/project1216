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
	String login_id = request.getParameter("login_id");
	
	String cmatcd = request.getParameter("Matcd");
	String cmatnm = request.getParameter("Matnm");
	String cstandcall = request.getParameter("Standcall");
	String cstandbigo = request.getParameter("Standbigo");
	String cweightcall = request.getParameter("Weightcall");
	String ccustcd = request.getParameter("Custcd");
	String cinprice = request.getParameter("Inprice");	
	String cbigo = request.getParameter("Bigo");
	String cWriteid = request.getParameter("write_id");
	String cWritedt = request.getParameter("write_dt");
	
	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
	System.out.println(currentTimestamp);
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE MEMATERIAL SET "
			+ "MAT_NM=?, STAND_CALL=?, STAND_BIGO=?, WEIGHT_CALL=?, "
			+ "CUST_CD=?, IN_PRICE=?, WRITE_ID=?, BIGO = ?, WRITE_DT=? "
			+ "WHERE MAT_CD=?";
	
	int rows = 0;
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cmatnm);
		pstmt.setString(2, cstandcall);
		pstmt.setString(3, cstandbigo);
		pstmt.setString(4, cweightcall);
		pstmt.setString(5, ccustcd);
		pstmt.setString(6, cinprice);
		pstmt.setString(7, cWriteid);
		pstmt.setString(8, cbigo);
		pstmt.setTimestamp(9, currentTimestamp);
		pstmt.setString(10, cmatcd);
		
		rows = pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	}catch(Exception e){
		e.printStackTrace();
		
	}

%>
<script>
	if(<%= rows %> == 1){
		alert("<%= cmatcd %> 이(가) 수정되었습니다.");
	} else{
		alert("수정 실패하였습니다.");
	}
	window.location.href = './material_manage.jsp?login_id=<%= login_id %>';
</script>

