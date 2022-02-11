using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CRUD_C_Sharp.Models
{
    public class Produto
    {
        int _id;
        string _nome;
        int _quantidade;

        public Produto() { }
        public Produto(string nome, int quantidade)
        {
            _nome = nome;
            _quantidade = quantidade;
        }

        public int Id { get => _id; set => _id = value; }
        public string Nome { get => _nome; set => _nome = value; }
        public int Quantidade { get => _quantidade; set => _quantidade = value; }
    }
}
