using CRUD_C_Sharp.DAO;
using CRUD_C_Sharp.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;

namespace CRUD_C_Sharp.Controllers
{
    public class ProdutoController : Controller
    {
        public ActionResult novo_produto()
        {
            return View();
        }

        [HttpPost]
        public IActionResult inserir_produto([FromBody] System.Text.Json.JsonElement dados)
        {
            Produto prod = new Produto()
            {
                Nome = dados.GetProperty("nome").ToString(),
                Quantidade = Convert.ToInt32(dados.GetProperty("qtd").ToString())
            };

            bool success = DAOProduto.getInstance().insertProduto(prod);
            var result = new { success, nome = prod.Nome };
            return Json(result);
        }

        public ActionResult edit_produto(int id)
        {
            ViewBag.id = id;
            return View();
        }

        public ActionResult alterar_produto([FromBody] System.Text.Json.JsonElement dados)
        {
            Produto prod = new Produto()
            {
                Id = Convert.ToInt32(dados.GetProperty("id").ToString()),
                Nome = dados.GetProperty("nome").ToString(),
                Quantidade = Convert.ToInt32(dados.GetProperty("qtd").ToString())
            };

            bool success = DAOProduto.getInstance().updateProduto(prod);
            var result = new { success, nome = prod.Nome };
            return Json(result);
        }

        public ActionResult delete_produto(int id)
        {
            DAOProduto.getInstance().deleteProduto(id);
            return View("consultar_produto");
        }

        public ActionResult consultar_produto()
        {
            return View();
        }

        [HttpGet]
        public ActionResult obter_produtos()
        {
            IEnumerable<Produto> produtos = DAOProduto.getInstance().getProdutos();
            return Json(produtos);
        }
    }
}
