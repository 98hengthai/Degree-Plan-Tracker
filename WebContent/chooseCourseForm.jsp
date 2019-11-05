<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Choose Course Form</title>
</head>
<body>

		<% String userType = myUtil.getUserType(); %>
	
<!-- If not logged in -->
	<% if(userType == null || myUtil.getConn() == null){ %>
		<jsp:forward page="loginForm.jsp" /> 
	<% } %>
	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
		<jsp:forward page="chooseCourseForm2.jsp" />
	<%}%>


	
	
	<%if(myUtil.getConn() == null){
	myUtil.openDB(); %>
	Connection is: <%out.print(myUtil.getConn()); %>
	<%} %>

<!-- Get Student IDs -->

	<%	ResultSet rs = myUtil.getUsers(); %>
	
<br>

<form action="chooseCourseForm2.jsp"> 
Select Student Degree Plan: 
<select name="studentID">
<%while (rs.next()) { %>
	<option value = <%= rs.getString(1) %> >
		<%= rs.getString(1) %>
	</option>
	<%} %>
</select>

<input type="submit" value="Select Student">	
</form>

</body>
</html>