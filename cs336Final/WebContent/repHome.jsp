<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%
//retrieve page number
if(session.getAttribute("pageNum") == null){
	session.setAttribute("pageNum", "1");
	//out.println("Page is: "+ session.getAttribute("pageNum"));
}else{
	String currPage = request.getParameter("navBtn");
	
	int intPage = Integer.parseInt((String)session.getAttribute("pageNum"));
	//Prev
	if("Previous Page".equals(currPage)){
		if(intPage > 1){
			intPage--;
			session.setAttribute("pageNum",(""+intPage));
		}
	//next
	}else if("Next Page".equals(currPage)){
		intPage++;
		session.setAttribute("pageNum",(""+intPage));
	//neither
	}else{
		session.setAttribute("pageNum", "1");
	}
	

}

//retrieve number of auction results to display
//no preexisting session 
if(session.getAttribute("resNum") == null){
	String currNum = request.getParameter("resNum");
	//unitialized session variable, set to default
	if(currNum == null){
		session.setAttribute("resNum", "10");
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
<title>Welcome Representative!</title>
</head>
<body>
	<table>
		<tr>
			<td><input type="button" value="Home" onClick="window.location='repHome.jsp';"></td>
			<td><input type="button" value="Messages" onClick="window.location='messages.jsp';"></td>
			<td><input type="button" value="Log Out" onClick="window.location='login.jsp';"></td>
		
		</tr>
	</table>
	<h1>View Current Auctions</h1>
	<form method = "post" action="repHome.jsp">
		<select name="resNum" onchange="this.form.submit()">
			<option value="0">Select Number of Results</option>
			<option value="10">Show 10 Results</option>
			<option value="20">Show 20 Results</option>
			<option value="50">Show 50 Results</option>
			<option value="100">Show 100 Results</option>
		</select>
	</form>
	<%
		out.println("Page is: "+ session.getAttribute("pageNum"));
		int numRows = Integer.parseInt((String)session.getAttribute("resNum"));
		int pagNum = Integer.parseInt((String)session.getAttribute("pageNum"))-1;//page number, minus 1
		int needToPass = numRows*pagNum;
		int currRow = 1;
		int prevRows = 0;
		double currStartingPrice;
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stat = con.createStatement();
			Statement stat2 = con.createStatement();
			Statement stat3 = con.createStatement();
			Statement statUser = con.createStatement();
			Statement sell;
			String sellUpdate;
			ResultSet HighestSaleBid;
			
			//System.out.println("Attempting query:"+"SELECT * from ENDUSER where username=\'"+ usr +"\' AND password=\'"+pword+"\'");
			//NOTE: for now, only looks for auctions, not active auctions
			ResultSet result = stat.executeQuery("SELECT * from AUCTION WHERE duration>NOW()");
			ResultSet expiredAuctions = stat3.executeQuery("SELECT * from AUCTION WHERE duration<=NOW() AND soldTo IS NULL");
			ResultSet userList = statUser.executeQuery("SELECT * from ENDUSER WHERE username IS NOT NULL");
			while(expiredAuctions.next()){
				System.out.println("Attempting query:"+"SELECT placedByUsername FROM BID WHERE auctionNum=\'"+ expiredAuctions.getString("auctionNum")+"\' AND bidAmount = (SELECT MAX(bidAmount) FROM BID WHERE auctionNum=\'"+ expiredAuctions.getString("auctionNum")+"\')");
				HighestSaleBid = stat2.executeQuery("SELECT placedByUsername FROM BID WHERE auctionNum=\'"+ expiredAuctions.getString("auctionNum")+"\' AND bidAmount = (SELECT MAX(bidAmount) FROM BID WHERE auctionNum=\'"+ expiredAuctions.getString("auctionNum")+"\')");
				
				if(HighestSaleBid.next()){//HighestSaleBid.getDouble(1) >= currStartingPrice
					System.out.println("Attempting update: " + "UPDATE AUCTION SET soldTo = \'" + HighestSaleBid.getString(1) + "\' WHERE auctionNum="+ expiredAuctions.getString("auctionNum")+"");
					sellUpdate = "UPDATE AUCTION SET soldTo = \'" + HighestSaleBid.getString(1) + "\' WHERE auctionNum="+ expiredAuctions.getString("auctionNum")+"";
					sell =con.createStatement();
					sell.executeUpdate(sellUpdate);
				}
				
				
			}
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
				out.println("</tr>");
				do{
					if(prevRows < needToPass){
						prevRows++;
					}else{
						//decrement each cycle
						if(currRow > numRows){
							break;
						}else{
							currRow++;
						}
					
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
						currStartingPrice = Double.parseDouble(result.getString("startingPrice"));
						highestBid.next();
						if(highestBid.getDouble(1) >= currStartingPrice){
							out.print(highestBid.getDouble(1));
							//out.print("HighestBidNum");
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
						out.println("<td><form method = \"post\" action=\"aucDeleteAttempt.jsp\">");
						out.println("<input type=\"hidden\" name=\"auctionNumber\" value=\""+ result.getString("auctionNum") +"\">");
						out.println("<input type=\"submit\" value=\"Remove Auction\" />");
						out.println("</form></td>");
						out.println("<td>|</td>");
						out.println("</tr>");
					}
				}while(result.next());
				out.println("<form action=\'repHome.jsp\' method=\"post\">");
				out.println("</table>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Previous Page\"></td>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Next Page\"></td>");
				out.println("</tr>");
				out.println("</table>");
				out.println("</form>");



			//There are no ongoing auctions
			}else{
				out.println(" No auctions currently!");
			}
			
			out.println("<h1>View Endusers</h1>");
			//There are endusers
			if(userList.next()){
				out.println("<table>");
				out.println("<tr>");
				out.println("<td>|</td>");
				out.println("<td>Username</td>");
				out.println("<td>|</td>");
				out.println("<td></td>");
				out.println("<td>|</td>");
				out.println("</tr>");
				do{
										
						out.println("<tr>");
						out.println("<td>|</td>");
						out.print("<td>");
						out.print(userList.getString("username"));
						out.println("</td>");
						out.println("<td>|</td>");
						out.println("<td><form method = \"post\" action=\"viewAccount.jsp\">");
						out.println("<input type=\"hidden\" name=\"username\" value=\""+ userList.getString("username") +"\">");
						out.println("<input type=\"submit\" value=\"Go To User's Profile\" />");
						out.println("</form>");
						out.println("</td>");
						out.println("<td>|</td>");
						out.println("</tr>");
						
				}while(userList.next());

			//There are no endusers!
			}else{
				out.println(" No endusers!");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>