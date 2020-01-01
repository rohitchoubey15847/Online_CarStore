<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="Database.DbConnection"%>
<%
Blob image = null;

byte[ ] imgData = null ;
Statement stmt = null;
ResultSet rs = null;
try {
	 Connection con = DbConnection.getconnection();
stmt = con.createStatement();
rs = stmt.executeQuery("select image from user");
if (rs.next()) {
image = rs.getBlob(1);
imgData = image.getBytes(1,(int)image.length());
}
else {
out.println("Display Blob Example");
out.println("image not found for given id>");
return;
}
// display the image
response.setContentType("image/jpg");
OutputStream o = response.getOutputStream();
o.write(imgData);
o.flush();
o.close();
} catch (Exception e) {
out.println("Unable To Display image");
out.println("Image Display Error=" + e.getMessage());
return;
} finally {
try {
rs.close();
stmt.close();

} catch (SQLException e) {
e.printStackTrace();
}
}
%>