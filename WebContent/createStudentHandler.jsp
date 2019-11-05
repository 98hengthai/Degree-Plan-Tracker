<!-- Handler for createStudent(Use Case 1) -->
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import="java.sql.*" %>
<% if(myUtil.getUserType().equals("F")){
%> <jsp:include page="facultyHeader.jsp"></jsp:include>

<%}else if(myUtil.getUserType().equals("S")){ %>
<jsp:include page="studentHeader.jsp"></jsp:include>
<%}%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Processing createStudent form</title>
</head>
<body>

<h2>Data From the CreateStudent Form</h2>

STUDENT INFORMATION<br><br>
ID is <%= request.getParameter("id")%><br>
Student Name is <%= request.getParameter("fname") + " " + request.getParameter("lname") %><br>
Email is <%= request.getParameter("email") %><br>
Password is <%= request.getParameter("password")%><br>
<br> <br>
DEGREE PLAN INFORMATION<br><br>
Degree length is <%= request.getParameter("deglen") %><br>
Degree type is <%= request.getParameter("degtype") %><br><br>


<%
    String id=request.getParameter("id");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String password = request.getParameter("password");
    String email = request.getParameter("email");

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
    int result = myUtil.createStudent(id, fname, lname, email, password, deglen, degtype, year);

    if(result!=0){
        out.print("Success creating student " + lname + ", " + fname);}
    else{ out.print("Error: unable to create student.");}
%>




</body>
</html>