<%-- 
    Document   : excluir_cliente
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "DAO.DAOCliente" %>

<%
   DAOCliente cliDAO = DAOCliente.getInstance();
   
   String id = request.getParameter("id");
   if(id != null && !id.isEmpty())
   {
       if(cliDAO.deleteCliente(Integer.parseInt(id)))
            out.print("<script type='text/javascript'> alert('Registro apagado.'); window.location.href = '../View/consultar_cliente.jsp' </script>");
       else
            out.print("<script type='text/javascript'> alert('Operação não concluída.'); window.location.href = '../View/consultar_cliente.jsp' </script>");
   } 
   else
       out.print("<script type='text/javascript'> alert('Cliente não identificado'); window.location.href = '../View/consultar_cliente.jsp' </script>");
%>
