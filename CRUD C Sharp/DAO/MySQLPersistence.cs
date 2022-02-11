using MySqlConnector;
using System.Collections.Generic;
using System.Data;

namespace CRUD_C_Sharp.DAO
{
    public class MySQLPersistence
    {
        string _url = "";
        MySqlConnection _connection;
        MySqlCommand _command;

        public MySQLPersistence()
        {
            _url = "Server = 127.0.0.1; Port = 3306; Database = bdavaliacao; Uid = root; Pwd = #Senha123;"; 
            // "Server=127.0.0.1:3306;Database=bdavaliacao;Uid=root;Pwd=#Senha123;";
            _connection = new MySqlConnection(_url);
            _command = _connection.CreateCommand();
        }

        public bool getConnectionStatus()
        {
            if (_connection.State == System.Data.ConnectionState.Open)
                return true;
            return false;
        }

        public void openConnection()
        {
            if (!getConnectionStatus())
                _connection.Open();
        }

        public void closeConnection()
        {
            _connection.Close();
        }

        public void addParameter(string param, object value)
        {
            _command.Parameters.AddWithValue(param, value);
        }

        public void clearParameter()
        {
            _command.Parameters.Clear();
        }

        public int manipulate(string sql, Dictionary<string, object> parameters = null)
        {
            _command.CommandText = sql;
            if (parameters != null)
                foreach (var item in parameters)
                    _command.Parameters.AddWithValue(item.Key, item.Value);
            return _command.ExecuteNonQuery();
        }

        public DataTable executeQuery(string sql, Dictionary<string, object> parameters = null)
        {
            DataTable dt = new DataTable();
            _command.CommandText = sql;

            if (parameters != null)
                foreach (var item in parameters)
                    _command.Parameters.AddWithValue(item.Key, item.Value);
        
            dt.Load(_command.ExecuteReader());
            return dt;
        }
    }
}
