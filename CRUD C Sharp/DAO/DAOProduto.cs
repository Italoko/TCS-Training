using CRUD_C_Sharp.Models;
using System;
using System.Collections.Generic;
using System.Data;

namespace CRUD_C_Sharp.DAO
{
    public class DAOProduto
    {
        MySQLPersistence _bd = new MySQLPersistence();
        private static DAOProduto instance;
        private DAOProduto() { }
        public static DAOProduto getInstance()
        {
            if (instance == null)
                instance = new DAOProduto();
            return instance;
        }

        public bool insertProduto(Produto produto)
        {
            bool success = false;
            try
            {
                string sql = "INSERT INTO tb_produto (nome_produto, qtd_produto) VALUES (@a, @b)";

                _bd.clearParameter();
                _bd.addParameter("@a", produto.Nome);
                _bd.addParameter("@b", produto.Quantidade);

                _bd.openConnection();

                if (_bd.manipulate(sql) >= 1)
                    success = true;

                _bd.closeConnection();
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return success;
        }
        public bool updateProduto(Produto produto)
        {
            bool success = false;
            try
            {
                string sql = "UPDATE tb_produto SET nome_produto = @a, qtd_produto = @b WHERE id_produto = @c";

                _bd.clearParameter();
                _bd.addParameter("@a", produto.Nome);
                _bd.addParameter("@b", produto.Quantidade);
                _bd.addParameter("@c", produto.Id);

                _bd.openConnection();

                if (_bd.manipulate(sql) >= 1)
                    success = true;

                _bd.closeConnection();
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return success;
        }

        public bool deleteProduto(int id)
        {
            bool success = false;
            try
            {
                string sql = "DELETE FROM tb_produto WHERE id_produto = @a";

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

        public IEnumerable<Produto> getProdutos()
        {
            List<Produto> produtos = new List<Produto>();
            try
            {
                string sql = "SELECT * FROM tb_produto";
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var prod = new Produto()
                    {
                        Id = Convert.ToInt32(row["id_produto"]),
                        Nome = row["nome_produto"].ToString(),
                        Quantidade = Convert.ToInt32(row["qtd_produto"])
                    };
                    produtos.Add(prod);
                }
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return produtos;
        }
        public IEnumerable<Produto> getProdutosFilter(string nome)
        {
            List<Produto> produtos = new List<Produto>();
            try
            {
                string sql = "SELECT * FROM tb_produto WHERE nome_produto LIKE '%" + nome + "%'";
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var prod = new Produto()
                    {
                        Id = Convert.ToInt32(row["id_produto"]),
                        Nome = row["nome_produto"].ToString(),
                        Quantidade = Convert.ToInt32(row["qtd_produto"])
                    };
                    produtos.Add(prod);
                }
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return produtos;
        }

        public IEnumerable<Produto> getProdutosById(int id)
        {
            List<Produto> produtos = new List<Produto>();
            try
            {
                string sql = "SELECT * FROM tb_produto WHERE id_produto = " + id;
                _bd.openConnection();
                DataTable dt = _bd.executeQuery(sql);
                _bd.closeConnection();
                foreach (DataRow row in dt.Rows)
                {
                    var prod = new Produto()
                    {
                        Id = Convert.ToInt32(row["id_produto"]),
                        Nome = row["nome_produto"].ToString(),
                        Quantidade = Convert.ToInt32(row["qtd_produto"])
                    };
                    produtos.Add(prod);
                }
            }
            catch (Exception ex) { throw new Exception("Erro" + ex); }
            return produtos;
        }
    }


}
