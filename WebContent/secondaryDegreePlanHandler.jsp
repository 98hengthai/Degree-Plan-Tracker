<!-- handler for creating a secondary degree plan (Use Case 2)
Created by NS 5/9/19
-->
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Processing secondaryDegreePlan form</title>
</head>
<body>

	<!-- Navigation Header -->
	<% if(myUtil.getUserType().equals("F")){%> 
		<jsp:include page="facultyHeader.jsp"></jsp:include>
	<%}else if(myUtil.getUserType().equals("S")){ %>
		<jsp:include page="studentHeader.jsp"></jsp:include>
	<%}%>
	
<h3>Data From the CreateSecondaryDegreePlan Form</h3>

STUDENT INFORMATION<br><br>
ID is <%= request.getParameter("id")%><br>

<br> <br>
DEGREE PLAN INFORMATION<br><br>
Degree length is <%= request.getParameter("deglen") %><br>
Degree type is <%= request.getParameter("degtype") %><br><br>


<%
    String id=request.getParameter("id");


    int year = Integer.parseInt(request.getParameter("gradyear"));

    //if degree length or degree type not specified, use defaults
    int deglen;
    if(request.getParameter("deglen")==null){
        deglen = 4;
    }else{
        deglen=Integer.parseInt(request.getParameter("deglen"));
    }
    String degtype;
    if(request.getParameter("degtype")==null){
        degtype="BS";
    }
    else{
        degtype=request.getParameter("degtype");
    }

    //call to ODPUtilities
    int result = myUtil.createSecondaryPlan(id, deglen, degtype, year);

    if(result==1){
        out.print("Success creating secondary plan of length " + deglen + "-Year and type " + degtype);}
    else{ out.print("Error: unable to create secondary plan.");}
%>




</body>
</html>