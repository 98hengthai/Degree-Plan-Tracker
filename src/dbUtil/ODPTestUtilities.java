/**
 *
 * ODP TestUtilities class. Tests our use case 
 * SQL statements and methods.
 * Deliverable 4 -- Operation Default Project.
 * Created 4/17/19 by NS
 * Edited 4/23 & 4/24 by ES
 * Edited and finalized 4/24 by NS
 *
 * */
package dbUtil;
/**
 * This program is used to test the ODPUtilities class
 */

// You need to import the java.sql package to use JDBC
import java.sql.*;

import java.util.Scanner;

/**
 * @author Natalie Stephenson
 * modified from Dr. Blaha's code
 *
 */
public class ODPTestUtilities {

    // Global variables
    static ODPUtilities testObj = new ODPUtilities(); 		// Utilities object for testing
    static Scanner keyboard = new Scanner(System.in); 	// standard input

    public static void main(String[] args) throws SQLException {

        // variables needed for menu
        int choice;
        boolean done = false;

        while (!done) {
            System.out.println();
            displaymenu();
            choice = getChoice();
            switch (choice) {
                case 1: {
                    openDefault();
                    System.out.println(testObj.logIn("hpotter@plu.edu", "iluvquidditch"));
                    //System.out.println(testObj.getUserType());
                    break;
                }
                case 2: {
                    callcreateStudent();
                    break;
                }
                case 3: {
                    callCreateSecondaryPlan();
                    break;
                }
                case 4: {
                    callMoveCourseOnPlan();
                    break;
                }
                case 5: {
                    openOverloaded(); //CHANGED BY NATALIE
                    break;
                }
                case 6: {
                    callChooseCourseOption();
                    break;

                }
                case 7: {
                    callViewClassSizes();
                    break;
                }
                case 8: {
                    callcreateNewCourse();
                    break;
                }
                case 10: {
                    testObj.closeDB(); //close the DB connection
                    break;
                }
                case 11: {
                    done = true;
                    System.out.println("Good bye");
                    break;
                }
                case 9: {
                    calldeleteUser();
                    break;
                }
            }// switch
        }

    }// main

    static void displaymenu() {
        System.out.println("1)  open default DB");
        System.out.println("2)  call createStudent() //Use Case 1");
        System.out.println("3)  call createSecondaryPlan() //Use Case 2");
        System.out.println("4)  call moveCourseOnPlan() //Use Case 3");
        System.out.println("5)  open non-default DB");
        System.out.println("6)  call chooseCourseOption //Use Case 4");
        System.out.println("7)  call viewClassSizes() //Use Case 5");
        System.out.println("8)  call createNewCourse() //Use Case 6");
        System.out.println("9)  call deleteUser() //Use Case 7");
        System.out.println("10) close the DB");
        System.out.println("11) quit");
    }

    static int getChoice() {
        String input;
        int i = 0;
        while (i < 1 || i > 11) {//Natalie tweaked for testing purposes
            try {
                System.out.print("Please enter an integer between 1-10: ");
                input = keyboard.nextLine();
                i = Integer.parseInt(input);
                System.out.println();
            } catch (NumberFormatException e) {
                System.out.println("I SAID AN INTEGER!!!!");
            }
        }
        return i;
    }

    // open the default database;
    static void openDefault() {
        testObj.openDB();
    }
    //NATALIE'S ADDITIONS
    //OPEN overloaded database
    /*
     * openOverloaded assists in the overloading of openDB()
     * by getting the desired username/password from the user
     * and then passing those on to the utility openDB(username, password).
     * takes no parameters.
     *
     * */
    static void openOverloaded() {
        //get username/password from user
        System.out.println("Please enter username: ");

        String u = keyboard.nextLine();
        System.out.println("Please enter password: ");
        String p = keyboard.nextLine();

        testObj.openDB(u, p);

    }//openOverloaded

    /*
     * callcreateStudent() activates Use Case 1: Create Student.
     * Collects input from user, passes to createStudent() in
     * ODPUtilities.
     *
     * */
    static void callcreateStudent() throws SQLException {
        //System.out.println("Please enter stuff here:");
        //String id, String first, String last, String email, String password, int len, String degtype, int year

        int r = testObj.createStudent("99999999", "Harry", "Potter", "hpotter@plu.edu", "iluvquidditch", 4, "BA", 1995);
        //printResults(rset);
        //print results
        System.out.println("USE CASE 1: CREATE STUDENT returns: " + r + "\n");

    } //callCreateStudent

    /*
     * callCreateSecondaryPlan() activates Use Case 2: Create Secondary Degree Plan.
     * Collects input from user, passes to createSecondaryPlan() in
     * ODPUtilities.
     *
     * */
    static void callCreateSecondaryPlan() throws SQLException {
        // System.out.println("Please enter stuff here:");
        //createSecondaryPlan(String id, int len, String degtype, int year)

        int r = testObj.createSecondaryPlan("99999999", 4, "BS", 1995);
        //printResults(rset);

        //print results
        System.out.println("USE CASE 2: CREATE SECONDARY PLAN returns: " + r + "\n");

    }

    /*
     * callMoveCourseOnPlan() activates Use Case 3: Change semester of course on degree plan.
     * Collects input from user, passes to moveCourseOnPlan() in
     * ODPUtilities.
     *
     * */
    static void callMoveCourseOnPlan() throws SQLException {
        //System.out.println("Please enter stuff here:");
        //etc.

        int r = testObj.moveCourseOnPlan(2019,"S", "144", "CSCI", "99999999", 4, "BA");
        System.out.println("moveCourseOnPlan() returns: " + r);

    }

    /*
     * callChooseCourseOption() activates Use Case 4: Choose course from course options on degree plan
     * (by student)
     * For example pick a preferred elective course from the elective course list
     * Collects input from user, passes to chooseCourseOption() in
     * ODPUtilities.
     *
     * */
    static void callChooseCourseOption() throws SQLException {
        //System.out.println("Please enter stuff here:");
        //etc.

        int r = testObj.chooseCourseOption("300", "CSCI", "302", "CSCI", "99999999", 4, "BA",2021,"F" );
        System.out.println("chooseCourseOption() returned " + r);

    }


    /*
     * callViewClassSizes() activates Use Case 5: View Class Sizes
     * Collects input from user, passes to viewClassSizes() in
     * ODPUtilities.
     *
     * */
    static void callViewClassSizes() throws SQLException {
        //System.out.println("Please enter stuff here:");
        //etc.

        ResultSet rset = testObj.viewClassSizes("144", 2019, "F");
        printResults(rset);

    }


    /*
     * callcreateNewCourse() activates Use Case 6: Create a new course (by any faculty)
     *  (Become available to degree plans)
     * Collects input from user, passes to createNewCourse() in
     * ODPUtilities.
     *
     * */
    static void callcreateNewCourse() throws SQLException {
        //System.out.println("Please enter stuff here:");


        int r = testObj.createNewCourse("AAA", "BBBB", "4", "B", "2");
        System.out.println("createNewCourse added " + r + " course");

    }


    /*
     * calldeleteUser() activates Use Case 7: Delete User
     * Deletes the user and their plans from the database
     *
     * */
    static void calldeleteUser() throws SQLException {
        System.out.println("Please enter stuff here:");

        int r = testObj.deleteUser("99999999");
        System.out.println("deleteUser deleted "+r+" student");

    }

    /*
     * printResults simply prints the contents of a given
     * ResultSet to the console.
     * NOTE: code borrowed and tweaked from course slides.
     * @param rset a ResultSet returned by an SQL query
     *
     * */
    static void printResults(ResultSet rset) throws SQLException {

        ResultSetMetaData mdata = rset.getMetaData();
        int cols = mdata.getColumnCount();

        for (int i = 1; i <= cols; i++) {
            System.out.print(mdata.getColumnName(i) + "\t");}
        System.out.println();
        while( rset.next() ) {
            for(int i = 1; i <= cols; i++)
                System.out.print( rset.getString( i ) + "\t");
            System.out.print("\n");
        }
    }



}//MyUtilitiesTest	