<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.company1.DBManager" %>

<%
    // 한글 처리
    request.setCharacterEncoding("UTF-8");
    String login_id = request.getParameter("login_id");
%>    

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>사조떡볶이</title>
    <link rel="stylesheet" href="./css/main_style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Afacad+Flux:wght@100..1000&family=Doto:wght@100..900&family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Afacad+Flux:wght@100..1000&family=Doto:wght@100..900&family=Nanum+Pen+Script&family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Afacad+Flux:wght@100..1000&family=Doto:wght@100..900&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Afacad+Flux:wght@100..1000&family=Doto:wght@100..900&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Orbit&family=Space+Grotesk:wght@300..700&display=swap" rel="stylesheet">
    <style>
        .container {
            display: flex;
            flex-grow: 1;
            margin-left: 200px;
            padding: 20px;
            height: 100vh;
            flex-direction: column;
            justify-content: flex-start;
        }

        .buttonbox-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 0px;
        }

        .buttonbox {
            width: 500px;
            height: 600px;
            cursor: pointer;
            border-radius: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: black;
            background-color: #d1740a;
            transition: all 0.3s ease-in-out;
        }

        .buttonbox:hover {
            width: 80%;
            background-color: #d1740a;
        }

        .buttonbox:hover .nametec {
            background-color: #d1740a;
            border-style: none;
            transition: all 0.3s ease-in-out;
        }

        #user {
            background: linear-gradient(to bottom, rgba(0, 0, 0, 0.3), white 100%), url("./images/people.png");
            background-repeat: no-repeat;
            background-position: right;
            background-size: cover;
        }

        #item {
            background: linear-gradient(to bottom, rgba(219, 122, 10, 0.3), white 100%), url("./images/oip2.png");
            background-repeat: no-repeat;
            background-position: center;
            background-size: cover;
        }

        #material {
            background: linear-gradient(to bottom, rgba(199, 17, 17, 0.3), white 100%), url("./images/food.png");
            background-repeat: no-repeat;
            background-position: right;
            background-size: cover;
        }

        .copyright {
            text-align: right;
            font-size: small;
            padding: 10px;
            width: 100%;
            position: fixed;
            bottom: 0;
        }

        .nametec {
            width: 100%;
            height: 50px;
            background-color: #575757;
            color: white;
            font-size: 30px;
            font-family: "Afacad Flux", serif;
            font-optical-sizing: auto;
            font-weight: bold;
            text-align: center;
            border-style: none;
        }

        .nametec:hover {
            background-color: #d1740a;
        }

        .textbox {
            font-size: 30px;
            font-family: "Nanum Pen Script", serif;
            text-align: center;
            line-height: 1.6;
            color: #333;
            margin-top: 0px;
        }

        h2 {
            font-family: "Orbit", serif;
        }

        .logout {
            margin-top: 700px;
        }
        
        .loginCheck {
        	padding-left:20px;
        }

    </style>
</head>

<body>
    <div class="sidebar">
        <h3><a href="./main.jsp?login_id=<%= login_id %>">사조떡볶이 제조시스템</a></h3>
        <div class="sidebar1">
            <a href="./user_manage.jsp?login_id=<%= login_id %>">사용자관리</a>
            <a href="./product_manage.jsp?login_id=<%= login_id %>">제품기준관리</a>
            <a href="./material_manage.jsp?login_id=<%= login_id %>">자재기준관리</a>
            <a href="#contact">Version</a>
            <div class="logout">
                <p class=loginCheck>현재 로그인: <%= login_id %>님</p>
                <a href="./login_form.jsp">로그아웃</a>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="buttonbox-container">
            <div class="buttonbox" id="user" onclick="window.location.href='user_manage.jsp'">
                <button type="button" class="nametec">USER</button>
            </div>
            <div class="buttonbox" id="item" onclick="window.location.href='product_manage.jsp'">
                <button type="button" class="nametec">ITEM</button>
            </div>
            <div class="buttonbox" id="material" onclick="window.location.href='material_manage.jsp'">
                <button type="button" class="nametec">MATERIAL</button>
            </div>
        </div>

        <div class="textbox">
            <p><%= login_id %>님 환영합니다.</p>
            <h2>안녕하세요!</h2>
            <p>이곳은 사조떡볶이 제조시스템입니다. 600년 전통의 고추장으로 차별화된 맛과 멋을 제공하는 사조떡볶이에 오신 것을 환영합니다.</p>
            <p>문의 사항이 있으신 경우, admin에 문의 부탁드립니다.</p>
        </div>
    </div>

    <div class="copyright">
        <p>Copyright SAJO All rights reserved.</p>
    </div>
</body>

</html>
