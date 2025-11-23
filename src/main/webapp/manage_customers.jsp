<%@ include file="dbconnect.jsp" %>
<%
    if(session.getAttribute("admin_user")==null){
        response.sendRedirect("admin_login.jsp"); return;
    }
    String action = request.getParameter("action");
    String id = request.getParameter("id");

    if("delete".equalsIgnoreCase(action) && id!=null){
        PreparedStatement d = con.prepareStatement("DELETE FROM customers WHERE customer_id=?");
        d.setInt(1, Integer.parseInt(id));
        d.executeUpdate();
        response.sendRedirect("manage_customers.jsp");
        return;
    }
%>
<html>
<head>
    <title>Manage Customers</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="header"><h1>Manage Customers</h1></div>
<div class="container">

    <%
        if("edit".equalsIgnoreCase(action) && id!=null){
            PreparedStatement r = con.prepareStatement("SELECT * FROM customers WHERE customer_id=?");
            r.setInt(1, Integer.parseInt(id));
            ResultSet rr = r.executeQuery();
            if(rr.next()){
    %>
    <form method="post" action="manage_customers.jsp?action=update&id=<%=id%>">
        <label>Name:</label><br/>
        <input type="text" name="name" value="<%=rr.getString("name")%>" required/><br/><br/>
        <label>Email:</label><br/>
        <input type="email" name="email" value="<%=rr.getString("email")%>" required/><br/><br/>
        <label>Phone:</label><br/>
        <input type="text" name="phone" value="<%=rr.getString("phone")%>" required/><br/><br/>
        <button class="btn" type="submit">Update</button>
    </form>
    <%
            }
        } else if("update".equalsIgnoreCase(action) && id!=null && "POST".equalsIgnoreCase(request.getMethod())){
            PreparedStatement u = con.prepareStatement("UPDATE customers SET name=?, email=?, phone=? WHERE customer_id=?");
            u.setString(1, request.getParameter("name"));
            u.setString(2, request.getParameter("email"));
            u.setString(3, request.getParameter("phone"));
            u.setInt(4, Integer.parseInt(id));
            u.executeUpdate();
            out.println("<p style='color:green'>Customer updated.</p>");
        }
    %>

    <h3>Customer List</h3>
    <table class="table">
        <tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Actions</th></tr>
        <%
            PreparedStatement ps = con.prepareStatement("SELECT * FROM customers ORDER BY customer_id DESC");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
        %>
        <tr>
            <td><%=rs.getInt("customer_id")%></td>
            <td><%=rs.getString("name")%></td>
            <td><%=rs.getString("email")%></td>
            <td><%=rs.getString("phone")%></td>
            <td>
                <a href="manage_customers.jsp?action=edit&id=<%=rs.getInt("customer_id")%>">Edit</a> |
                <a href="manage_customers.jsp?action=delete&id=<%=rs.getInt("customer_id")%>" onclick="return confirm('Delete this customer?')">Delete</a>
            </td>
        </tr>
        <%
            }
        %>
    </table>

</div>
</body>
</html>
