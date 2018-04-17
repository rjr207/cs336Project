<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.format.DateTimeFormatter,java.time.LocalDateTime"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Entering Bid</title>
</head>
<body>
<%
String usr = (String)session.getAttribute("username");
int aucNum = Integer.parseInt((String)session.getAttribute("currentAuction"));
int bidNum = 0;
double bid = Double.parseDouble((String)request.getParameter("bidAmount"));
String pay = request.getParameter("payment");
double auto = Double.parseDouble((String)request.getParameter("autoBidMax"));
double currentBid = 0;
DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
LocalDateTime dateEntry = LocalDateTime.now();
String time = dtf.format(dateEntry);
try{
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
		
	Statement q1 = con.createStatement();
	ResultSet r1, r2;
	r1 = q1.executeQuery("SELECT MAX(bidAmount) from BID where auctionNum =\'"+ aucNum +"\' ");
	while(r1.next()){
		currentBid = r1.getDouble(1);
	}
	if(currentBid >= Double.parseDouble(request.getParameter("startingPrice"))){
		//currentBid is accurate
	}else{
		currentBid = Double.parseDouble(request.getParameter("startingPrice"));
	}
		
	if(bid <= currentBid){
		System.out.println("Invalid bid");
		con.close();
		response.sendRedirect("userHome.jsp");
	}
	else{
		String i1 = "INSERT INTO BID(bidAmount, paymentMethod, timePlaced, placedByUsername, auctionNum)" + " VALUES (\'"+bid+"\',\'"+pay+"\',\'"+time+"\',\'"+usr+"\', \'"+aucNum+"\')";
			
		//Execute insert
		//out.println("Attempting bid: " + i1);
		Statement s1 =con.createStatement();
		s1.executeUpdate(i1);
		
		Statement q2 = con.createStatement();
		r2=q2.executeQuery("SELECT MAX(bidNumber) from BID where auctionNum =\'"+ aucNum +"\' ");
		bidNum = r2.getInt(1);
		
		
		if(auto >= bid){
			String i2 = "INSERT INTO AUTOBID VALUES (\'"+usr+"\',\'"+aucNum+"\',\'"+auto+"\')";
			//out.println("Setting Auto-bid: " + i2);
			Statement s2 =con.createStatement();
			s2.executeUpdate(i2);
		}
		con.close();
		response.sendRedirect("userHome.jsp");
	}
	
}catch(Exception e){
e.printStackTrace();
}
%>
</body>
</html>