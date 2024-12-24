<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String item_cd = request.getParameter("item_cd");
	String item_nm = request.getParameter("item_nm");
	String item_stand = request.getParameter("item_stand");	
	String item_price = request.getParameter("item_price");
	Integer item_priceNum = Integer.parseInt(item_price);
	String cust_price = request.getParameter("cust_price");
	Integer cust_priceNum = Integer.parseInt(cust_price);
	String bigo = request.getParameter("bigo");
	String write_id = request.getParameter("write_id");
	String write_dt = request.getParameter("write_dt");
	


	Connection conn = DBManager.getDBConnection();
	
    		String sql = " INSERT INTO MEITEM(ITEM_CD, ITEM_NM, ITEM_STAND, ITEM_PRICE, CUST_PRICE, BIGO, WRITE_ID, WRITE_DT) "
    		+ " VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATE)";
    		
    		
    		

    		
    		int rows = 0;
    		
    		try{
    			
    			PreparedStatement pstmt = conn.prepareStatement(sql);
    			
    			pstmt.setString(1, item_cd);
    			pstmt.setString(2, item_nm);
    			pstmt.setString(3, item_stand);
    			pstmt.setInt(4, item_priceNum);
    			pstmt.setInt(5, cust_priceNum);
    			pstmt.setString(6, bigo);
    			pstmt.setString(7, write_id);
    			//pstmt.setString(8, write_dt);
    			
    			
    			rows = pstmt.executeUpdate();
    			
    			DBManager.dbClose(conn, pstmt, null);	
    		} catch (Exception e){
    			e.printStackTrace();
    			System.err.println("입력오류");
    		}
    		
    %>
    <script>
	if(<%= rows %> == 1){
		alert("제품 추가가 완료되었습니다.");
	} else{
		alert("제품 추가에 실패하였습니다.");
	}
	window.location.href = './product_manage.jsp';
</script>