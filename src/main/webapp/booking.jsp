<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Booking</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Book a Room</h1></div>

<div class="container">

    <form method="post">
        <label>Customer ID:</label>
        <input type="number" name="customer_id" required><br><br>

        <label>Room ID:</label>
        <input type="number" name="room_id" required><br><br>

        <label>Check-in Date:</label>
        <input type="date" name="check_in" required><br><br>

        <label>Check-out Date:</label>
        <input type="date" name="check_out" required><br><br>

        <button class="btn" type="submit">Book Now</button>
    </form>

    <%
        if(request.getMethod().equals("POST")){

            int cid = Integer.parseInt(request.getParameter("customer_id"));
            int rid = Integer.parseInt(request.getParameter("room_id"));
            String cin = request.getParameter("check_in");
            String cout = request.getParameter("check_out");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO bookings(customer_id, room_id, check_in, check_out, status) VALUES (?, ?, ?, ?, 'Booked')"
            );

            ps.setInt(1, cid);
            ps.setInt(2, rid);
            ps.setString(3, cin);
            ps.setString(4, cout);

            int row = ps.executeUpdate();

            if(row > 0){
                out.println("<p>Room Booked Successfully!</p>");
            } else {
                out.println("<p>Error while booking!</p>");
            }
        }
    %>

</div>
</body>
</html>
