<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/7/2019
  Time: 1:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="myUtil" class="dbUtil.ODPUtilities" scope="session"></jsp:useBean>
<html>
<head>
    <title>Login Processor</title>
</head>
<body>
<%  String email = request.getParameter("email");
    String pw = request.getParameter("pw");
    if(myUtil.getConn()==null){
        myUtil.openDB();
    }
    boolean login = myUtil.logIn(email, pw);
    if(login && myUtil.getUserType().equals("S")){%>
        <jsp:forward page="studentHome.jsp" />
    <%}else if(login && myUtil.getUserType().equals("F")){%>
        <jsp:forward page="facultyHome.jsp" />
    <%}else {%>
        <jsp:forward page="loginForm.jsp" />
    <%}%>
</body>
</html>
