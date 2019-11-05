<%--
  Created by IntelliJ IDEA.
  User: shane
  Date: 5/9/2019
  Time: 12:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="facultyHeader.jsp"/>
<html>
<head>
    <title>Faculty Home</title>
</head>
<body>
<h2>Faculty Home</h2>
<table>
    <ol>
        <li><a href="createStudent.jsp">Create Student</a></li>
        <li><a href="secondaryDegreePlan.jsp">Create Secondary Plan</a></li>
        <li><a href="updatePlanCourseSem.jsp">Update Semester of Course on Plan</a></li>
        <li><a href="chooseCourseForm.jsp">Select Elective</a></li>
        <li><a href="viewClassSizes.jsp">View Class Sizes</a></li>
        <li><a href="createCourseForm.jsp">Create Course</a></li>
        <li><a href="deleteStudent.jsp">Delete Student</a></li>
        <li><a href="index.jsp">Log In</a></li>
        <li><a href="logOut.jsp">Log Out</a></li>
    </ol>
</table>
</body>
</html>
