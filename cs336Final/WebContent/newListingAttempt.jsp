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
String usr = (String)session.getAttribute("username");
String title = request.getParameter("title");
String style = request.getParameter("sockStyle");
String color  = request.getParameter("color");
String size = request.getParameter("sockSize");
String num = request.getParameter("quantity");
String start = request.getParameter("startPrice");
String res  = request.getParameter("resPrice");
String time  = request.getParameter("days");
Integer newauc = 0;

try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	Statement q1 = con.createStatement();
	ResultSet r1;
	r1 = q1.executeQuery("SELECT MAX(aucid) from ITEMLISTING");

	if(r1.next()){
		newauc = r1.getInt("Max(r1.aucid)");
		newauc++;
	}
	
	//Make an insert statement for the itemlisting table
	String i1 = "INSERT INTO ITEMLISTING(username, aucid, title, sockStyle, color, sockSize, quantity, startPrice, resPrice, days)" +
		" VALUES (\'" + usr + "\',\'"+ newauc +"\',\'"+ title +"\',\'"+ style +"\',\'"+ color +"\',\'"+ size +"\',\'"+ num +"\',\'"+ start +"\',\'"+ res +"\',\'"+ time +"\')";
	
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