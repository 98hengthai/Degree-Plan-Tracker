<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/7/2019
  Time: 1:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h2>Login</h2><br>
<form action="loginHandler.jsp" method="POST">
    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="pw" required><br><br>
    <input type="submit" value="Log In">
</form>
</body>
</html>
