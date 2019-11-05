<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<% String userType = myUtil.getUserType(); %>
	
<!-- If not logged in -->
	<% if(userType == null || myUtil.getConn() == null){ %>
		<jsp:forward page="loginForm.jsp" /> 
	<% } %>
	
<!-- If only available to faculty -->
	<% if(userType != "F"){ %>
		<jsp:forward page="permission.jsp" />
	<% } %>
	
<!-- Include Faculty Header -->
	<%@ include file="facultyHeader.jsp" %>


</body>
</html>