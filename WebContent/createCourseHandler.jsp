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

	<% 
	String dept = request.getParameter("dept"); 
	String num = request.getParameter("num");
	String hours = request.getParameter("hours");
	String sem = request.getParameter("sem");
	String year = request.getParameter("year");
	
	try{
		Integer.parseInt(num);
	}catch(NumberFormatException e){
		out.println("Course Number must be an integer");
		return;
	}
	
	int rs = myUtil.createNewCourse(num, dept, hours, sem, year);
	
	if(rs != 0){
		out.println("Successfully Created " + dept + num);
	}
	else{
		out.println("The course could not be created");
	}
	
	%>


</body>
</html>