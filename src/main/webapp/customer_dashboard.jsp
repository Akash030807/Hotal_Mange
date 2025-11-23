<%
    String customer = (String) session.getAttribute("customer_user");
    if (customer == null) {
        response.sendRedirect("customer_login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Customer Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Welcome, <%= customer %></h1></div>

<div class="container">
    <a href="rooms.jsp"><button class="btn">View Rooms</button></a>
    <a href="booking.jsp"><button class="btn">Book a Room</button></a>

    <form method="post" style="margin-top:20px;">
        <button class="btn" name="logout">Logout</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("logout") != null) {
            session.removeAttribute("customer_user");
            response.sendRedirect("customer_login.jsp");
        }
    %>

</div>
</body>
</html>
