<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Customer Registration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Customer Registration</h1></div>

<div class="container">

    <form method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button class="btn" type="submit">Register</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");

            // ENABLE RETURNING GENERATED ID
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO users(username, password, role) VALUES (?, ?, 'customer')",
                    Statement.RETURN_GENERATED_KEYS
            );

            ps.setString(1, u);
            ps.setString(2, p);

            int row = ps.executeUpdate();

            if (row > 0) {
                // FETCH AUTO-GENERATED CUSTOMER ID
                ResultSet keys = ps.getGeneratedKeys();
                int customerId = 0;

                if (keys.next()) {
                    customerId = keys.getInt(1);
                }

                out.println("<p style='color:green;'>Registration Successful!</p>");
                out.println("<p>Your Customer ID: <b>" + customerId + "</b></p>");
                out.println("<a href='customer_login.jsp'>Login Now</a>");
            } else {
                out.println("<p style='color:red;'>Registration Failed</p>");
            }
        }
    %>

</div>
</body>
</html>
