<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Customers</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Customer List</h1></div>

<div class="container">

    <table class="table">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
        </tr>

        <%
            PreparedStatement ps = con.prepareStatement("SELECT * FROM customers");
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
        %>
        <tr>
            <td><%= rs.getInt("customer_id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("phone") %></td>
        </tr>
        <%
            }
        %>

    </table>

</div>
</body>
</html>
