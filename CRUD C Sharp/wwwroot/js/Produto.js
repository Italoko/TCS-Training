let produto = {
    inserir: () => {
        let dados = {
            nome: document.getElementById("txtNome").value,
            qtd: document.getElementById("txtQtd").value
        }

        if (dados.nome == "")
            alert("Nome é obrigatório.");
        else if (dados.qtd == "")
            alert("Quantidade é obrigatório.");
        else if (dados.qtd < 0)
            alert("Quantidade inválida.");
        else {
            HTTPClient.post("/Produto/inserir_produto", dados)
                .then(result => {
                    return result.json();
                }).then(dados => {
                    if (dados.success)
                        msg = "Produto: " + dados.nome + "gravado com sucesso.";
                    else
                        msg = "Não foi possível gravar o Produto:" + dados.nome;
                    alert(msg);
                }) .catch(() => {
                    console.log("Erro ao inserir_Produto");
                });
             }
    },
    editar: () => {
        let dados = {
            id: document.getElementById("txtID").value,
            nome: document.getElementById("txtNome").value,
            qtd: document.getElementById("txtQtd").value
        }

        if (dados.nome == "")
            alert("Nome é obrigatório.");
        else if (dados.qtd == "")
            alert("Quantidade é obrigatório.");
        else if (dados.qtd < 0)
            alert("Quantidade inválida.");
        else {
            HTTPClient.put("/Produto/alterar_produto", dados)
                .then(result => {
                    return result.json();
                }).then(dados => {
                    if (dados.success)
                        msg = "Produto: " + dados.nome + "alterado com sucesso.";
                    else
                        msg = "Não foi possível gravar o produto:" + dados.nome;
                    alert(msg);
                }).catch(() => {
                    console.log("Erro ao editar produto");
                });
            produto.obterProdutos();
        }
    },
    obterProdutos: () => {
        HTTPClient.get("/Produto/obter_produtos")
            .then(result => {
                return result.json();
            })
            .then(dados => {
                produto.preencherProdutos(dados);
            })
            .catch(() => {
                alert("Não foi possível obter produtos.");
            })
    },
    preencherProdutos: (dados) => {
        produtos = ``;
        alter_icon = "<i class='far fa-edit'></i>"
        delete_icon = "<i class='far fa-trash-alt'></i>"
        for (let i = 0; i < dados.length; i++) {
            produtos += `<tr>
                        <td>${dados[i].id}</td>
                        <td>${dados[i].nome}</td>
                        <td>${dados[i].quantidade}</td>
                        <td><a href='/Produto/edit_produto?id=${dados[i].id}'>${alter_icon}</a></td>
                        <td><a href='/Produto/delete_produto?id=${dados[i].id}'>${delete_icon}</a></td>
                        </tr>`;
        }
        document.getElementById("tbody_prod").innerHTML = produtos;
    }
}