<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header"><h1>Admin Login</h1></div>
<div class="container">
    <form method="post">
        <label>Username:</label><br/>
        <input type="text" name="username" required/><br/><br/>
        <label>Password:</label><br/>
        <input type="password" name="password" required/><br/><br/>
        <button class="btn" type="submit">Login</button>
    </form>

    <%
        if(request.getMethod().equalsIgnoreCase("POST")){
            String u = request.getParameter("username");
            String p = request.getParameter("password");

            PreparedStatement ps = con.prepareStatement("SELECT id, role FROM users WHERE username=? AND password=?");
            ps.setString(1, u);
            ps.setString(2, p);
            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                String role = rs.getString("role");
                if("admin".equalsIgnoreCase(role)){
                    // set a simple session attribute
                    session.setAttribute("admin_user", u);
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    out.println("<p style='color:red'>Not an admin user.</p>");
                }
            } else {
                out.println("<p style='color:red'>Invalid credentials.</p>");
            }
        }
    %>
</div>
</body>
</html>
