<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>deleteStudentHandler</title>
</head>
<body>

<!-- Include Faculty Header -->
	<%@ include file="facultyHeader.jsp" %>
	
	<%
		String accountInfo = request.getParameter("id");
		String studentId = accountInfo.split("-")[0];
		int result = myUtil.deleteUser(studentId);
	%>
	
	<h2>Delete a Student</h2>
	<%if(result != 0 ){ %>
		Successfully Deleted a User with ID: <%= studentId%>.
		
		<%if(studentId.equals(myUtil.getUserId()))
				myUtil.closeDB(); %>
	<%} else {%>
		Successfully Deleted a User with ID: <%= studentId%>.
		Please try again...
	<%} %>

</body>
</html>