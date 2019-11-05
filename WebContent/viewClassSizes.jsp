<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Class Size</title>
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

	<h1>View Class Sizes</h1>
	
	<!-- Returns list of courses that at least 1 person is enrolled in -->
	<% ResultSet course = myUtil.getAllCourses(); %>
	<% String selected_course = request.getParameter("course"); %>
	
	<form action="viewClassSizes.jsp" method="put">
		
		<!-- No Course is yet selected (i.e. it's the first time its loaded before any submits) -->
		<% if(selected_course == null){ %>
			Course Number: <br> 
			
			<!-- Create selection  -->
			<select name="course" onchange="this.form.submit()">
				<% while(course.next()) { %>
					<option value = <%= course.getString(1)+course.getString(2) %>>
						<%= course.getString(1)+course.getString(2) %>
				<% } %>
			</select>
			<br><br>
			<input type="submit" value="Submit">
		<%
		// If a course has been chosen (i.e. it's the second submit)
		}else if(request.getParameter("semester") == null){ %>
		Course Number: <br> 
			<select name="course" onchange="this.form.submit()">
				<option value = <%= selected_course %>>
					<%= selected_course %>
			</select>
			<br>
			<br>
			Semester: Year:<br> 
			<select name="semester">
			
			<!-- Get years and semesters a student is enrolled in the course in -->
			<% ResultSet sem = myUtil.getSemOffered(selected_course.substring(4)); 
			ResultSet year = myUtil.getYearOffered(selected_course.substring(4));
			sem.next();
			
			// Display it in english, not enum
			switch(sem.getString(1)){
			case "F":
				%> <option value = F>Fall <%
				break;
			case "J":
				%> <option value = J>J-Term <%
				break;
			case "S":
				%> <option value = S>Spring <%
				break;
			case "B":
				%> <option value = F>Fall
				<option value = S>Spring <%
				break;
			case "A":
				%> <option value = F>Fall
				<option value = J>J-Term
				<option value = S>Spring <%
				break;
			} %>
			</select>
			<select name="year">
				<% while(year.next()) { %>
					<option value = <%= year.getInt(1)%>>
						<%= year.getInt(1) %>
				<% } %>
			</select>	
					
			<br>
			<br>
			<input type="submit" value="Submit">
				
		<%
		// When all fields have values (i.e. the final submit to display results)
		}else{
			String cnum = request.getParameter("course");
			int year = Integer.parseInt(request.getParameter("year"));
			String sem = request.getParameter("semester");
			
			
			ResultSet size = myUtil.viewClassSizes(cnum.substring(4), year, sem);
			size.next(); 
			
			switch(sem){
			case "F":
				sem = "Fall";
				break;
			case "J":
				sem = "J-term";
				break;
			case "S":
				sem = "Spring";
				break;
			}
			
			%> 
			
			<p>Class Size for <%= cnum %> in <%= sem %>, <%= year %>:</p>
			<%= size.getInt(1) %>
			
	
			<% } %>

		
	</form>


</body>
</html>