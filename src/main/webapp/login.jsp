<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="header"><h1>Login</h1></div>

<div class="container">
    <form method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>

        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>

        <button class="btn" type="submit">Login</button>
    </form>

    <%
        if(request.getMethod().equals("POST")){
            String u = request.getParameter("username");
            String p = request.getParameter("password");

            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
            ps.setString(1, u);
            ps.setString(2, p);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                session.setAttribute("user", u);
                response.sendRedirect("admin_dashboard.jsp");
                // Go to home page
                return;
            }
            else {
                out.println("<p>Invalid Credentials</p>");
            }
        }
    %>

</div>
</body>
</html>
