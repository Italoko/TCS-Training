<%-- 
    Document   : inserir_cliente
    Author     : ITALO PIOVAN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "MODEL.Cliente" %>
<%@page import = "DAO.DAOCliente" %>

<%
    try{
        String nome = request.getParameter("txtNome");
        String email = request.getParameter("txtEmail");
        String tel = request.getParameter("txtTelefone");
        
        if(nome == null || nome.isEmpty())
            out.print("<script type='text/javascript'> alert('Nome é um campo obrigatório.'); </script>");
        else if(email == null || email.isEmpty())
                out.print("<script type='text/javascript'> alert('Email é um campo obrigatório.'); </script>");
        else if(tel == null || tel.isEmpty())
                out.print("<script type='text/javascript'> alert('Telefone é um campo obrigatório.'); </script>");
        else if(tel.length() > 12)
                out.print("<script type='text/javascript'> alert('Tel deve ser no max. 12 caracteres'); </script>");
        else{
            Cliente cli = new Cliente(nome,email,tel);
            DAOCliente cliDAO = DAOCliente.getInstance();
            boolean success = cliDAO.insertCliente(cli);
            
            String msg = "";
            if(success)
                msg = "Cliente:  " + cli.getNome_cliente().toUpperCase()+ "  inserido com sucesso";
            else
                msg = "Falha ao inserir cliente.";
         
            out.print("<script type='text/javascript'> alert('" + msg + "'); window.location.href = '../View/novo_cliente.jsp' </script>");
        }
    }catch(Exception e){throw new RuntimeException("Erro ao gravar" + e);}
%>
