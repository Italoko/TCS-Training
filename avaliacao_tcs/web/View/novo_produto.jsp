<%-- 
    Document   : novo_produto
    Created on : 21/01/2022, 12:18:53
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../Style/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Style/form.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
        <title>Novo Produto</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            <h1>Novo Produto</h1>
        </header>
        <div class="container">
            <div class="form">
                <form action="../util/inserir_produto.jsp" method="post">
                    <div>
                        <label>Nome do produto:</label>
                        <input type="text" name="txtNome" placeholder="Digite o nome do produto" required>
                    </div>
             
                    <div>
                        <label>Quantidade:</label>
                        <input type="number" name="txtQtd" min="0" required >
                    </div>
                    <input type="submit" value="Gravar"/>
                </form>
            </div>
        </div>
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>
