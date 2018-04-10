<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
//retrieve number of auction results to display
//no preexisting session 
if(session.getAttribute("resNum") == null){
	String currNum = request.getParameter("resNum");
	//unitialized session variable, set to default
	if(currNum == null){
		session.setAttribute("resNum", 10);
	//form is filled out
	}else{
		session.setAttribute("resNum", currNum);
	}
}else{
	String currNum = request.getParameter("resNum");
	//unitialized session variable, set to default
	if(currNum == null){
	//form is filled out
	}else{
		session.setAttribute("resNum", currNum);
	}
}
//out.println("Session value = " + session.getAttribute("resNum"));
//out.println("Form value was = " + request.getParameter("resNum"));
%>

<title>Welcome!</title>
</head>
<body>
	<table>
		<tr>
			<td><input type="button" value="Home" onClick="window.location='userHome.jsp';"></td>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Account" onClick="window.location='accountInfo.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
	
	<h1>Sell an Item</h1>
	<input type="button" value="Enter an Item" onClick="window.location='newItem.jsp';">
	<br><br>

	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String username = (String)session.getAttribute("username");
			String password = (String)session.getAttribute("password");

			//close the connection.
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<h1>View Current Auctions</h1>
	<form method = "post" action="userHome.jsp">
		<select name="resNum" onchange="this.form.submit()">
			<option value=10>Show 10 Results</option>
			<option value=20>Show 20 Results</option>
			<option value=50>Show 50 Results</option>
			<option value=100>Show 100 Results</option>
		</select>
	</form>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stat = con.createStatement();
			Statement stat2 = con.createStatement();
			//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
			//NOTE: for now, only looks for auctions, not active auctions
			ResultSet result = stat.executeQuery("SELECT * from AUCTION");
			ResultSet highestBid;
			
			//There are ongoing auctions
			if(result.next()){
				out.println("<table>");
				out.println("<tr>");
				out.println("<td>|</td>");
				out.println("<td>Auction#</td>");
				out.println("<td>|</td>");
				out.println("<td>Item Name</td>");
				out.println("<td>|</td>");
				out.println("<td>Item Type</td>");
				out.println("<td>|</td>");
				out.println("<td>Current Bid</td>");
				out.println("<td>|</td>");
				out.println("<td>Username</td>");
				out.println("<td>|</td>");
				out.println("</tr>");
				do{
					out.println("reached here");
					highestBid = stat2.executeQuery("SELECT MAX(bidAmount) FROM BID WHERE auctionNum=\'"+ result.getString("auctionNum")+"\'");
					
					out.println("<tr>");
					out.println("<td>|</td>");
					out.print("<td>");
					out.print(result.getString("auctionNum"));
					out.println("</td>");
					out.println("<td>|</td>");
					out.print("<td>");
					out.print(result.getString("itemName"));
					out.println("</td>");
					out.println("<td>|</td>");
					out.print("<td>");
					out.print(result.getString("itemType"));
					out.println("</td>");
					out.println("<td>|</td>");
					out.print("<td>");
					if(highestBid.next()){
						out.print(highestBid.getInt(1));
					}else{
						out.print(result.getString("startingPrice"));
					}
					out.println("</td>");
					out.println("<td>|</td>");
					out.print("<td>");
					out.print(result.getString("posterUsername"));
					out.println("</td>");
					out.println("<td>|</td>");
					out.println("</tr>");
				}while(result.next());
				out.println("</table>");

			//There are no ongoing auctions
			}else{
				out.println("No auctions currently!");
			}
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>