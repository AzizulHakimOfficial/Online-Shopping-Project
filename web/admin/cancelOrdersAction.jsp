<%@page import="project.ConnectionProvider" %>
<%@page import="java.sql.*" %>
<%
    String email=request.getParameter("email");
    String id=request.getParameter("id");
    String status="Cancel";
    try{
        Connection con=ConnectionProvider.getCon();
        Statement st=con.createStatement();
        st.executeUpdate("update cart set status='"+status+"' where email='"+email+"' and product_id='"+id+"' and address is not NULL");
        
        response.sendRedirect("ordersReceived.jsp?msg=cancel");
    }catch(Exception e){
    System.out.println(e);
     response.sendRedirect("ordersReceived.jsp?msg=wrong");}

%>