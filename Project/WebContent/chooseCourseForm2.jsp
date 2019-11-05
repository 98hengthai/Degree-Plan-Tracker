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



	<% String sID = ""; %>
		<% String userType = myUtil.getUserType(); %>
	
<!-- If not logged in -->
	<% if(userType == null || myUtil.getConn() == null){ %>
		<jsp:forward page="loginForm.jsp" /> 
	<% } %>
	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
		<%sID = request.getParameter("studentID"); %>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
		<%sID = myUtil.getUserId();%>
		
	<%}%>


	<%
	if(myUtil.getConn() == null){
	myUtil.openDB(); %>
	Connection is: <%out.print(myUtil.getConn()); %>
	<%} %>

	<%int year = 0;%>
<!-- Get Degree_Plan -->
	<%	ResultSet rs = myUtil.getDegreePlan(sID); %>

	
	
<table border="1">
<tr>
<th>Class</th>
<th>Semester</th>
<th>Year</th>
<th>Type</th>
</tr>

<%while(rs.next()){	%>
	<%year = Integer.parseInt(rs.getString(5)); %>
	<tr>
	<td><%=rs.getString(2) + " " +  rs.getString(1)%></td>
	<td><%if(rs.getString(3).equals("F")){ %>
		Fall
		<%}else{%>
		Spring
		<%}%></td>
	<td><%=rs.getString(4) %>
	<td><%=rs.getString(6) + " " + rs.getString(7)%>
	
<%}%>
	</td>
</table>

<%ResultSet ree = myUtil.getReplacees(sID); %>

<%ResultSet rep = myUtil.getReplacers(sID); %>	
<form action="chooseCourseHandler.jsp">
Replace Course: 
<select name="replacee" >
	<%while(ree.next()){ %>
	<option value= <%=ree.getString(1)+ree.getString(2)%> >
		<%=ree.getString(2) + ree.getString(1) %> 
		</option>
		<%} %>

</select>
<br>
With Course: 
<select name="replacer">
	<%while(rep.next()){ %>
	<option value=<%=(rep.getString(1)+rep.getString(2))%> >
		<%=rep.getString(2)+rep.getString(1)%>
		</option>
		<%} %>
</select>

	<select name="year">
	<option value=<%=year - 4 %>>
	<%=year - 4 %></option>
	<option value=<%=year - 3 %> >
	<%=year - 3 %>
	</option>
	<option value=<%=year - 2 %> >
	<%=year - 2 %>
	</option><option value= <%=year - 1 %>>
	<%=year - 1 %>
	</option><option value=	<%=year%> >
	<%=year%>
	</option>
	</select>
	
	
	<select name="semester">
	<option value="F" >
	Fall </option>
	<option value="J">
	Jan-Term</option>
	<option value="S">
	Spring</option>
	</select>
	<select name="studentID">
	<option value=<%=sID%>>
	<%=sID%>
	</option>
	</select>
<input type="submit" value="Submit">
</form>


	
	
</body>
</html>