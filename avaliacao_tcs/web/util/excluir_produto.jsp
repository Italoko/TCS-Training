<%-- 
    Document   : excluir_produto
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "DAO.DAOProduto" %>

<%
   DAOProduto prodDAO = DAOProduto.getInstance();
   
   String id = request.getParameter("id");
   if(id != null && !id.isEmpty())
   {
       if(prodDAO.deleteProduto(Integer.parseInt(id)))
            out.print("<script type='text/javascript'> alert('Registro apagado.'); window.location.href = '../View/consultar_produto.jsp' </script>");
       else
            out.print("<script type='text/javascript'> alert('Operação não concluída.'); window.location.href = '../View/consultar_produto.jsp' </script>");
   } 
   else
       out.print("<script type='text/javascript'> alert('Produto não identificado'); window.location.href = '../View/consultar_produto.jsp' </script>");
%>
