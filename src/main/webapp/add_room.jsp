<%@ include file="dbconnect.jsp" %>
<%
    if(session.getAttribute("admin_user")==null){
        response.sendRedirect("admin_login.jsp"); return;
    }
%>
<html>
<head>
    <title>Add Room</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header"><h1>Add Room</h1></div>
<div class="container">
    <form method="post">
        <label>Room Number:</label><br/>
        <input type="text" name="room_number" required/><br/><br/>

        <label>Room Type:</label><br/>
        <input type="text" name="room_type" required/><br/><br/>

        <label>Price:</label><br/>
        <input type="number" step="0.01" name="price" required/><br/><br/>

        <button class="btn" type="submit">Add Room</button>
    </form>

    <%
        if("POST".equalsIgnoreCase(request.getMethod())){
            String rn = request.getParameter("room_number");
            String rt = request.getParameter("room_type");
            String pr = request.getParameter("price");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO rooms(room_number, room_type, price, status) VALUES (?, ?, ?, 'Available')"
            );
            ps.setString(1, rn);
            ps.setString(2, rt);
            ps.setBigDecimal(3, new java.math.BigDecimal(pr));
            int n = ps.executeUpdate();
            if(n>0){
                out.println("<p style='color:green'>Room added successfully.</p>");
            } else {
                out.println("<p style='color:red'>Failed to add room.</p>");
            }
        }
    %>

</div>
</body>
</html>
