<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile</title>
</head>
<body>
<table>
		<tr>
			<%
			if(session.getAttribute("usrlvl").equals("user")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'userHome.jsp\';\"></td>");
			}else{
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'repHome.jsp\';\"></td>");
			}
			%>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
<%
try {
	
	String username = (String)session.getAttribute("username");
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	ResultSet userResult = con.createStatement().executeQuery("SELECT * from ENDUSER where username=\'"+ username + "\'");
	ResultSet previousBids = con.createStatement().executeQuery("SELECT * from BID, AUCTION WHERE BID.auctionNum = AUCTION.auctionNum AND BID.placedByUsername=\'"+ username + "\'");
	//NOT SURE HOW TO DO THIS ONE ResultSet soldItems = stat.executeQuery("SELECT * from ")
	ResultSet alerts = con.createStatement().executeQuery("SELECT * from ALERTS where username=\'"+ username + "\'");
	ResultSet itemsWon = con.createStatement().executeQuery("SELECT * from AUCTION where soldTo=\'"+ username + "\'");
	ResultSet soldItems = con.createStatement().executeQuery("SELECT * from AUCTION where soldTo IS NOT NULL AND posterUsername=\'"+ username + "\'");
	if(userResult.next()){
		%><p><%out.println("<h2>" + userResult.getString("username")); %>'s Account Page</h2></p><%
	}
	else
		System.out.println("Unable to find user with given username");
	
	out.println("<br><p><h4>Previously Sold Items</h4></p>");
	boolean exist = false;
	while(soldItems.next()){
		exist = true;
		out.println("<p>Item: "+soldItems.getString("itemName") + " Type: "+soldItems.getString("itemType") +" Size: " +soldItems.getString("itemSize") + " Color: "+soldItems.getString("itemColor") +"</p>");
	}
	if(!exist)
		out.println("<p>Currently no items sold");
	
	out.println("<br><p><h4>Previous Bids</h4></p>");
	exist = false;
	while(previousBids.next()){
		exist = true;
		out.println( "<p>Item: " + previousBids.getString("itemName") + "&nbsp;&nbsp;Amount : $" + previousBids.getDouble("bidAmount") + "</p>" );
	}
	if(!exist)
		out.println("No previous bids");
	
	out.println("<br><p><h4>Items Won</h4></p>");
	exist = false;
	while(itemsWon.next()){
		exist = true;
		out.println("<p>Item: " + itemsWon.getString("itemName") + "</p>");
	}
	if(!exist)
		out.println("No items won");
	

	
	if(session.getAttribute("username").equals(username)){
		out.println("<br><p><h4>Alerts</h4><p>");
		exist = false;
		while(alerts.next()){
			exist = true;
			out.println("<p>Item: " + alerts.getString("itemWanted") + " Duration: " + alerts.getString("duration"));
		}
		if(!exist)
			out.println("No Alerts Set");
		%>
		<br>If you would like to change your password, enter your new password: 
		<form method=post action=changePassAttempt.jsp> 
			<input name="newPass" type="password">
			<input type="submit" value="Submit">
		</form>
	<%}
	
%>
</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>