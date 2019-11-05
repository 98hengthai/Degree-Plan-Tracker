<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/7/2019
  Time: 8:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import ="java.sql.*" %>

<html>
<head>
    <title>Log Out</title>
</head>
<body>
<%-- redirect to login if conn is already null --%>
<%if(myUtil.getUserId()!=null){
    myUtil.logOut();
}%>

<jsp:forward page="index.jsp"/>

</body>
</html>
