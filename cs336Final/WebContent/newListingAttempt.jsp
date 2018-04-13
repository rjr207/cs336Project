<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Item Listing</title>
</head>
<body>
<%

String title = request.getParameter("itemName");
String style = request.getParameter("itemType");
String color  = request.getParameter("itemColor");
String size = request.getParameter("itemSize");
String start = request.getParameter("startingPrice");
String res  = request.getParameter("reservePrice");
String time  = request.getParameter("duration");

try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	

	//Make an insert statement for the auction table
	String i1 = "INSERT INTO AUCTION(startingPrice, reservePrice, itemName, itemType, itemColor, itemSize, duration, posterUsername)" +
		" VALUES (\'"+ start +"\',\'"+ res +"\',\'"+ title +"\',\'"+ style +"\',\'"+ color +"\',\'"+ size +"\',\'"+ time +"\',\'" + usr + "\')";
	
	//Execute insert
	Statement s1 =con.createStatement();
	s1.executeUpdate(i1);}

	//Need to redirect to item display page here....
catch(Exception e){
e.printStackTrace();
}
%>
</body>
</html>