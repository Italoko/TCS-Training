<%-- 
    Document   : novo_cliente
    Created on : 21/01/2022, 12:18:03
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
        <title>Novo Cliente</title>
    </head>
    <body>
        <header>
            <div class="back-home">
                <a href = "../index.jsp" alt="Voltar para home"><i class="fas fa-backward"></i></a>
            </div>
            
            <h1>Novo Cliente</h1>
        </header>
        <div class="container">
            <div class="form">
                <form action="../util/inserir_cliente.jsp" method="post">
                    <div>
                        <label>Nome do cliente:</label>
                        <input type="text" name="txtNome" placeholder="Digite o nome do cliente" required>
                    </div>
                    <div>
                        <label>E-mail:</label>
                        <input type="email" name="txtEmail" placeholder="Digite email do cliente" required>
                    </div>
                    <div>
                        <label>Telefone:</label>
                        <input type="tel" name="txtTelefone" placeholder="Digite telefone do cliente" required>
                    </div>

                   <input type="submit" value="Gravar"/>
                </form>
            </div>
        </div>
        <footer><h4>© 2022 - Italo Piovan - Intern Developer</h4></footer>
    </body>
</html>
