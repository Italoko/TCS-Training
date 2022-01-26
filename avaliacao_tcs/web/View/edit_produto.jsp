<%-- 
    Document   : edit_produto
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "MODEL.Produto" %>
<%@page import = "DAO.DAOProduto" %>

<%
    DAOProduto prodDAO = DAOProduto.getInstance();
    Produto produto = prodDAO.getProdutoById(Integer.parseInt(request.getParameter("id")));
    
    if(produto == null)
        out.print("<script type='text/javascript'> alert('Produto não identificado'); window.location.href = './consultar_produto.jsp' </script>");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Style/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Style/form.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
        <title>Alter Produto</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            <h1>Alterar Produto</h1>
        </header>
        <div class="container">
            <div class="form">
                <form action="../util/alterar_produto.jsp" method="post">
                    <div>
                        <label>Produto ID</label>
                        <% out.print("<input type='number' name='txtID' readonly value='" + produto.getId_produto()+ "'>"); %>
                    </div>
                    
                    <div>
                        <label>Nome do produto:</label>
                        <% out.print("<input type='text' name='txtNome' placeholder='Digite o nome do produto' required value='" + produto.getNome_produto()+ "'>"); %>
                    </div>
             
                    <div>
                        <label>Quantidade:</label>
                        <% out.print("<input type='number' name='txtQtd' min='0' required value='" + produto.getQtd_produto()+ "'>"); %>
                    </div>
                    <input type="submit" value="Gravar Alteração"/>
                </form>
            </div>
        </div>
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>
