<!-- secondaryDegreePlan Form (use case 2)
Created by NS 5/9/19
-->

<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
	<%}%>
	
	<% String userType = myUtil.getUserType();%>

	<!-- If not logged in -->
	<% if(userType == null || myUtil.getConn() == null){ %>
	<jsp:forward page="loginForm.jsp" />
	<% } %>

<h3>Create a secondary degree plan</h3>	
	
<form action = "secondaryDegreePlanHandler.jsp">
<% String id = request.getParameter("id");
	String deglen = request.getParameter("deglen");

%>
<input type="hidden" value=<%=id %> name="id" >
<input type="hidden" value=<%=deglen %> name="deglen" >
 Degree Type (select one):<br>
 <%if(deglen.equals("3")||deglen.equals("4")){ %>
    <input type="radio" name="degtype" value="BA"> Bachelor of Arts (BA)
    <input type="radio" name="degtype" value="BS"> Bachelor of Science (BS)<br>
    If no degree type is selected, student will be assigned a BS Degree
    <br><br>
    <%}else if(deglen.equals("2")){ %>
   		 <input type="radio" name="degtype" value="BA"> Bachelor of Arts (BA)
   		 <%} %>
    	



    Intended Graduation Year: <input type="text" name="gradyear" size="5" pattern="[0-9]{4}" title="YYYY" required><br><br>
	<input type="submit" value="Submit"></form>
</body>
</html>