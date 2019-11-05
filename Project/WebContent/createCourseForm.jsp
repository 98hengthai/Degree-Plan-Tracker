<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Create Course</title>
</head>
<body>

<% String userType = myUtil.getUserType(); %>

<!-- If not logged in -->
<% if(userType == null || myUtil.getConn() == null){ %>
<jsp:forward page="loginForm.jsp" />
<% } %>

<!-- If only available to faculty -->
<% if(!userType.equals("F")){ %>
<jsp:forward page="permission.jsp" />
<% } %>

<!-- Include Faculty Header -->
<%@ include file="facultyHeader.jsp" %>

<h1>Create Course</h1>

<form action="createCourseHandler.jsp" method="get">
    Department: <input type="text" name="dept" size=5 value='CSCI' required>
    Number: <input type="text" name="num" size= 5 required> <br> <br>
    Credit hours:  <br>
    <select name="hours">
        <option value = 0>0
        <option value = 1>1
        <option value = 2>2
        <option value = 3>3
        <option value = 4 selected="selected">4
        <option value = 5>5
    </select>
    <br> <br>

    Semesters Offered: <br>
    <select name="sem">
        <option value = F>Fall
        <option value = J>J-term
        <option value = S>Spring
        <option value = B selected="selected">Fall and Spring
        <option value = A>Fall, J-term and Spring
    </select>
    <br> <br>

    Years Offered: <br>
    <select name="year">
        <option value = 1>Odd Years
        <option value = 2>Even Years
        <option value = 3 selected="selected">Every Year
    </select>

    <br> <br>
    <input type="submit" value="Submit">
</form>

</body>
</html>