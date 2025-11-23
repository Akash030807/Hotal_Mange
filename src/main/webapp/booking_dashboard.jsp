<%@ include file="dbconnect.jsp" %>
<%
    if(session.getAttribute("admin_user")==null){
        response.sendRedirect("admin_login.jsp"); return;
    }

    String action = request.getParameter("action");
    String id = request.getParameter("id");

    if("cancel".equalsIgnoreCase(action) && id!=null){
        PreparedStatement cps = con.prepareStatement("UPDATE bookings SET status='Cancelled' WHERE booking_id=?");
        cps.setInt(1, Integer.parseInt(id));
        cps.executeUpdate();
        response.sendRedirect("booking_dashboard.jsp");
        return;
    }
%>
<html>
<head>
    <title>Booking Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header"><h1>Booking Dashboard</h1></div>
<div class="container">

    <table class="table">
        <tr><th>ID</th><th>Customer</th><th>Room</th><th>Check-in</th><th>Check-out</th><th>Total</th><th>Status</th><th>Actions</th></tr>
        <%
            PreparedStatement ps = con.prepareStatement(
                    "SELECT b.booking_id, b.check_in, b.check_out, b.total_price, b.status, c.name AS cname, r.room_number " +
                            "FROM bookings b LEFT JOIN customers c ON b.customer_id=c.customer_id " +
                            "LEFT JOIN rooms r ON b.room_id=r.room_id ORDER BY b.booking_id DESC"
            );
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
        %>
        <tr>
            <td><%=rs.getInt("booking_id")%></td>
            <td><%=rs.getString("cname")%></td>
            <td><%=rs.getString("room_number")%></td>
            <td><%=rs.getDate("check_in")%></td>
            <td><%=rs.getDate("check_out")%></td>
            <td><%=rs.getBigDecimal("total_price")%></td>
            <td><%=rs.getString("status")%></td>
            <td>
                <% if(!"Cancelled".equalsIgnoreCase(rs.getString("status"))) { %>
                <a href="booking_dashboard.jsp?action=cancel&id=<%=rs.getInt("booking_id")%>" onclick="return confirm('Cancel booking?')">Cancel</a>
                <% } else { %>
                -
                <% } %>
            </td>
        </tr>
        <%
            }
        %>
    </table>

</div>
</body>
</html>
