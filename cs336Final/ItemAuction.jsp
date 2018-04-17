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
<%
try {
	
	String username = (String)session.getAttribute("username");
	%>
<table>
		<tr>
			<%
			if(session.getAttribute("usrlvl").equals("user")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'userHome.jsp\';\"></td>");
			}else if(session.getAttribute("usrlvl").equals("rep")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'repHome.jsp\';\"></td>");
			}else if(session.getAttribute("usrlvl").equals("admin")){
				out.println("<td><input type=\"button\" value=\"Home\" onClick=\"window.location=\'adminHome.jsp\';\"></td>");
			}
			%>
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
ResultSet r1, r2, r3, r4, r5;
	
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
		<tr><td>Item Name: <%out.println(r1.getString("itemName"));%></td></tr>
		<tr><td>Starting Price: $<%out.println(r1.getDouble("startingPrice"));%></td></tr>
		<tr><td>Reserve Price: $<%out.println(r1.getDouble("reservePrice"));%></td></tr>
		<tr><td>Sock Type: <%out.println(r1.getString("itemType"));%></td></tr>
		<tr><td>Color: <%out.println(r1.getString("itemColor"));%></td></tr>
		<tr><td>Size: <%out.println(r1.getString("itemSize"));%></td></tr>
		<tr><td>Auction Ends In: <%out.println(r1.getString("duration"));%> days.</td></tr>
		<tr><td>Seller: <%out.println(r1.getString("posterUsername"));%></td></tr>
		<%
		alerts = con.createStatement().executeQuery("SELECT * from ALERTS where username=\'"+ username + "\' AND itemWanted=\'"+ itemName +"\'");
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
	} %>
</table>

<br><p>Interested in this item? Place a bid!</p>
<form method=post action=bidCreateAttempt.jsp>
<%out.println("<input type=\"hidden\" name=\"startingPrice\" value=\""+ r1.getDouble("startingPrice") +"\">");%>
<table>
	<tr><td>Bid Amount (Required 00.00): <input type="text" name="bidAmount"></td></tr>
	<tr><td>AudoBid Max (Required ): <input type="text" name="autoBidMax"></td></tr>
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
	out.println("<tr>Amount: $" + r3.getString("bidAmount") + " Bidder: " + r3.getString("placedByUsername") + "</tr><br>");
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
else{
	r4 = stat2.executeQuery("SELECT * from AUCTION where auctionNum=\'"+ auctionNum + "\'");%>
	<form method=post action=enableAlert.jsp>
		<%out.println("<input type=\"hidden\" name=\"itemName\" value=\""+ r4.getString("itemName") +"\">");%>
		<p>Duration of alert in 24-hour days</p>
		<input type="text" name="duration">
		<input type="submit" value="Submit">
	</form>
<%}%>

<p>Similar Items</p>
<table>
<%
r5 = stat.executeQuery("SELECT * from AUCTION where itemName=\'"+ itemName + "\' AND auctionNum <> "+ auctionNum + " AND posterUsername <> \'"+username+"\'");
while(r5.next()){
	out.println("<tr>" + r5.getString("itemName") + " Size: " + r5.getString("itemSize") + " Color: "+r5.getString("itemColor"));
	out.println("<form method=post action=ItemAuction.jsp><input type=\"hidden\" name=\"auctionNumber\" value=\""+ r5.getString("auctionNum")+"\">");
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