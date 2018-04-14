<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
int bid = Integer.parseInt((String)request.getParameter("bidAmount"));
String pay = request.getParameter("payment");
String auto = request.getParameter("autoBidMax");
int currentBid = 0;

try{

	java.sql.Date time =new java.sql.Date(new java.util.Date().getTime());
	
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
		
	Statement q1 = con.createStatement();
	ResultSet r1;
	r1 = q1.executeQuery("SELECT MAX(bidAmount) from BID where auctionNum =\'"+ aucNum +"\' ");
	while(r1.next()){
		currentBid = r1.getInt(1);
	}
		
	if(bid <= currentBid){
		System.out.println("Invalid bid");
		response.sendRedirect("userHome.jsp");
	}
	else{

		String i1 = "INSERT INTO BID(bidAmount, paymentMethod, timePlaced, placedByUsername, auctionNum)" + " VALUES (\'"+bid+"\',\'"+pay+"\',\'"+time+"\',\'"+usr+"\', \'"+aucNum+"\')";
			
		//Execute insert
		Statement s1 =con.createStatement();
		s1.executeUpdate(i1);
	}

}catch(Exception e){
e.printStackTrace();
}

%>
</body>
</html>