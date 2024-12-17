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
    <title>Left Sidebar Menu</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .sidebar {
            width: 200px;
            height: 100vh; /* Full height */
            background-color: #3a08c2 ;
            color: white;
            position: fixed; /* Stay fixed on the left */
            top: 0;
            left: 0;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            transition: background-color 0.3s;
        }

        .sidebar a:hover {
            background-color: #575757;
        }

        .content {
            margin-left: 250px; /* Same as the sidebar width */
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>사조떡볶이 제조시스템</h2>
        <a href="#home">사용자관리</a>
        <a href="#about">제품기준관리</a>
        <a href="#services">자재기준관리</a>
        <a href="#contact">Version</a>
    </div>

    <div class="content">
        <h1>Welcome</h1>
        <p>This is the main content area. The sidebar stays fixed on the left.</p>
    </div>
</body>
</html>