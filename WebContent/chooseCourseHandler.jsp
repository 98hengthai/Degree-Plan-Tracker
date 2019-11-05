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
		
	<%}%>
	
	
	<%String replacer = request.getParameter("replacer");
		String replacee = request.getParameter("replacee");
		String ree_dept = "";
		String rep_dept = replacer.substring(3);
		String ree_num = "";
		String rep_num = "";
		if(replacee.length() == 4 || replacee.length() == 5){
			ree_dept = replacee.substring(1);
			ree_num = replacee.substring(0, 1);
		}else if (replacee.length() == 7){
			ree_dept = replacee.substring(3,7);
			ree_num = replacee.substring(0, 3);
		}
		rep_num = replacer.substring(0, 3);
		String sem = request.getParameter("semester");
		String year = request.getParameter("year");
		int result = -20;
		ResultSet rs = myUtil.getDegreeP(request.getParameter("studentID"));
				
			if(rs.next()){
				result = myUtil.chooseCourseOption(ree_num, ree_dept, rep_num,
				rep_dept, rs.getString(1), Integer.parseInt(rs.getString(2)), 
				rs.getString(3),Integer.parseInt(year), sem);
	
		}
		%>
		<%if(result == -20){%>
		<h2>Error in updating courses.</h2>
	
		<%}else{%>
		<h2>Courses Updated.</h2>	
			<%}%>
			 
		
		
		
		
		
		
	
</body>
</html>