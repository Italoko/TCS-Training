let cliente = {
    inserir: () => {
        let dados = {
            nome: document.getElementById("txtNome").value,
            email: document.getElementById("txtEmail").value,
            telefone: document.getElementById("txtTelefone").value,
        }

        if (dados.nome == "")
            alert("Nome é obrigatório.");
        else if (dados.email == "")
            alert("Email é obrigatório.");
        else if (dados.telefone == "")
            alert("Telefone é obrigatório.");
        else {
            HTTPClient.post("/Cliente/inserir_cliente", dados)
                .then(result => {
                    return result.json();
                }).then(dados => {
                    if (dados.success)
                        msg = "Cliente: " + dados.nome + "gravado com sucesso.";
                    else
                        msg = "Não foi possível gravar o cliente:" + dados.nome;
                    alert(msg);
                }) .catch(() => {
                    console.log("Erro ao inserir_cliente");
                });
             }
    },
    editar: () => {
        let dados = {
            id: document.getElementById("txtID").value,
            nome: document.getElementById("txtNome").value,
            email: document.getElementById("txtEmail").value,
            telefone: document.getElementById("txtTelefone").value,
        }

        if (dados.nome == "")
            alert("Nome é obrigatório.");
        else if (dados.email == "")
            alert("Email é obrigatório.");
        else if (dados.telefone == "")
            alert("Telefone é obrigatório.");
        else {
            HTTPClient.put("/Cliente/alterar_cliente", dados)
                .then(result => {
                    return result.json();
                }).then(dados => {
                    if (dados.success)
                        msg = "Cliente: " + dados.nome + "alterado com sucesso.";
                    else
                        msg = "Não foi possível gravar o cliente:" + dados.nome;
                    alert(msg);
                }).catch(() => {
                    console.log("Erro ao editar cliente");
                });
            cliente.obterClientes();
        }
    },
    obterClientes: (filter) => {
        url = "/Cliente/obter_clientes/" + filter
        HTTPClient.get(url)
            .then(result => {
                return result.json();
            })
            .then(dados => {
                cliente.preencherClientes(dados);
            })
            .catch(() => {
                alert("Não foi possível obter clientes.");
            })
    },
    preencherClientes: (dados) => {
        clientes = ``;
        alter_icon = " <i class='fas fa-user-edit'></i></a>"
        delete_icon = "<i class='fas fa-user-minus'></i>"
        for (let i = 0; i < dados.length; i++)
        {
            clientes += `<tr>
                        <td>${dados[i].id}</td>
                        <td>${dados[i].nome}</td>
                        <td>${dados[i].email}</td>
                        <td>${dados[i].telefone}</td>
                        <td><a href='/Cliente/edit_cliente?id=${dados[i].id}'>${alter_icon}</a></td>
                        <td><a href='/Cliente/delete_cliente?id=${dados[i].id}'>${delete_icon}</a></td>
                        </tr>`;
        }
        document.getElementById("tbody_cli").innerHTML = clientes;
    }
}