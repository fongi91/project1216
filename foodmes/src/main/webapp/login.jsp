<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "com.company1.DBManager" %>

<%
   //한글 처리
   request.setCharacterEncoding("UTF-8");
   

   // 공부할 주제 번호를 가져옴
   // login_form의 input태그 name을 가져와서 usdrId에 저장 
   String userId = request.getParameter("user_id");
   String userPwd = request.getParameter("user_pwd");
   

   Connection conn = DBManager.getDBConnection();
   
   try{
      String sql = "SELECT LOGIN_ID, PASS_WD FROM MEUSER WHERE LOGIN_ID = ?";
      int rows = 0;

      //실제 DELETE sql 쿼리실행
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, userId);
               
      //ResultSet을 통해 데이터 읽어
      ResultSet rs = pstmt.executeQuery();
      if(rs.next()){   
         if(userPwd.equals(rs.getString("PASS_WD"))){
            %>
            <script>
               alert('로그인 성공.');
               location.href = "./main.jsp?login_id=<%= userId %>";
            </script>
            <%
         } else {
            %>
            <script>
               alert('로그인 실패.');
               location.href = './login_form.jsp';
            </script>
            <%
         }
            %>
            <%   
      }
      DBManager.dbClose(conn, null, null);         
   }catch(Exception e) {
      e.printStackTrace();
      //exit();
   } 
%>