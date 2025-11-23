<%@ page import="java.sql.*" %>

<%
    String url = "jdbc:mysql://localhost:3306/hotel_management";
    String username = "root";
    String password = "Akash@0308";

    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, username, password);
    } catch (Exception e) {
        out.println("Database Connection Error: " + e);
    }
%>
