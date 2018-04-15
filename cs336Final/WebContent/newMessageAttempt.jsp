<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.format.DateTimeFormatter,java.time.LocalDateTime"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Attempting Message</title>
</head>
<body>
<%

DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");  
LocalDateTime dateEntry = LocalDateTime.now();
String dateTime = dtf.format(dateEntry);

String sender = request.getParameter("senderEaddr");
String recipient = request.getParameter("targetEaddr");
String content = request.getParameter("content");
String subject = request.getParameter("subject");

content = content.replaceAll("'", "\\\\'");
content = content.replace("\"", "\\\"");

out.println("Resulting string: " + content);

try{
	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	
	//Make an insert statement for the email table:
	String insert1 = "INSERT INTO EMAIL(sender, recipient, subject, timeSent, contents)" + " VALUES (\'" + sender + "\', \'" + recipient + "\', \'" + subject + "\', \'" + dateTime + "\', \'" + content + "\')";
	Statement s1 =con.createStatement();
	System.out.println("Attempting query:"+insert1);
	s1.executeUpdate(insert1);


	//close the connection.
	con.close();
	response.sendRedirect("messages.jsp");
	
}catch(Exception e){
e.printStackTrace();
}

%>
</body>
</html>