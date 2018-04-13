<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Login</title>
</head>
<body>
<%
String usr = request.getParameter("username");
String pword = request.getParameter("password");
String addr = request.getParameter("address");
String eaddr = request.getParameter("eaddress");

try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	//check for used email
	Statement q1 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from EMAILACCOUNT where eaddress=\'"+ eaddr +"\'");
	ResultSet result = q1.executeQuery("SELECT * from EMAILACCOUNT where eaddress=\'"+ eaddr +"\'");

	if(result.next()){
		con.close();
		//System.out.println("Used email");
		response.sendRedirect("adminHome.jsp");
		return;
	}
	
	//check for used account (enduser)
	Statement q2 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from ENDUSER where username=\'"+ usr +"\'");
	result = q2.executeQuery("SELECT * from ENDUSER where username=\'"+ usr +"\'");

	if(result.next()){
		con.close();
		System.out.println("Used details: user");
		response.sendRedirect("adminHome.jsp");
		return;
	}
	
	//check for used account (rep)
	Statement q3 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from ENDUSER where username=\'"+ usr +"\'");
	result = q3.executeQuery("SELECT * from CUSTOMERREPRESENTATIVE where username=\'"+ usr +"\'");

	if(result.next()){
		con.close();
		System.out.println("Used details: rep");
		response.sendRedirect("adminHome.jsp");
		return;
	}
	
	//check for used account (admin)
	Statement q4 = con.createStatement();
	//System.out.println("Attempting query:SELECT * from ENDUSER where username=\'"+ usr +"\'");
	result = q4.executeQuery("SELECT * from ADMIN where username=\'"+ usr +"\'");

	if(result.next()){
		con.close();
		System.out.println("Used details: admin");
		response.sendRedirect("adminHome.jsp");
		return;
	}
	
	//Make an insert statement for the emailaccount table:
	String insert1 = "INSERT INTO EMAILACCOUNT(eaddress)" + " VALUES (\'" + eaddr + "\')";
	Statement s1 =con.createStatement();
	//System.out.println("Attempting query:"+insert1);
	s1.executeUpdate(insert1);
	
	//Make an insert statement for the enduser table:
	String insert2 = "INSERT INTO CUSTOMERREPRESENTATIVE(username, password, address, eaddress, appointerUsername)" + " VALUES (\'"+usr+"\',\'"+pword+"\',\'"+addr+"\',\'"+eaddr+"\',\'"+(String)session.getAttribute("username")+"\')";
	Statement s2 =con.createStatement();

	System.out.println("Attempting query:"+insert2);
	s2.executeUpdate(insert2);

	//close the connection.
	con.close();
	response.sendRedirect("adminHome.jsp");
	
}catch(Exception e){
e.printStackTrace();
}

%>
</body>
</html>