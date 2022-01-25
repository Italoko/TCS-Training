package DAO;
import MODEL.Cliente;
import java.util.ArrayList;
import java.sql.ResultSet;

/**
 *
 * @author ITALO PIOVAN
 */
public class DAOCliente 
{
    private static DAOCliente instance;
    private Conexao conn = new Conexao();
    
    private DAOCliente() {}
    
    public static synchronized DAOCliente getInstance() 
    {
        if (instance == null)
            instance = new DAOCliente();
        return instance;
    }
    
    public boolean insertCliente(Cliente cliente)
    {
        boolean success = false;
        String sql = "INSERT INTO tb_cliente (nome_cliente, email_cliente, telefone_cliente) VALUES ('@a', '@b', '@c')";
        
        sql = sql.replace("@a", cliente.getNome_cliente());
        sql = sql.replace("@b", cliente.getEmail_cliente());
        sql = sql.replace("@c", cliente.getTelefone_cliente());
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        return success;
    }
    
    public boolean updateCliente(Cliente cliente)
    {
        boolean success = false;
        String sql = "UPDATE tb_cliente SET nome_cliente = '@a', email_cliente = '@b', telefone_cliente = '@c' WHERE id_cliente = @d";
        
        sql = sql.replace("@a", cliente.getNome_cliente());
        sql = sql.replace("@b", cliente.getEmail_cliente());
        sql = sql.replace("@c", cliente.getTelefone_cliente());
        sql = sql.replace("@d", Integer.toString(cliente.getId_cliente()));
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        return success;
    }
    
    public boolean deleteCliente(int id)
    {
        boolean success = false;
        String sql = "DELETE FROM tb_cliente WHERE id_cliente = @a";
   
        sql = sql.replace("@a", Integer.toString(id));
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        return success;
    }
    
    public ArrayList<Cliente> getClientes()
    {
        ArrayList<Cliente> clientes = new ArrayList<Cliente>();
        try{
            String sql = "SELECT * FROM tb_cliente";
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null)
                while(rs.next())
                    clientes.add(new Cliente(rs.getInt("id_cliente"), rs.getString("nome_cliente"), 
                                             rs.getString("email_cliente"), rs.getString("telefone_cliente")));
            
            conn.closeConnection();   
        }catch(Exception e){throw new RuntimeException("Erro ao listar clientes" + e);}
        return clientes;
    }
    
    public ArrayList<Cliente> getClientesFilter(String nome)
    {
        ArrayList<Cliente> clientes = new ArrayList<Cliente>();
        try{
            String sql = "SELECT * FROM tb_cliente WHERE nome_cliente LIKE '%" +nome+ "%'";
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null)
                while(rs.next())
                    clientes.add(new Cliente(rs.getInt("id_cliente"), rs.getString("nome_cliente"), 
                                             rs.getString("email_cliente"), rs.getString("telefone_cliente")));
            
            conn.closeConnection();
        }catch(Exception e){throw new RuntimeException("Erro ao listar clientes" + e);}
        return clientes;
    }
    
    public Cliente getClienteById(int id)
    {
        Cliente cliente = null;
        try{
            String sql = "SELECT * FROM tb_cliente WHERE id_cliente = "+id;
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null && rs.next())
                cliente = new Cliente(rs.getInt("id_cliente"), rs.getString("nome_cliente"),rs.getString("email_cliente"), rs.getString("telefone_cliente"));
            
            conn.closeConnection();
        }catch(Exception e){throw new RuntimeException("Erro ao listar cliente pelo id" + e);}
        return cliente;
    }
}
