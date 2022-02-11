using CRUD_C_Sharp.Models;
using System;
using System.Collections.Generic;
using System.Data;

namespace CRUD_C_Sharp.DAO
{
    public class DAOCliente
    {
        MySQLPersistence _bd = new MySQLPersistence();
        private static DAOCliente instance;
        private DAOCliente() { }
        public static DAOCliente getInstance()
        {
            if (instance == null)
                instance = new DAOCliente();
            return instance;
        }

        public bool insertCliente(Cliente cliente)
        {
            bool success = false;
            try
            {
                string sql = "INSERT INTO tb_cliente (nome_cliente, email_cliente, telefone_cliente) VALUES (@a, @b, @c)";

                _bd.clearParameter();
                _bd.addParameter("@a", cliente.Nome);
                _bd.addParameter("@b", cliente.Email);
                _bd.addParameter("@c", cliente.Telefone);

                _bd.openConnection();

                if (_bd.manipulate(sql) >= 1)
                    success = true;

                _bd.closeConnection();
            }
            catch (Exception ex){ throw new Exception("Erro" + ex); }
            return success;
        }
        public bool updateCliente(Cliente cliente)
        {
            bool success = false;
            try
            {
                string sql = "UPDATE tb_cliente SET nome_cliente = @a, email_cliente = @b, telefone_cliente = @c WHERE id_cliente = @d";

                _bd.clearParameter();
                _bd.addParameter("@a", cliente.Nome);
                _bd.addParameter("@b", cliente.Email);
                _bd.addParameter("@c", cliente.Telefone);
                _bd.addParameter("@d", cliente.Id);

                _bd.openConnection();

                if (_bd.manipulate(sql) >= 1)
                    success = true;

                _bd.closeConnection();
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return success;
        }

        public bool deleteCliente(int id)
        {
            bool success = false;
            try
            {
                string sql = "DELETE FROM tb_cliente WHERE id_cliente = @a";

                _bd.clearParameter();
                _bd.addParameter("@a", id);
               
                _bd.openConnection();

                if (_bd.manipulate(sql) >= 1)
                    success = true;

                _bd.closeConnection();
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return success;
        }

        public IEnumerable<Cliente> getClientes()
        {
            List<Cliente> clientes = new List<Cliente>();
            try
            {
                string sql = "SELECT * FROM tb_cliente";
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var cli = new Cliente()
                    {
                        Id = Convert.ToInt32(row["id_cliente"]),
                        Nome = row["nome_cliente"].ToString(),
                        Email = row["email_cliente"].ToString(),
                        Telefone = row["telefone_cliente"].ToString()
                    };
                    clientes.Add(cli);
                }

            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return clientes;
        }
        public IEnumerable<Cliente> getClientesFilter(string nome)
        {
            List<Cliente> clientes = new List<Cliente>();
            try
            {
                string sql = "SELECT * FROM tb_cliente WHERE nome_cliente LIKE '%"+nome+"%'";
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var cli = new Cliente()
                    {
                        Id = Convert.ToInt32(row["id_cliente"]),
                        Nome = row["nome_cliente"].ToString(),
                        Email = row["email_cliente"].ToString(),
                        Telefone = row["telefone_cliente"].ToString()
                    };
                    clientes.Add(cli);
                }
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return clientes;
        }

        public IEnumerable<Cliente> getClientesById(int id)
        {
            List<Cliente> clientes = new List<Cliente>();
            try
            {
                string sql = "SELECT * FROM tb_cliente WHERE id_cliente = " + id;
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var cli = new Cliente()
                    {
                        Id = Convert.ToInt32(row["id_cliente"]),
                        Nome = row["nome_cliente"].ToString(),
                        Email = row["email_cliente"].ToString(),
                        Telefone = row["telefone_cliente"].ToString()
                    };
                    clientes.Add(cli);
                }
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return clientes;
        }
    }
}
