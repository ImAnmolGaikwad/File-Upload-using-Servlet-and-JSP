<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%

String id = request.getParameter("id");
System.out.println(id);
 
String connectionURL = "jdbc:mysql://localhost:3306/jsp_image";
String user = "root";
String pass = "root";
 


Connection con = null;
 
try{
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection(connectionURL, user, pass);
    
    PreparedStatement ps = con.prepareStatement("select data from images where id=?");
  
    ps.setString(1, id);
   
    ResultSet rs = ps.executeQuery();
   
    if(rs.next()){
     Blob blob = rs.getBlob("data");
     
        byte byteArray[] = blob.getBytes(1, (int)blob.length());
        response.setContentType("image/jpeg");
        try (OutputStream outputStream = response.getOutputStream()) {
            outputStream.write(byteArray);
        }
       
    }
}
catch(Exception e){
    e.printStackTrace();
}  
finally{
    if(con != null){
        try{
            con.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}
%>