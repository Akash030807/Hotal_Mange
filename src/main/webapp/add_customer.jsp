<%@ include file="WEB-INF/dbconnect.jsp" %>
<%
    if(session.getAttribute("admin_user")==null){
        response.sendRedirect("admin_login.jsp"); return;
    }
%>
<html>
<head>
    <title>Add Customer</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="header"><h1>Add Customer</h1></div>
<div class="container">

    <form method="post">
        <label>Name:</label><br/>
        <input type="text" name="name" required/><br/><br/>
        <label>Email:</label><br/>
        <input type="email" name="email" required/><br/><br/>
        <label>Phone:</label><br/>
        <input type="text" name="phone" required/><br/><br/>
        <button class="btn" type="submit">Add Customer</button>
    </form>

    <%
        if("POST".equalsIgnoreCase(request.getMethod())){
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO customers(name, email, phone) VALUES(?,?,?)"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            int n = ps.executeUpdate();
            if(n>0) out.println("<p style='color:green'>Customer added.</p>");
            else out.println("<p style='color:red'>Error adding customer.</p>");
        }
    %>

</div>
</body>
</html>
