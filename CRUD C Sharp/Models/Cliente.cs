using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CRUD_C_Sharp.Models
{
    public class Cliente
    {
        int _id;
        string _nome;
        string _email;
        string _telefone;

        public Cliente() { }

        public Cliente(int id, string nome, string email, string telefone)
        {
            _id = id;
            _nome = nome;
            _email = email;
            _telefone = telefone;
        }

        public Cliente(string nome, string email, string telefone)
        {
            _nome = nome;
            _email = email;
            _telefone = telefone;
        }

        public int Id { get => _id; set => _id = value; }
        public string Nome { get => _nome; set => _nome = value; }
        public string Email { get => _email; set => _email = value; }
        public string Telefone { get => _telefone; set => _telefone = value; }
    }
}
