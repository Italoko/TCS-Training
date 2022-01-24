<%-- 
    Document   : consultar_cliente
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import = "MODEL.Cliente" %>
<%@page import = "DAO.DAOCliente" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Style/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Style/table.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
        
        <title>Clientes petshop</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            <h1>Clientes petshop</h1>
            
            <nav style="margin: 10px;">
                <form action="./consultar_cliente.jsp" method="post">
                    <label>Buscar: </label>
                    <input style="width: 50%" name="q_nome" type="search">
                    <input type="submit" value="Pesquisar"></input>
                </form>
            </nav>  
        </header>
        
        <div class="container"> 
            <%
                out.print("<table>");
                    out.print("<thead>");
                        out.print("<tr>");
                            out.print("<th>ID.</th>");
                            out.print("<th>Cliente</th>");
                            out.print("<th>Email</th>");
                            out.print("<th>Telefone</th>");
                            
                            out.print("<th>Alter</th>");
                            out.print("<th>Delete</th>");
                        out.print("</tr>");
                    out.print("</thead>");
                    
                    out.print("<tbody>");
                    
                    DAOCliente cliDAO = DAOCliente.getInstance();
                    ArrayList<Cliente> clientes = new ArrayList<Cliente>();
                    
                    if(request.getParameter("q_nome") == null || request.getParameter("q_nome").isEmpty())
                        clientes = cliDAO.getClientes();
                    else
                        clientes = cliDAO.getClientesFilter(request.getParameter("q_nome"));
                    
                    for (Cliente cli : clientes){
                        out.print("<tr>");
                            out.print("<td>"+ cli.getId_cliente() +"</td>");
                            out.print("<td>"+ cli.getNome_cliente() +"</td>");
                            out.print("<td>"+ cli.getEmail_cliente() +"</td>");
                            out.print("<td>"+ cli.getTelefone_cliente() +"</td>");
                            
                            out.print("<td>"+ "Alterar" +"</td>");
                            out.print("<td>"+ "Apagar " +"</td>");
                        out.print("</tr>");    
                    }
                    out.print("</tbody>");     
                out.print("</table>");   
            %>
        </div>
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>
