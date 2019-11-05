<!-- createStudent Form (use case 1)
Created by NS 5/9/19
-->

<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>

<% String userType = myUtil.getUserType();

%>

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


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String id = request.getParameter("id");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	String deglen=request.getParameter("deglen");
%>

<form action="createStudentHandler.jsp">
<input type="hidden" value=<%=id %> name="id" >
<input type="hidden" value=<%=fname %> name="fname" >
<input type="hidden" value=<%=lname %> name="lname" >
<input type="hidden" value=<%=email %> name="email" >
<input type="hidden" value=<%=password %> name="password" >
<input type="hidden" value=<%=deglen %> name="deglen" >

<br><br>Degree Type (select one):<br>
<% if(deglen.equals("3") || deglen.equals("4")){%>
    <input type="radio" name="degtype" value="BA"> Bachelor of Arts (BA)
    <input type="radio" name="degtype" value="BS"> Bachelor of Science (BS)<br><br>
    If no degree type is selected, student will be assigned a BS degree<br><br>
    <%}else if(deglen.equals("2")){ %>
    	<input type="radio" name="degtype" value="BA"> Bachelor of Arts (BA)
    	<%} %>

    Intended Graduation Year: <input type="text" name="gradyear" size="5" pattern="[0-9]{4}" title="YYYY" required><br><br>
    <input type="submit" ></form>
    
</body>
</html>