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
	<h1>Search for an Item</h1><br>
	<form method="post" action="SearchResult.jsp">
	<table>
	<tr>
		<td>Sock Style</td>
		<td>
		<select name="sockStyle">
			<option value="nopref">Select Style</option>
			<option value="knee">Knee</option>
			<option value="crew">Crew</option>
			<option value="ankle">Ankle</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Color</td>
		<td><input type="text" name="color"></td>
	</tr>
	<tr>
		<td>Size</td>
		<td>
			<select name="sockSize">
			<option value="nopref">Select Size</option>
			<option value="s">Small</option>
			<option value="m">Medium</option>
			<option value="l">Large</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>Current Price Below</td>
		<td><input type="text" name="currPrice"></td>
	</tr>
	<tr>
		<td><input type="submit" value="Submit" /></td>
	</tr>
	</table>
	</form>

	<h1>View Current Auctions</h1>
	<form method = "post" action="userHome.jsp">
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
				out.println("<td>Seller</td>");
				out.println("<td>|</td>");
				out.println("<td>Sold To</td>");
				out.println("<td>|</td>");
				out.println("<td></td>");
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
					}
				}while(result.next());
				out.println("<form action=\'userHome.jsp\' method=\"post\">");
				out.println("</table>");
				out.println("<table>");
				out.println("<tr>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Previous Page\"></td>");
				out.println("<td><input type=\"submit\" name=\"navBtn\" value=\"Next Page\"></td>");
				out.println("</tr>");
				out.println("</table>");



			//There are no ongoing auctions
			}else{
				out.println(" No auctions currently!");
			}
			
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>