<!-- secondaryDegreePlan Form (use case 2)
Created by NS 5/9/19
-->

<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>
<% if(myUtil.getUserType().equals("F")){
%> <jsp:include page="facultyHeader.jsp"></jsp:include>

<%}else if(myUtil.getUserType().equals("S")){ %>
<jsp:include page="studentHeader.jsp"></jsp:include>
<%}%>

<% String userType = myUtil.getUserType();

%>

<!-- If not logged in -->
<% if(userType == null || myUtil.getConn() == null){ %>
<jsp:forward page="loginForm.jsp" />
<% } %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Secondary Degree Plan</title>
</head>

<body>

<h3>Create a secondary degree plan</h3>

<form action="secondaryDegreePlanDegreeInputs2.jsp" method="POST">
	<% String id = request.getParameter("id"); %>
	
	<input type="hidden" value=<%=id %> name="id" >

    Degree Length (select one): <br>
    <input type="radio" name="deglen" value="2"> 2-Year Plan
    <input type="radio" name="deglen" value="3"> 3-Year Plan
    <input type="radio" name="deglen" value ="4"> 4-Year Plan<br>
    If no degree length is selected, student will be assigned a 4-Year Plan


   
    <input type="submit" value="Submit">
</form>

</body>
</html>