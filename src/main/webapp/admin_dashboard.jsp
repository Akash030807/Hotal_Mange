<%@ include file="dbconnect.jsp" %>
<%
    String admin = (String) session.getAttribute("admin_user");
    if(admin == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header">
    <h1>Admin Dashboard</h1>
</div>

<div class="container">
    <img src="<%= "image/pagebg.jpg" %>" alt="logo" style="max-width:150px; display:block; margin-bottom:15px;">
    <p>Welcome, <b><%=admin %></b></p>

    <a href="add_room.jsp"><button class="btn">Add Room</button></a>
    <a href="manage_rooms.jsp"><button class="btn">Manage Rooms</button></a>
    <a href="add_customer.jsp"><button class="btn">Add Customer</button></a>
    <a href="manage_customers.jsp"><button class="btn">Manage Customers</button></a>
    <a href="booking_dashboard.jsp"><button class="btn">Booking Dashboard</button></a>
    <form method="post" style="display:inline;">
        <button class="btn" type="submit" name="logout">Logout</button>
    </form>
</div>

<%
    if("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("logout")!=null){
        session.removeAttribute("admin_user");
        response.sendRedirect("index.jsp");
    }
%>

</body>
</html>
