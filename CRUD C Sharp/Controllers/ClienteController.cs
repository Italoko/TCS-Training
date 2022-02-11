using CRUD_C_Sharp.DAO;
using CRUD_C_Sharp.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;

namespace CRUD_C_Sharp.Controllers
{
    public class ClienteController : Controller
    {
        public ActionResult novo_cliente()
        {
            return View();
        }

        [HttpPost]
        public IActionResult inserir_cliente([FromBody] System.Text.Json.JsonElement dados)
        {
            Cliente cli = new Cliente()
            {
                Nome = dados.GetProperty("nome").ToString(),
                Email = dados.GetProperty("email").ToString(),
                Telefone = dados.GetProperty("telefone").ToString()
            };

            bool success = DAOCliente.getInstance().insertCliente(cli);
            var result = new { success, nome = cli.Nome };
            return Json(result);
        }

        public ActionResult edit_cliente(int id)
        {
            ViewBag.id = id;
            return View();
        }

        public ActionResult alterar_cliente([FromBody] System.Text.Json.JsonElement dados)
        {
            Cliente cli = new Cliente()
            {
                Id = Convert.ToInt32(dados.GetProperty("id").ToString()),
                Nome = dados.GetProperty("nome").ToString(),
                Email = dados.GetProperty("email").ToString(),
                Telefone = dados.GetProperty("telefone").ToString()
            };

            bool success = DAOCliente.getInstance().updateCliente(cli);
            var result = new { success, nome = cli.Nome };
            return Json(result);
        }

        public ActionResult delete_cliente(int id)
        {
            DAOCliente.getInstance().deleteCliente(id);
            return View("consultar_cliente");
        }

        public ActionResult consultar_cliente()
        {
            return View();
        }

        [HttpGet]
        public ActionResult obter_clientes(string filter)
        {
            IEnumerable<Cliente> clientes;
            if (filter != "")
                clientes = DAOCliente.getInstance().getClientes();
            else
                clientes = DAOCliente.getInstance().getClientesFilter(filter);
            return Json(clientes);
        }
    }
}