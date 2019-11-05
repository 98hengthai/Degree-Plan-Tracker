<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>deleteStudent</title>
</head>
<body>

	<% String userType = myUtil.getUserType();%>
	
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
	
	
	<%
		String[] studentArry = myUtil.getAllStudent();
	%>
	
	<h2>Delete a Student</h2>
	
	Select a Student
			<form action ="deleteStudentHandler.jsp">
			<select name = "id">
				<% for(String s: studentArry){ %>
					<option value=<%=s%>> <%=s.split("-")[0] + " - " + s.split("-")[1]%> </option>
				<% } %>
			</select>
			<input type="submit" value="Delete">
			</form>
			
	<p></p>
	<br>
	<h4>----! Remove Yourself !----</h4>
	For faculty to remove yourself from the database, click the button below:
	<form action ="deleteStudentHandler.jsp">
		Faculty ID: <u><%= myUtil.getUserId() %></u>
		<input type="hidden" name="id" value= <%= myUtil.getUserId() %> >
		<input type="submit" value="Delete">
	</form>


</body>
</html>