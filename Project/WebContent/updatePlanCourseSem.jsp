<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>updatePlanCourseSem</title>
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

	
	
	
	<h2>Updating Course's Semester</h2>
	
	<% 
		//get all student
		String[] studentArry = myUtil.getAllStudent();		
		String studentInfo = request.getParameter("id");	
		if(studentInfo != null){
			studentId = studentInfo.split("-")[0];
		}
			
		String[] degreePlan = null;
		String[] courses = null;
		String planName = request.getParameter("degreePlan");
		String degType = request.getParameter("degType");
		String degLen = request.getParameter("degLen");
		String selectedCourse = request.getParameter("course");
		String[] semesterArry = null;
		String[] yearArry = null;
	%>
	
	

	
	<!-- If only available to faculty -->
	<% if(userType.equals("F")){ %>
		Select a Student
			<form action ="updatePlanCourseSem.jsp">
			<select name = "id">
				<% for(String s: studentArry){ %>
					<option value=<%=s%>> <%=s.split("-")[0] + " - " + s.split("-")[1]%> </option>
				<% } %>
			</select>
			<input type="submit" value="Select">
			</form>
	
	<% } %>
	
	<%if(userType.equals("S") || request.getParameter("id") != null ) {%>
			<%degreePlan = myUtil.getDegrePlanOption(studentId);%>
			<%if (userType.equals("F")) {%>
				<b>Selected Student ID : <%=studentId %></b><br><p></p>
			<% } %>
			
			Select Degree Plan
			<form action ="updatePlanCourseSem.jsp">
			<select name = "degreePlan">
				<% for(String s: degreePlan){ %>
					<option value=<%=s%>> <%=s%> </option>
				<% } %>
			</select>
			<input type="hidden" name="id" value= <%=studentId%>>
			<input type="submit" value="Select">
			</form>
			<%if (degreePlan.length == 0) { %>
				<b>Student doesn't a degree plan.</b>
			<%}%>
		
	<% } %>
	
	<%if( planName != null || degLen != null){ %>
		<%
			 degType = planName.substring(0,2);
			 degLen = planName.substring(3,4);
			 courses = myUtil.getCoursesPartOfDegreePlan(studentId, degType, degLen); 
		%>
		<b>Current Selection: <%=degType + "-" + degLen + " years"%></b> <p></p>
		
		
		Select Course<br>
		(Course, Current Semester and Year)
			<form action ="updatePlanCourseSem.jsp">
			<select name = "course">
				<% for(String s: courses){ %>
					<option value=<%=s%> > <%=s%> </option>
					<%=s%>
				<% } %>
			</select>
			<input type="hidden" name="id" value= <%=studentId%>>
			<input type="hidden" name="degreePlan" value= <%=planName%>>
			<input type="hidden" name="degType" value= <%=degType%>>
			<input type="hidden" name="degLen" value= <%=degLen%>>
			<input type="submit" value="Select">
			</form>
			
			<%if (courses.length == 0) { %>
				<b>There is no course in the degree plan.</B>
			<%}%>
			
		
	<%}%>
	
	<%if(selectedCourse != null){ %>
		<%
			String[] arry = selectedCourse.split("-");
			String courseDept = arry[0];
			String courseNum = arry[1];
			String semesterPlanned = arry[2];
			String planningYr = arry[3];
		 	semesterArry = myUtil.getSemesterOffered(courseDept, courseNum);
		 	yearArry = myUtil.getYearOffering(courseDept, courseNum, planningYr);
		%>
		
		<b>Current Selection: <%=courseDept + " " + courseNum + " - " + semesterPlanned + ", " + planningYr%></b><p></p>
		
		Select Semester and Year
			<form action ="updatePlanCourseSemHandler.jsp">
			<select name = "newSemester">
				<% for(String s: semesterArry){ %>
					<option value=<%=s%> > <%=s%> </option>
					<%=s%>
				<% } %>
			</select>
			<br>
			<select name = "newYear">
				<% for(String s: yearArry){ %>
					<option value=<%=s%> > <%=s%> </option>
					<%=s%>
				<% } %>
			</select>
			
			<input type="hidden" name="id" value= <%=studentId%>>
			<input type="hidden" name="degreePlan" value= <%=planName%>>
			<input type="hidden" name="degType" value= <%=degType%>>
			<input type="hidden" name="degLen" value= <%=degLen%>>
			<input type="hidden" name="cDept" value= <%=courseDept%>>
			<input type="hidden" name="cNum" value= <%=courseNum%>>
			<input type="hidden" name="semesterPlanned" value= <%=degLen%>>
			<input type="hidden" name=planningYr value= <%=planningYr%>>
			<input type="submit" value="Submit">
			</form>
	<% } %>
	

</body>
</html>