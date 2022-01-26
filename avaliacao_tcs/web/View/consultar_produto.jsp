<%-- 
    Document   : consultar_produto
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.ArrayList"%>
<%@page import = "MODEL.Produto" %>
<%@page import = "DAO.DAOProduto" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Style/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Style/table.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

        <title>Produtos petshop</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            <h1>Produtos petshop</h1>
            
            <nav style="margin: 10px;">
                <form action="./consultar_produto.jsp" method="post">
                    <label>Buscar: </label>
                    <input style="width: 40%" name="q_nome" type="search">
                    <input type="submit" value="Pesquisar"></input>
  
                    <label>Qtd Min:</label><input type="radio"  name="radio_order_min" value="MIN">
                    <label>Qtd Max:</label><input type="radio"  name="radio_order_max" value="MAX">
                </form>
            </nav> 
        </header>
        
        <div class="container">
            <%
                out.print("<table>");
                    out.print("<thead>");
                        out.print("<tr>");
                            out.print("<th>ID.</th>");
                            out.print("<th>Produto</th>");
                            out.print("<th>Quantidade</th>");
                            
                            out.print("<th>Alter</th>");
                            out.print("<th>Delete</th>");
                        out.print("</tr>");
                    out.print("</thead>");
                    
                    out.print("<tbody>");
                    
                    DAOProduto prodDAO = DAOProduto.getInstance();
                    ArrayList<Produto> produtos = new ArrayList<Produto>();
                    
                    String order = "";
                    String min = request.getParameter("radio_order_min");
                    String max  = request.getParameter("radio_order_max");
                    
                    if(min != null)
                        order = min;
                    else
                        order = max;

                    if(request.getParameter("q_nome") == null || request.getParameter("q_nome").isEmpty())
                        produtos = prodDAO.getProdutos(order);
                    else
                        produtos = prodDAO.getProdutosFilter(request.getParameter("q_nome"),order);

                    for (Produto prod : produtos){
                        out.print("<tr>");
                            out.print("<td>"+ prod.getId_produto() +"</td>");
                            out.print("<td>"+ prod.getNome_produto() +"</td>");
                            out.print("<td>"+ prod.getQtd_produto()+"</td>");
                           
                            out.print("<td> <a href = 'edit_produto.jsp?id="+ prod.getId_produto()+ "'> <i class='far fa-edit'></i> </td>");
                            out.print("<td> <a href = '../util/excluir_produto.jsp?id="+ prod.getId_produto()+ "'> <i class='far fa-trash-alt'></i> </td>");
                        out.print("</tr>");    
                    }
                    out.print("</tbody>");     
                out.print("</table>");   
            %>
            
        </div>
        
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>
