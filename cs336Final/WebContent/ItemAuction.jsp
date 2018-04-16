<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Info</title>
</head>
<body>
<table>
<%
try {
	
	String username = (String)session.getAttribute("username");
	%>
	<table>
		<tr>
			<td><input type="button" value="Home" onClick="window.location='userHome.jsp';"></td>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
	<table>
<%
	String auctionTmp = request.getParameter("auctionNumber");
	session.setAttribute("currentAuction", auctionTmp);
	int auctionNum = Integer.parseInt(request.getParameter("auctionNumber"));
	ResultSet r1, r2, r3;

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stat = con.createStatement();
	Statement stat2 = con.createStatement();
	r1 = stat.executeQuery("SELECT * from AUCTION where auctionNum=\'"+ auctionNum + "\'");
	ResultSet alerts = null;
	String itemName = "";
	if(r1.next()){
		itemName = r1.getString("itemName");
		%>
		<tr><td>Item Name: <%out.println(itemName);%></td></tr>
		<tr><td>Starting Price: $<%out.println(r1.getDouble("startingPrice"));%></td></tr>
		<tr><td>Reserve Price: $<%out.println(r1.getDouble("reservePrice"));%></td></tr>
		<tr><td>Sock Type: <%out.println(r1.getString("itemType"));%></td></tr>
		<tr><td>Color: <%out.println(r1.getString("itemColor"));%></td></tr>
		<tr><td>Size: <%out.println(r1.getString("itemSize"));%></td></tr>
		<tr><td>Auction End Date: <%out.println(r1.getString("duration"));%></td></tr>
		<tr><td>Seller: <%out.println(r1.getString("posterUsername"));%></td></tr>
		<%
		alerts = con.createStatement().executeQuery("SELECT * from ALERTS where username=\'"+ username + "\' AND itemWanted=\'"+ itemName +"\'");
		//alerts = con.createStatement().executeQuery("SELECT * from ALERTS where username=\'test\'");

	}
	else{
		//Unable to find item
		System.out.println("Unable to find item");
		//response.sendRedirect("login.jsp");
	}
		
	r2 = stat2.executeQuery("SELECT max(bidAmount) from BID where auctionNum=\'"+ auctionNum + "\'");
	if(r2.next()){
		%>
		<tr><td>Current Max Bid: <%out.println(r2.getString("max(bidAmount)"));%></td></tr><%
}%>
</table>

<br><p>Interested in this item? Place a bid!</p>

<form method=post action=bidCreateAttempt.jsp>
<%out.println("<input type=\"hidden\" name=\"startingPrice\" value=\""+ r1.getDouble("startingPrice") +"\">");%>
<table>
	<tr><td>Bid Amount: <input type="text" name="bidAmount"></td></tr>
	<tr><td>AudoBid Max : <input type="text" name="autoBidMax"></td></tr>
	<tr><td>Payment Method: <select name="payment">
		<option value="Credit">Credit/Debit</option>
		<option value="PayPal">PayPal</option>
		<option value="BitCoin">BitCoin</option>
	</select></td></tr>
	<tr><td><input type="submit" value="Submit"></td></tr>
</table>
</form>

<%r3 = stat.executeQuery("SELECT * from BID where auctionNum=\'"+ auctionNum + "\'"); %>

<p>Bid History</p>
<table>
<%
boolean noBids = true;
while(r3.next()){
	noBids = false;
	out.println("<tr>Amount: $" + r3.getString("bidAmount") + " Bidder: " + r3.getString("placedByUsername") + "</tr>");
}
if(noBids)
	out.println("Currently no bids for this item");
%>
</table>

<p>Get notified if an item like this one is posted</p>
<%
if(alerts != null && alerts.next()){
	out.println("<p>Alert already enabled</p>");
}
else{%>
	<form method=post action=enableAlert.jsp>
		<p hidden name="auctionNum"><%out.println(auctionNum); %></p>
		<p hidden name="itemName"><% out.println(itemName); %></p>
		<p>Duration of alert (Input Format: YYYY-MM-DD HH:MI:SS)</p>
		<input type="text" name="datetime">
		<input type="submit" value="Submit">
	</form>
<%}%>

<p>Similar Items</p>
<table>
<%
ResultSet similar = con.createStatement().executeQuery("SELECT * from AUCTION where itemName=\'"+ itemName + "\' AND auctionNum <> "+ auctionNum + " AND posterUsername <> \'"+username+"\'");
while(similar.next()){
	out.println("<tr>" + similar.getString("itemName") + " Size: " + similar.getString("itemSize") + " Color: "+similar.getString("itemColor"));
	out.println("<form method=post action=ItemAuction.jsp><input type=\"hidden\" name=\"auctionNumber\" value=\""+ similar.getString("auctionNum")+"\">");
	out.println("<input type=\"submit\" value=\"Go To Auction\" /></form></tr><br>");
}%>
</table>

</body>
</html>

<%
con.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>
