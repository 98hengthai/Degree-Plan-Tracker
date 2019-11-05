<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/7/2019
  Time: 1:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%if(myUtil.getUserId()==null){%>
<jsp:forward page="loginForm.jsp" />
<%} else if(myUtil.getUserType().equals("S")){%>
<jsp:forward page="studentHome.jsp"/>
<%} else if(myUtil.getUserType().equals("F")){%>
<jsp:forward page="facultyHome.jsp"/>
<%}%>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2><br>

</body>
</html>
