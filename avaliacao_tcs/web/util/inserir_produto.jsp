<%-- 
    Document   : inserir_produto
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "MODEL.Produto" %>
<%@page import = "DAO.DAOProduto" %>

<%
    try{
        String nome = request.getParameter("txtNome");
        String qtd = request.getParameter("txtQtd");
        
        if(nome == null || nome.isEmpty())
            out.print("<script type='text/javascript'> alert('Nome é um campo obrigatório.'); </script>");
        else if(qtd == null || qtd.isEmpty())
                out.print("<script type='text/javascript'> alert('Quantidade é um campo obrigatório.'); </script>");
        else if(Integer.parseInt(qtd) < 0)
                out.print("<script type='text/javascript'> alert('Quantidade não pode ser negativo.'); </script>");
        else{
            Produto prod = new Produto(nome,Integer.parseInt(qtd));
            DAOProduto prodDAO = DAOProduto.getInstance();
            boolean success = prodDAO.insertProduto(prod);
            
            String msg = "";
            if(success)
                msg = "Produto:  " + prod.getNome_produto().toUpperCase() + "  inserido com sucesso";
            else
                msg = "Falha ao inserir produto.";
         
            out.print("<script type='text/javascript'> alert('" + msg + "'); window.location.href = '../View/novo_produto.jsp' </script>");
        }
    }catch(Exception e){throw new RuntimeException("Erro ao gravar" + e);}
%>
