<%-- 
    Document   : edit_cliente
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "MODEL.Cliente" %>
<%@page import = "DAO.DAOCliente" %>

<%
    DAOCliente cliDAO = DAOCliente.getInstance();
    Cliente cliente = cliDAO.getClienteById(Integer.parseInt(request.getParameter("id")));
    
    if(cliente == null)
        out.print("<script type='text/javascript'> alert('Cliente não identificado'); window.location.href = './consultar_cliente.jsp' </script>");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Style/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Style/form.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
        <title>Alter Cliente</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            <h1>Alterar Cliente</h1>
        </header>
        <div class="container">
            <div class="form">
                <form action="../util/alterar_cliente.jsp" method="post">
                    <div>
                        <label>Cliente ID</label>
                        <% out.print("<input type='number' name='txtID' readonly value='" + cliente.getId_cliente() + "'>"); %>
                    </div>
                    
                    <div>
                        <label>Nome do cliente:</label>
                        <% out.print("<input type='text' name='txtNome' placeholder='Digite o nome do cliente' required value='" + cliente.getNome_cliente()+ "'>"); %>
                    </div>
                    <div>
                        <label>E-mail:</label>
                        <% out.print("<input type='email' name='txtEmail' placeholder='Digite email do cliente' required value='" + cliente.getEmail_cliente()+ "'>"); %>
                    </div>
                    <div>
                        <label>Telefone:</label>
                        <% out.print("<input type='tel' name='txtTelefone' placeholder='Digite telefone do cliente' required value='" + cliente.getTelefone_cliente()+ "'>"); %>
                    </div>

                   <input type="submit" value="Gravar alteração"/>
                </form>
            </div>
        </div>
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>

