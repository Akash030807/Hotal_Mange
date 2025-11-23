<%@ include file="dbconnect.jsp" %>
<%
    if(session.getAttribute("admin_user")==null){
        response.sendRedirect("admin_login.jsp"); return;
    }
    String action = request.getParameter("action");
    String id = request.getParameter("id");

    if("delete".equalsIgnoreCase(action) && id != null){
        PreparedStatement dps = con.prepareStatement("DELETE FROM rooms WHERE room_id=?");
        dps.setInt(1, Integer.parseInt(id));
        dps.executeUpdate();
        response.sendRedirect("manage_rooms.jsp");
        return;
    }
%>
<html>
<head>
    <title>Manage Rooms</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header"><h1>Manage Rooms</h1></div>
<div class="container">

    <%
        // If editing, show edit form
        if("edit".equalsIgnoreCase(action) && id != null){
            PreparedStatement rps = con.prepareStatement("SELECT * FROM rooms WHERE room_id=?");
            rps.setInt(1, Integer.parseInt(id));
            ResultSet rrs = rps.executeQuery();
            if(rrs.next()){
    %>
    <h3>Edit Room</h3>
    <form method="post" action="manage_rooms.jsp?action=update&id=<%= id %>">
        <label>Room Number:</label><br/>
        <input type="text" name="room_number" value="<%= rrs.getString("room_number") %>" required/><br/><br/>
        <label>Room Type:</label><br/>
        <input type="text" name="room_type" value="<%= rrs.getString("room_type") %>" required/><br/><br/>
        <label>Price:</label><br/>
        <input type="number" step="0.01" name="price" value="<%= rrs.getBigDecimal("price") %>" required/><br/><br/>
        <label>Status:</label><br/>
        <select name="status">
            <option <%= "Available".equals(rrs.getString("status"))? "selected":"" %>>Available</option>
            <option <%= "Occupied".equals(rrs.getString("status"))? "selected":"" %>>Occupied</option>
            <option <%= "Maintenance".equals(rrs.getString("status"))? "selected":"" %>>Maintenance</option>
        </select><br/><br/>
        <button class="btn" type="submit">Update</button>
    </form>
    <%
            }
        } else if("update".equalsIgnoreCase(action) && id != null && "POST".equalsIgnoreCase(request.getMethod())){
            // perform update
            String rn = request.getParameter("room_number");
            String rt = request.getParameter("room_type");
            String pr = request.getParameter("price");
            String st = request.getParameter("status");

            PreparedStatement ups = con.prepareStatement(
                    "UPDATE rooms SET room_number=?, room_type=?, price=?, status=? WHERE room_id=?"
            );
            ups.setString(1, rn);
            ups.setString(2, rt);
            ups.setBigDecimal(3, new java.math.BigDecimal(pr));
            ups.setString(4, st);
            ups.setInt(5, Integer.parseInt(id));
            ups.executeUpdate();
            out.println("<p style='color:green'>Updated successfully.</p>");
        }
    %>

    <h3>All Rooms</h3>
    <table class="table">
        <tr><th>ID</th><th>Number</th><th>Type</th><th>Price</th><th>Status</th><th>Actions</th></tr>
        <%
            PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms ORDER BY room_id DESC");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
        %>
        <tr>
            <td><%=rs.getInt("room_id")%></td>
            <td><%=rs.getString("room_number")%></td>
            <td><%=rs.getString("room_type")%></td>
            <td><%=rs.getBigDecimal("price")%></td>
            <td><%=rs.getString("status")%></td>
            <td>
                <a href="manage_rooms.jsp?action=edit&id=<%=rs.getInt("room_id")%>">Edit</a> |
                <a href="manage_rooms.jsp?action=delete&id=<%=rs.getInt("room_id")%>" onclick="return confirm('Delete this room?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

</div>
</body>
</html>
