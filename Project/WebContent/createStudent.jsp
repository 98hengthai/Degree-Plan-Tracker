<!-- createStudent Form (use case 1)
Created by NS 5/9/19
-->

<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>

<% String userType = myUtil.getUserType();

%>

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




<!DOCTYPE html>
<html>
<head>

    <title>Create New Student</title>
</head>
<br><br>

<body>

<form action="createStudentpart2.jsp" method="POST">
    New Student's 8-digit ID Number: <input type="text" name="id" size="20" pattern="[0-9]{8}" title="8-digit ID" required><br><br>
    First Name: <input type="text" name="fname" size="30" required><br><br>
    Last Name: <input type="text" name="lname" size="30" required><br><br>
    Student's Email: <input type="email" name="email" size = "30" required><br><br>
    Student's Password: <input type="password" name="password" size="30" required><br><br>
    Degree Length (select one): <br>
    <input type="radio" name="deglen" value="2"> 2-Year Plan
    <input type="radio" name="deglen" value="3"> 3-Year Plan
    <input type="radio" name="deglen" value ="4"> 4-Year Plan
    <br><br>If no degree length is selected, student will be assigned a 4-Year Plan

    

    <input type="submit" value="Submit">
</form>

</body>
</html>