package dbUtil; /**
 * ODP Utilities class. Methods for accessing database
 * and executing use case SQL commands.
 * Created 4/17/19 by NS
 * Edited 4/23 & 4/24 by ES
 * Edited/finalized 4/24 by NS
 *
 * */
//package del4utils;
/**
 * This class provides some basic methods for accessing a MariaDB database.
 * It uses Java JDBC and the MariaDB JDBC driver, mariadb-java-client-2.4.0.jar
 * to open an modify the DB.
 *
 */

// You need to import the java.sql package to use JDBC methods and classes
import javax.print.DocFlavor;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * @author Natalie Stephenson
 * modified from Dr. Blaha's code
 *
 */
public class ODPUtilities {

    private Connection conn = null; // Connection object
    private String id = null;
    private String type = null;

    /**
     * @return the conn
     */
    public Connection getConn() {
        return conn;
    }

    /**
     * Open a MariaDB DB connection where user name and password are predefined
     * (hardwired) within the url. In this case tailored for Operation Default Project.
     */
    public void openDB() {

        // Connect to the database
        String url = "jdbc:mariadb://mal.cs.plu.edu:3306/odp367_2019?user=odp367&password=odp367";
        
      //off-campus
      //class database
//      	String url = "jdbc:mariadb://localhost:2000/odp367_2019?user=odp367&password=odp367";

        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            System.out.println("using url:"+url);
            System.out.println("problem connecting to MariaDB: "+ e.getMessage());
            //e.printStackTrace();
        }

    }// openDB

    /**
     * Close the connection to the DB
     */
    public void closeDB() {
        try {
            conn.close();
            conn = null;
        } catch (SQLException e) {
            System.err.println("Failed to close database connection: " + e);
        }
    }// closeDB



    /**
     * Write and Test
     * Overload the open method that opens a MariaDB DB with the user name
     * and password given as input.
     *
     * @param username is a String that is the DB account username
     * @param password is a String that is the password the account
     */

    public void openDB(String username, String password) {
        // Connect to the database
        //System.out.println("inside overloaded openDB");
        String url = "jdbc:mariadb://mal.cs.plu.edu:3306/odp367_2019?user=" + username + "&password=" + password;

        try {
            conn = DriverManager.getConnection(url);
        } catch (SQLException e) {
            System.out.println("using url:"+url);
            System.out.println("problem connecting to MariaDB: "+ e.getMessage());
            //e.printStackTrace();
        }
        //System.out.println("WOO in overloaded openDB");

    }

    /**
     * Setter method for id, the id of the user logged in and
     * associated with this instance of the Utilities class/this connection
     * @param id a String that is the account id
     */
    public void setUserId(String id){
        this.id = id;
    }

    /**
     * Getter method for id, the id of the user logged in and
     * associated with this instance of the Utilities class/this connection
     * @return this.id
     */
    public String getUserId(){
        return this.id;
    }

    /**
     * Getter method of type, the type of the user logged in
     * and associated with this instance of the ODPUtilities class/Connection
     * @return this.type
     */
    public String getUserType(){
        return this.type;
    }

    /*public String getUserType(){
        ResultSet rset = null;
        String sql="";
        String type="";

        try{
            sql = "SELECT type FROM USER where id = " + this.id;
            Statement stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);

            while(rset.next()){
                type = rset.getString(1);
            }
            return type;
        } catch(SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
        }
        return type;
    }*/

    /**
     * Setter method for this.type, the type of user who is associated with this instance of ODPUtilities and
     * its Connection. This method queries the database based on this.id which must have been set prior to this
     * method being called (which is why it is a private method). It then sets this.type to the type
     * in the database for the user associated with this.id
     */
    private void setUserType(){
        ResultSet rset = null;
        String sql="";
        String type;

        try{
            sql = "SELECT type FROM USER where id = " + this.id;
            Statement stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);

            while(rset.next()){
                type = rset.getString(1);
                this.type = type;
            }

            //System.out.println(this.type);
        } catch(SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
        }

    }


    /**
     * createStudent() fulfills Use Case 1: Create Student.
     * To create a new Student and enter them into the database,
     *  and generate their associated DEGREE_PLAN from a template.
     * @param id, first, last, email, password, len, degtype, year
     * which correspond to: USER(id, fname, lname, email, password),
     *  DEGREE_PLAN(sid,length, degree_type, grad_year)
     * */
    public int createStudent(String id, String first, String last, String email, String password, int len, String degtype, int year) {
        //ResultSet rset = null;
        int result = 0;
        String usersql = null;
        String degreesql = null;



        try {
            // create first statement and execute
            usersql = "INSERT INTO USER(id,email,password,fname,lname,type) " +
                    "VALUES('" + id + "', '" + email + "', PASSWORD('"+  password + "'), '" + first + "', '" + last + "'," + " 'S');";

            Statement stmt = conn.createStatement();

            //execute
            result = stmt.executeUpdate(usersql);

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + usersql);
            return result;
        }

        //create and execute second statement
        //second try/catch so that error messages will not be confusing
        try {
            // create first statement and execute
            degreesql = "INSERT INTO DEGREE_PLAN " +
                    "VALUES('" + id + "', '" + len + "', '" + degtype + "', TRUE, " + year + ");";

            Statement stmt2 = conn.createStatement();


            result=+  stmt2.executeUpdate(degreesql);

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + degreesql);
            return result;
        }

        // return result; //if all has gone well: returns 1

        int te = buildDegreeFromTemplate(id, len, degtype);
        if(te==1) {
            return result;}
        else {return 0;}

    } //createStudent




    /**
     * createSecondaryPlan() fulfills Use Case 2: Create Secondary Degree Plan.
     * Create another degree plan by the student
     * @param id, len, degtype, year which correspond to
     * DEGREE_PLAN(sid,length, degree_type, grad_year)
     * */
    public int createSecondaryPlan(String id, int len, String degtype, int year) {

        int result = 0;
        String sql = null;

        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = "INSERT INTO DEGREE_PLAN " +
                    "VALUES( '" + id + "', '" + len + "', '" + degtype+ "', " + "'0', " + year+ ")";
            result = stmt.executeUpdate(sql);
        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
            return result;
        }

        int te = buildDegreeFromTemplate(id, len, degtype);
        if(te==1) {
            return result;}
        else {return 0;}
    }//createSecondaryPlan


    /**
     * buildDegreeFromTemplate() is a helper function for Use Cases 1 & 2.
     * It populates a newly-created degree plan with a template appropriate
     * for the type/length of the created degree.
     * @param id
     * @param len
     * @param degtype
     * @return 0 if failure, 1 if success
     * **/
    public int buildDegreeFromTemplate(String id, int len, String degtype) {
        String sql = "";
        ResultSet idresult = null;
        String tempid = "";
        //first, query for the id of the dummy template in USER
        try {
            Statement stmt = conn.createStatement();
            sql="SELECT id FROM USER WHERE fname='" + degtype + "' and lname='" + len + "'";
            idresult = stmt.executeQuery(sql);
            if(idresult.next()){
                tempid = idresult.getString(1);
            }
            //System.out.println(tempid);
        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
            return 0;
        }

        //next, get all courses belonging to that template id from PART_OF...
        String sql2 = "";
        ResultSet courselist = null;
        try {
            Statement stmt2 = conn.createStatement();
            sql2="SELECT c_num, c_dept, year_planned, sem_planned FROM PART_OF WHERE stud_id='" + tempid + "'";
            courselist = stmt2.executeQuery(sql2);
        }catch(SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql2);
            return 0;
        }
        //finally, insert all those courses as being PART_OF our student's degree plan
        String sql3 = "";
        int finalresult = 0;
        try {

            while(courselist.next()) {//while there are courses to put on the plan
                sql3="INSERT INTO PART_OF VALUES('" + courselist.getString(1) + "', '" + courselist.getString(2) + "', '" + id +
                        "', '" + len + "', '" + degtype + "', '" + courselist.getInt(3) + "', '" + courselist.getString(4) + "')";
                //depending on how many courses we're entering, this might be better as a PreparedStatement.
                //but right now I just want to make sure this works
                Statement stmt3 = conn.createStatement();
                finalresult +=stmt3.executeUpdate(sql3);
            }
        }catch(SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql3);
            return 0;
        }

        return 1;
    }


    /**
     * moveCourseOnPlan() fulfills Use Case 3: Change semester of course on degree plan.
     * Assign a course in the degree plan to a different semester, to rearrange
     * 	courses in the schedule.
     * @param yearplanned, semplanned, cnum, cdept, id, len, degtype which
     * correspond to those in PART_OF
     * */
    public int moveCourseOnPlan(int yearplanned, String semplanned, String cnum, String cdept, String id, int len, String degtype) {
        //ResultSet rset = null;
        int result = 0;
        String sql = null;

        //UPDATE PART_OF
        //SET year_planned = ?, sem_planned = ?
        //WHERE c_num = ?, c_dept = ?, stud_id = ?, deg_len = ?, deg_type = ?;


        try {
            //make the query and execute update
            sql = "UPDATE PART_OF SET year_planned = " + yearplanned + ", sem_planned = '"+ semplanned +
                    "' WHERE c_num = '" + cnum + "' AND c_dept = '" + cdept + "' AND stud_id = '" +
                    id + "' AND deg_len = '" + len + "' AND deg_type = '" + degtype + "'";

            Statement stmt = conn.createStatement();


            result = stmt.executeUpdate(sql);

        }catch(SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
            return result;

        }

        return result;
    }//moveCourseOnPlan


    /**
     * chooseCourseOption() fulfills Use Case 4: Choose course from course options on degree plan
     * (by student)
     * For example pick a preferred elective course from the elective course list
     * Student can choose any available course from the course option list.
     * @param
     *
     *
     * */
    public int chooseCourseOption(String coursenum1, String dept1, String coursenum2, String dept2, String id, int len , String degtype, int year, String sem) {
        ResultSet rset = null;
        String delsql = null;
        String inssql = null;
        int result = 0;

        //1. Delete existing tuple
        //2. Reinsert tuple with new location values

        //DELETE FROM PART_OF
        //WHERE c_num = coursenum and c_dept = dept and stud_id = id and deg_len = len and deg_type = degtype;

        try {

            delsql = String.format("DELETE "
            		+ "FROM PART_OF " + 
            		"WHERE c_num = '%s' and c_dept = '%s' and stud_id = '%s' "
            		+ "and deg_len = '%d' and deg_type = '%s' and year_planned = %d "
            		+ "and sem_planned = '%s' ", coursenum1, dept1, id, len, degtype, year, sem);

            Statement stmt = conn.createStatement();

            result = stmt.executeUpdate(delsql);
            
        }catch(SQLException e) {
            System.out.println("createStatement " + e.getMessage() + delsql);
            return result;
        }

        //INSERT INTO PART_OF
        //VALUES(coursenum, dept, id, len, degtype, year, semester);

        try {

            inssql = "INSERT INTO PART_OF" +
                    " VALUES('" + coursenum2 + "', '" + dept2 +"', '" + id + "', '" + len + "', '" + degtype + "', " + year+", '" +sem + "');";

            Statement stmt = conn.createStatement();

            stmt.executeUpdate(inssql);
          

        }catch(SQLException e) {
            System.out.println("createStatement " + e.getMessage() + inssql);
            return result;
        }

        return result; //returns 1 if all went well
    }//chooseCourseOption



    /**
     * viewClassSizes() fulfills Use Case 5: View Class Sizes
     * For use by Computer Science faculty to be able to predict
     * class sizes of future semesters. Assumes that they only
     * care about CSCI classes, so that is hard-coded in.
     *
     * */
    public ResultSet viewClassSizes(String cnum, int year, String sem) {
        ResultSet rset = null;
        String sql = null;

        try{
            sql = "SELECT COUNT(*) from PART_OF join DEGREE_PLAN on stud_id=s_id and deg_len=length and deg_type=degree_type WHERE primary_plan=true and c_dept='CSCI' AND c_num = '"+cnum+"' AND year_planned= " + year + " AND sem_planned ='"
                    + sem + "'";
            Statement stmt = conn.createStatement();
            rset = stmt.executeQuery(sql);

        }catch(SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
        }
        return rset;
    }//viewClassSizes


    public ResultSet getAllCourses() {
        ResultSet rs = null;

        String sql = "select distinct dept, number\r\n" +
                "from COURSE join PART_OF on c_num=number and c_dept=dept\r\n" +
                "where dept='CSCI' and stud_id is not null";

        try {
            Statement stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);

        } catch (SQLException e) {
            System.out.println("getAllCourses " + e.getMessage() + sql);
            return rs;
        }


        return rs;
    }

    public ResultSet getSemOffered(String number) {

        ResultSet rset = null;
        String sql = null;

        try {
            // create a Statement and an SQL string for the statement
            sql = "select distinct semesters_offered\r\n" +
                    "from COURSE\r\n" +
                    "where dept=\"CSCI\" and number = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Set parameters
            pstmt.clearParameters();
            pstmt.setString(1, number);

            // Execute
            rset = pstmt.executeQuery();

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        return rset;
    }

    public ResultSet getYearOffered(String number) {

        ResultSet rset = null;
        String sql = null;

        try {
            // create a Statement and an SQL string for the statement
            sql = "select distinct year_planned\r\n" +
                    "from PART_OF\r\n" +
                    "where c_dept=\"CSCI\" and c_num = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);

            // Set parameters
            pstmt.clearParameters();
            pstmt.setString(1, number);

            // Execute
            rset = pstmt.executeQuery();

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        return rset;
    }



    /**
     * createNewCourse() fulfills Use Case 6: Create a new course (by any faculty)
     *  (Become available to degree plans)
     * Inserts the course into the COURSE table, given all the correct information/types
     * */
    public int createNewCourse(String number, String dept, String hours, String semesters, String years) {
        String sql = null;
        int rowsInserted = 0;
        try{
            sql = "INSERT INTO COURSE VALUES('"+number+"', '"+dept+"', '"+hours+"', '"+semesters+"', '"+years+"')";
            Statement stmt = conn.createStatement();
            rowsInserted = stmt.executeUpdate(sql);
        } catch (SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
        }
        return rowsInserted;
    }//createNewCourse


    /**
     * deleteStudent() fulfills Use Case 7: Delete Student
     * Deletes the USER with the matching id number. The use case was just to delete a student,
     * but faculty will need to be deleted upon retirement as well, so this method is
     * generalized to work in that case as well.
     * */
    //ALSO FILL IN PARAMS
    public int deleteUser(String id) {
        int rowsDeleted=0;
        String sql = null;
        try{
            sql = "DELETE FROM USER WHERE id='"+id+"'";
            Statement stmt = conn.createStatement();
            rowsDeleted = stmt.executeUpdate(sql);
        }catch(SQLException e){
            System.out.println("createStatement "+e.getMessage()+sql);
        }

        return rowsDeleted;
    }//deleteStudent

    /**
     * This method logs a user in by authenticating their username and password
     * @param email
     * @param pw
     * @return
     */
    public boolean logIn(String email, String pw) {
        ResultSet rset = null;
        String sql="";
        try{
            Statement stmt = conn.createStatement();
            sql = "SELECT COUNT(*),id FROM USER WHERE email = '" + email + "' AND password = PASSWORD('" + pw + "')";
            rset = stmt.executeQuery(sql);
            if(rset.next()){
                int success = rset.getInt(1);
                if(success == 1 ){
                    //I query for the id in case we want to change login to be email+password instead of id+password
                    this.setUserId(rset.getString(2));
                    //System.out.println(this.id);
                    this.setUserType();
                    //System.out.println(this.type);
                    return true;
                }
            }
        }catch(SQLException e){
            System.out.println("createStatement "+e.getMessage()+sql);
        }
        return false;
    }

    /**
     * This method logs out the user who is currently associated with this ODPUtilities instance and
     * Connection object by setting the id and type global variables to null.
     */
    public void logOut(){
        this.id = null;
        this.type = null;
    }

    //help for checking student email
    public boolean verifystudentId(String id) {
        String sql = null;
        try {
            Statement stmt = conn.createStatement();
            sql = "select * from USER where id = \'" + id + "\'";
            ResultSet rset = stmt.executeQuery(sql);
            return rset.first();

        } catch (SQLException e){
            System.out.println("createStatement " + e.getMessage() + sql);
        }
        return false;
    }


    /**
     * Helper for use case #3: Change Course Semester.
     * Return String array of the student current degree plan option.
     *
     * */
    public String[] getDegrePlanOption(String id) {
        ResultSet rset = null;
        String sql = null;
        ArrayList<String> degreeList = new ArrayList<>();
        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = String.format("select degree_type, length "
                    + "from DEGREE_PLAN "
                    + "where s_id = '%s'", id);
            rset = stmt.executeQuery(sql);

            while(rset.next()) {
                String degree = rset.getString(1) + "-" + rset.getString(2);
                degreeList.add(degree);
            }

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        String[] array = degreeList.toArray(new String[0]);
        Arrays.toString(array);
        return array;
    }


    /**
     * Helper for use case #3: Change Course Semester.
     * Return String array of Courses(c_dept, c_num, sem_planned, year_planned) that is part of the student degree plan.
     *
     * */
    public String[] getCoursesPartOfDegreePlan(String id, String degreeType, String degreeLength) {
        ResultSet rset = null;
        String sql = null;
        ArrayList<String> coursesList = new ArrayList<>();
        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = String.format("select c_dept, c_num ,sem_planned, year_planned "
                    + "from PART_OF "
                    + "where stud_id = '%s' and deg_len = '%s' and deg_type = '%s'", id, degreeLength, degreeType);
            rset = stmt.executeQuery(sql);

            while(rset.next()) {
                String course = rset.getString(1) + "-" + rset.getString(2)
                        + "-" +rset.getString(3) + "-" + rset.getString(4);
                coursesList.add(course);
            }

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        String[] array = coursesList.toArray(new String[0]);
        Arrays.toString(array);
        return array;
    }


    /**
     * Helper for use case #3: Change Course Semester.
     * Get semester offering for a given course.
     * Return String array for offering semester given the course.
     * */
    public String[] getSemesterOffered(String dept, String number) {
        ResultSet rset = null;
        String sql = null;
        ArrayList<String> coursesList = new ArrayList<>();
        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = String.format("select semesters_offered "
                    + "from COURSE "
                    + "where dept = '%s' and number = '%s'", dept, number);
            rset = stmt.executeQuery(sql);

            String course = "";
            while(rset.next())
                course = rset.getString(1);
            if(course.equals("B")) {
                coursesList.add("Fall");
                coursesList.add("Spring");
            } else if (course.equals("F")) {
                coursesList.add("Fall");
            } else if(course.equals("S")) {
                coursesList.add("Spring");
            } else if(course.equals("J")) {
                coursesList.add("J-term");
            }

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        String[] array = coursesList.toArray(new String[0]);
        Arrays.toString(array);
        return array;
    }

    /**
     * Helper for use case #3: Change Course Semester.
     * Get year offering for a given course.
     * Return String array for offering year given the course.
     * */
    public String[] getYearOffering(String dept, String number, String planningYr) {
        ResultSet rset = null;
        String sql = null;
        ArrayList<String> yrsList = new ArrayList<>();
        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = String.format("select years_offered "
                    + "from COURSE "
                    + "where dept = '%s' and number = '%s'", dept, number);
            rset = stmt.executeQuery(sql);

            String yr = "";
            while(rset.next())
                yr = rset.getString(1);

            int planningYrInt = Integer.parseInt(planningYr);
            if(yr.equals("3")) {
                yrsList.add(planningYrInt + "");
                yrsList.add(planningYrInt + 1 + "" );
                yrsList.add(planningYrInt + 2 + "" );
                yrsList.add(planningYrInt + 3 + "" );
            } else if (yr.equals("2")) {
                if(planningYrInt % 2 == 0) {
                    yrsList.add(planningYrInt + "");
                    yrsList.add(planningYrInt + 2 + "" );
                }else {
                    yrsList.add(planningYrInt + 1 + "" );
                    yrsList.add(planningYrInt + 3 + "" );
                }
            } else if(yr.equals("1")) {
                if(planningYrInt % 2 != 0) {
                    yrsList.add(planningYrInt + "");
                    yrsList.add(planningYrInt + 2 + "" );
                }else {
                    yrsList.add(planningYrInt + 1 + "" );
                    yrsList.add(planningYrInt + 3 + "" );
                }

            }

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        String[] array = yrsList.toArray(new String[0]);
        Arrays.toString(array);
        return array;
    }

    /**
     * Helper for use case #7: Delete A Student.
     * Return String array of all student id and email in the database.
     *
     * */

    public String[] getAllStudent() {
        ResultSet rset = null;
        String sql = null;
        ArrayList<String> studentEmail = new ArrayList<>();
        try {
            // create a Statement and an SQL string for the statement
            Statement stmt = conn.createStatement();
            sql = String.format("select id, email from USER where type = 'S'");
            rset = stmt.executeQuery(sql);

            while(rset.next()) {
                String s = rset.getString(1) +"-"+ rset.getString(2);
                studentEmail.add(s);
            }

        } catch (SQLException e) {
            System.out.println("createStatement " + e.getMessage() + sql);
        }

        String[] array = studentEmail.toArray(new String[0]);
        Arrays.toString(array);
        return array;
    }

    public ResultSet getUsers() {
        ResultSet rs = null;
        String sql = "";

        try {
            sql = "SELECT distinct s_id FROM DEGREE_PLAN";
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
        }catch(SQLException e) {
            System.out.println("getUsers() " + e.getMessage() + sql);
        }

        return rs;
    }

    public ResultSet getDegreePlan(String user) {
        ResultSet rs= null;
        String sql = "";

        try {
            sql = "SELECT DISTINCT c_num, c_dept, sem_planned, year_planned, grad_year, degree_type, length"
                    + " FROM PART_OF join DEGREE_PLAN on s_id = stud_id"
                    + " where s_id = '" + user + "'"
                    + " order by degree_type, length, year_planned";
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
        }catch(SQLException e) {
            System.out.println("getDegreePlan() " + e.getMessage() + " " + sql);
        }


        return rs;
    }

    public ResultSet getReplacers(String user) {
        ResultSet rs = null;
        String sql = "";

        try {
            sql = "select replacer_num, replacer_dept\r\n" +
                    "from REPLACES\r\n" +
                    "where replacee_num in (SELECT distinct c_num"
                    + " FROM PART_OF join REPLACES on c_num = replacee_num "
                    + "WHERE stud_id = '" + user + "')";
            Statement stmt = conn.createStatement();
            rs=stmt.executeQuery(sql);



        }catch(SQLException e) {
            System.out.println("getReplacers() " + e.getMessage() + " " + sql);

        }
        return rs;
    }

    public ResultSet getReplacees(String user) {
        ResultSet rs = null;
        String sql = "";

        try {

            sql = "SELECT distinct c_num, c_dept" +
                    " FROM PART_OF join REPLACES on c_num = replacee_num" +
                    " WHERE stud_id = '"  + user + "'";


            Statement stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);
        }catch(SQLException e) {
            System.out.println("getReplaceOptions() + " + e.getMessage() + " " + sql);
        }

        return rs;
    }
    public ResultSet getDegreeP(String user) {
        ResultSet rs = null;
        String sql = "";
        try {
            sql = "SELECT *"
                    + " FROM DEGREE_PLAN"
                    + " WHERE s_id = '" + user + "'";

            Statement stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);

        }catch(SQLException e) {
            System.out.println("getDegreeP() " + e.getMessage() + " " + sql);
        }



        return rs;
    }

}// Utilities class