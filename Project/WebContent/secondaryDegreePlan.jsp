<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<!-- User declaration -->
	<% 
	String userType = myUtil.getUserType(); 
	String studentId = myUtil.getUserId();
	//String userType = "F"; 
	//String studentId = "99999997";
	%>
	
	<!-- If not logged in -->
	<% if(userType == null || myUtil.getConn() == null){ %>
		<jsp:forward page="loginForm.jsp" /> 
	<% } %>
	
	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
	<%}%>
	
	<h3>Create a secondary degree plan</h3>
	
	<!-- Faculty View-->
	<% if(userType.equals("F")){
		String[] studentArry = myUtil.getAllStudent(); %>
		
		Select a Student
			<form action ="secondaryDegreePlanDegreeInputs.jsp">
			<select name = "id">
				<% for(String s: studentArry){ %>
					<option value=<%=s.split("-")[0]%>> <%=s.split("-")[0] + " - " + s.split("-")[1]%> </option>
				<% } %>
			</select>
			<input type="submit" value="Submit">
			</form>
	
	<!-- Student View -->	
	<% } else if(userType.equals("S")) { %>
		Confirm your ID
			<form action ="secondaryDegreePlanDegreeInputs.jsp">
			<select name = "id">
					<option value=<%=studentId%>> <%=studentId%> </option>
			</select>
			<input type="submit" value="Submit">
			</form>
	<%} %>
</body>
</html>