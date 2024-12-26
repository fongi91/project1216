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
    
    
	String citemNm = request.getParameter("item_nm");
	String citemStand = request.getParameter("item_stand");
	String citemPrice = request.getParameter("item_price");
	String ccustPrice = request.getParameter("cust_price");
	
	String cbigo = request.getParameter("bigo");
	String cWriteid = request.getParameter("write_id");
	String cWritedt = request.getParameter("write_dt");
	
	String citemCd = request.getParameter("item_cd");
	
	Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());
	System.out.println(currentTimestamp);
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "UPDATE MEITEM SET "
			+ "ITEM_NM=?, ITEM_STAND=?, ITEM_PRICE=?, CUST_PRICE=?, BIGO=?, "
			+ "WRITE_ID=?, WRITE_DT=? "
			+ "WHERE ITEM_CD=?";
	
	int rows = 0;
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, citemNm);
		pstmt.setString(2, citemStand);
		pstmt.setString(3, citemPrice);
		pstmt.setString(4, ccustPrice);
		pstmt.setString(5, cbigo);
		pstmt.setString(6, cWriteid);
		pstmt.setTimestamp(7, currentTimestamp);
		pstmt.setString(8, citemCd);
		
		rows = pstmt.executeUpdate();
		
		DBManager.dbClose(conn, pstmt, null);
	}catch(Exception e){
		e.printStackTrace();
		
	}

%>
<script>
	if(<%= rows %> == 1){
		alert("<%= citemCd %> 이(가) 수정되었습니다.");
	} else{
		alert("수정 실패하였습니다.");
	}
	window.location.href = './product_manage.jsp?login_id=<%= login_id %>';
</script>

