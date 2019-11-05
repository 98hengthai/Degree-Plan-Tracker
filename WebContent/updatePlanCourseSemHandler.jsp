<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>updatePlanCourseSemHandler</title>

</head>
<body>
	<!-- If not logged in -->
	<% if(myUtil.getUserType() == null || myUtil.getConn() == null){ %>
		<jsp:forward page="loginForm.jsp" /> 
	<% } %>
	
	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
	<%}%>

	<h2>Updating Course's Semester</h2>

	<%
		String id = request.getParameter("id");
		String courseDept = request.getParameter("cDept");
		String courseNum = request.getParameter("cNum");
		int yearPlanned = Integer.parseInt(request.getParameter("planningYr"));
		String semesterPlanned = request.getParameter("semesterPlanned");
		String newSemester = request.getParameter("newSemester");
		int newYear = Integer.parseInt(request.getParameter("newYear"));
		int dLen = Integer.parseInt(request.getParameter("degLen"));
		String dType = request.getParameter("degType");		
		
		int result = myUtil.moveCourseOnPlan(newYear, newSemester.substring(0,1), courseNum, courseDept, id, dLen, dType);
	%>
	
	<%	if(result != 0 ){ %>
			Successfully Updated Course
			<hr>
			Course: <%= courseDept + " " + courseNum %> <br>
			New Planning: <%= newSemester +", " + newYear %>	
	<% 	} else {%>
			Unsuccessfully Updated Course
			<hr>
			Please try again...
	<%} %>

</body>
</html>