<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.format.DateTimeFormatter,java.time.LocalDateTime"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Item Listing</title>
</head>
<body>
<%
String usr = (String)session.getAttribute("username");
String title = request.getParameter("itemName");
String style = request.getParameter("itemType");
String color  = request.getParameter("itemColor");
String size = request.getParameter("itemSize");
String start = request.getParameter("startingPrice");
String res  = request.getParameter("reservePrice");
int time  = Integer.parseInt(request.getParameter("duration"));
int initialBid = 0;
try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	 DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
	 LocalDateTime dateEntry = LocalDateTime.now();
	 dateEntry.plusDays(time);
	 String dateTime = dtf.format(dateEntry);
	 
	   
	//Make an insert statement for the auction table
	String i1 = "INSERT INTO AUCTION(startingPrice, reservePrice, itemName, itemType, itemColor, itemSize, duration, posterUsername)" +
		" VALUES (\'"+ start +"\',\'"+ res +"\',\'"+ title +"\',\'"+ style +"\',\'"+ color +"\',\'"+ size +"\',\'"+ dateEntry +"\',\'" + usr + "\')";
	out.println("Attempting auction: " + i1);
	//Execute insert
	Statement s1 = con.createStatement();
	s1.executeUpdate(i1);

	Statement q1 = con.createStatement();
	ResultSet r1 = q1.executeQuery("SELECT LAST_INSERT_ID()");
	
	while(r1.next()){
		//Make an insert statement for the bid table
		String i2 = "INSERT INTO BID(bidAmount) where auctionNum=\'"+ r1.getString(1) +"\')" +
			" VALUES (\'"+ initialBid +"\')";
		//Execute insert
		Statement s2 = con.createStatement();
		s1.executeUpdate(i2);
	}
	
	//Need to redirect to item display page here....
	}
catch(Exception e){
e.printStackTrace();
}
%>
</body>
</html>