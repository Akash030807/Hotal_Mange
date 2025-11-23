<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Rooms</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Available Rooms</h1></div>

<div class="container">

    <table class="table">
        <tr>
            <th>ID</th>
            <th>Room Number</th>
            <th>Type</th>
            <th>Price</th>
            <th>Status</th>
        </tr>

        <%
            PreparedStatement ps = con.prepareStatement("SELECT * FROM rooms");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>
        <tr>
            <td><%= rs.getInt("room_id") %></td>
            <td><%= rs.getString("room_number") %></td>
            <td><%= rs.getString("room_type") %></td>
            <td><%= rs.getString("price") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
            }
        %>

    </table>

</div>
</body>
</html>
