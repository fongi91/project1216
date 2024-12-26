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
	
	String matcd = request.getParameter("MAT_CD");
	String matnm = request.getParameter("MAT_NM");
	String matstandcall = request.getParameter("STAND_CALL");
	String matweightcall = request.getParameter("WEIGHT_CALL");
	String matstandbigo = request.getParameter("STAND_BIGO");
	String matcustcd = request.getParameter("CUST_CD");
	String matinprice = request.getParameter("IN_PRICE");	
	String matbigo = request.getParameter("BIGO");
	String matwriteid = request.getParameter("WRITE_ID");
	String matwritedt = request.getParameter("WRITE_DT");
	
	Connection conn = DBManager.getDBConnection();
	
	String sql = "INSERT INTO MEMATERIAL(MAT_CD, MAT_NM, STAND_CALL, WEIGHT_CALL, STAND_BIGO, CUST_CD, IN_PRICE, BIGO, WRITE_ID, WRITE_DT) " 
			   + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	int rows = 0;
	
	try{
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, matcd);
		pstmt.setString(2, matnm);
		pstmt.setString(3, matstandcall);
		pstmt.setString(4, matweightcall);
		pstmt.setString(5, matstandbigo);
		pstmt.setString(6, matcustcd);
		pstmt.setString(7, matinprice);
		pstmt.setString(8, matbigo);
		pstmt.setString(9, matwriteid);
		pstmt.setString(10, matwritedt);
		
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
			alert("자재추가에 성공하였습니다.");
		} else{
			alert("필수항목미입력으로 자재추가에 실패하였습니다.");
		}
		window.location.href = './material_manage.jsp?login_id=<%= login_id %>';
	</script>
