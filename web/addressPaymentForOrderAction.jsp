<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
    String email = session.getAttribute("email").toString();
    String address = request.getParameter("address");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String country = request.getParameter("country");
    String mobileNumber = request.getParameter("mobileNumber");
    String paymentMethod = request.getParameter("paymentMethod");
    String transactionId = null;
    transactionId = request.getParameter("transactionId");
    String status = "bill";
    if ("Online Payment".equals(paymentMethod) && transactionId.isEmpty()) {
%>
<h2 style="color: red">You have selected Online Payment but Didn't put the Transaction ID.</h2>
<h2 style="color: red">You have to give Transaction ID when you select the Online payment option.</h2>
<button style="border: 0; font-size: 40px;transition-duration: 0.4s; background-color: mediumturquoise;color: white" class="button" type="submit"><a href="addressPaymentForOrder.jsp">Back</a><i class='far fa-arrow-alt-circle-right'></i></button>
    <%
            return;
        }
        if ("NULL".equals(address) || "null".equals(address) || "NULL".equals(city) || "null".equals(city) || "NULL".equals(state) || "null".equals(state)|| "NULL".equals(country) || "null".equals(country)) {
    %>
    <h2 style="color: red">You haven't input the address details properly. Your Address information somewhere is empty</h2>
    <h2 style="color: red">You have to put details address information.</h2>
    <button style="border: 0; font-size: 40px;transition-duration: 0.4s; background-color: mediumturquoise;color: white" class="button" type="submit"><a href="addressPaymentForOrder.jsp">Back</a><i class='far fa-arrow-alt-circle-right'></i></button>
<%
        return;
    }

    try {
        Connection con = ConnectionProvider.getCon();
        PreparedStatement ps = con.prepareStatement("update users set address=?,city=?,state=?,country=?,mobileNumber=? where email=?");
        ps.setString(1, address);
        ps.setString(2, city);
        ps.setString(3, state);
        ps.setString(4, country);
        ps.setString(5, mobileNumber);
        ps.setString(6, email);
        ps.executeUpdate();

        PreparedStatement ps1 = con.prepareStatement("update cart set address=?,city=?,state=?,country=?,mobileNumber=?,orderDate=now(),deliveryDate=DATE_ADD(orderDate,INTERVAL 7 DAY),paymentMethod=?,transactionId=?,status=? where email=? and address is NULL");
        ps1.setString(1, address);
        ps1.setString(2, city);
        ps1.setString(3, state);
        ps1.setString(4, country);
        ps1.setString(5, mobileNumber);
        ps1.setString(6, paymentMethod);
        ps1.setString(7, transactionId);
        ps1.setString(8, status);
        ps1.setString(9, email);
        ps1.executeUpdate();
        response.sendRedirect("bill.jsp");
    } catch (Exception e) {
        System.out.println(e);
    }


%>