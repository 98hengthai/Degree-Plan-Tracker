<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/6/2019
  Time: 6:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<%@ page import ="java.sql.*" %>
<html>
<head>
    <title>Close DB</title>
</head>
<body>
<%
    myUtil.closeDB();
    if(myUtil.getConn()==null){%>
DB successfully disconnected.
<%
} else { %>
DB not disconnected.
<%
    }
%>
</body>
</html>
