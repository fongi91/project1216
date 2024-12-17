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



%>    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/style.css">

    <title>Document</title>
</head>
<body>
    <section>
        <container class = "container">
            <container class = "login_container">
                <div class = "loginframe">
                    <h1>OOO</h1>
                    <h1>제조관리 프로그램</h1>
                    
                    <!--로그인에 사용하는 form 태그에 대한 강의 필요 -->
                    <form id="login-form" action="./login.jsp" method="POST">
                        <div class="id_password">
                            <input type="text" name="user_id" id="user_id" 
                                autocomplete="off" required><label for ="user_id">ID</label>
                        </div>
                        <div class="id_password">
                            <input type="password" name="user_pwd" id="user_pwd"
                                autocomplete="off" required><label for = "user_pwd">Password</label>
                        </div>
                        <button id="login-button" style="cursor: pointer;">LOGIN</button>
                           
                        </div>                                
                   </form>
                </div>  


                <script>
                   document.addEventListener("DOMContentLoaded", function() {   // 웹 페이지가 로딩되면 실행
                    //const button = document.querySelector("button");  // 버튼 요소 가져오기
                    const button = document.getElementById("login-button");  // 버튼 요소 가져오기
                    button.addEventListener("click", function (event) {  // 버튼을 클릭하면 실행
                         event.preventDefault();  // 기본 동작을 막음
                         Register();   // 새로운 주제를 등록하는 함수 호출  
                       });
                   });
                   
                   
                   function Register(){
                      const login = document.getElementById('login-form');
                      login.submit();
                   }
                </script>


            </container>
        </container>
    </section>
</body>
</html>