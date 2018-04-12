<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Search Results</title>
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
	
	<h1>View Current Auctions</h1>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stat = con.createStatement();
			Statement stat2 = con.createStatement();
			//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
			//NOTE: for now, only looks for auctions, not active auctions
			String searchCriteria = "SELECT * from AUCTION";
			boolean whereAdded = false;
			//style specified
			if(!request.getParameter("sockStyle").equals("nopref")){
				searchCriteria = searchCriteria + " WHERE " + "itemType=\'"+ request.getParameter("sockStyle") + "\'";
				whereAdded = true;
			}
			//color specified
			if(request.getParameter("color") != null){
				if(whereAdded){
					searchCriteria = searchCriteria + " AND " + "itemColor=\'"+ request.getParameter("color") + "\'";
				}else{
					searchCriteria = searchCriteria + " WHERE " + "itemColor=\'"+ request.getParameter("color") + "\'";
					whereAdded = true;
				}
			}
			//size specified
			if(!request.getParameter("sockSize").equals("nopref")){
				if(whereAdded){
					searchCriteria = searchCriteria + " AND " + "itemSize=\'"+ request.getParameter("sockSize") + "\'";
				}else{
					searchCriteria = searchCriteria + " WHERE " + "itemSize=\'"+ request.getParameter("sockSize") + "\'";
					whereAdded = true;
				}
			}

			
			out.println("Query is: " + searchCriteria);
			ResultSet result = stat.executeQuery(searchCriteria);
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
				out.println("<td>Seller</td>");
				out.println("<td>|</td>");
				out.println("<td>Sold To</td>");
				out.println("<td>|</td>");
				out.println("<td></td>");
				out.println("<td>|</td>");
				out.println("</tr>");
				do{
					
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
						out.print("<td>");
						out.print(result.getString("soldTo"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.println("<td><form method = \"post\" action=\"ItemAuction.jsp\">");
						out.println("<input type=\"hidden\" name=\"auctionNumber\" value=\""+ result.getString("auctionNum") +"\">");
						out.println("<input type=\"submit\" value=\"Go To Auction\" />");
						out.println("</form></td>");
						out.println("<td>|</td>");
						out.println("</tr>");
					
				}while(result.next());



			//There are no ongoing auctions
			}else{
				out.println(" No results found!");
			}
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>