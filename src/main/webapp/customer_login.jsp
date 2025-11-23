<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Customer Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Customer Login</h1></div>

<div class="container">

    <form method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button class="btn" type="submit">Login</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM users WHERE username=? AND password=? AND role='customer'"
            );
            ps.setString(1, u);
            ps.setString(2, p);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("customer_user", u);
                response.sendRedirect("customer_dashboard.jsp");
                return;
            } else {
                out.println("<p style='color:red;'>Invalid Username or Password</p>");
            }
        }
    %>

</div>
</body>
</html>
