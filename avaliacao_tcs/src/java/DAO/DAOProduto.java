package DAO;

import MODEL.Produto;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author ITALO PIOVAN
 */
public class DAOProduto 
{
    private static DAOProduto instance;
    private Conexao conn = new Conexao();
    
    private DAOProduto() {}
    
    public static synchronized DAOProduto getInstance() 
    {
        if (instance == null)
            instance = new DAOProduto();
        return instance;
    }
    
    public boolean insertProduto(Produto produto)
    {
        boolean success = false;
        String sql = "INSERT INTO tb_produto (nome_produto, qtd_produto) VALUES ('@a', '@b')";
        
        sql = sql.replace("@a", produto.getNome_produto());
        sql = sql.replace("@b", Integer.toString(produto.getQtd_produto()));
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        
        return success;
    }
    
    public boolean updateProduto(Produto produto)
    {
        boolean success = false;
        String sql = "UPDATE tb_produto SET nome_produto = '@a', qtd_produto = '@b' WHERE id_produto = @c";
        
        sql = sql.replace("@a", produto.getNome_produto());
        sql = sql.replace("@b", Integer.toString(produto.getQtd_produto()));
        sql = sql.replace("@c", Integer.toString(produto.getId_produto()));
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        return success;
    }
    
    public boolean deleteProduto(int id)
    {
        boolean success = false;
        String sql = "DELETE FROM tb_produto WHERE id_produto = @a";
   
        sql = sql.replace("@a", Integer.toString(id));
        
        conn.openConnection();
        success = conn.manipulate(sql);
        conn.closeConnection();
        return success;
    }
    
    public ArrayList<Produto> getProdutos(String order)
    {
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        try{
            String sql = "SELECT * FROM tb_produto";
            
            if(order!= null && !order.isEmpty())
               switch(order)
               {
                   case "MAX":
                       sql = sql + " ORDER BY qtd_produto DESC";
                       break;
                    case "MIN":
                        sql = sql + " ORDER BY qtd_produto ASC";
                        break;
               }
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null)
                while(rs.next())
                    produtos.add(new Produto(rs.getInt("id_produto"), rs.getString("nome_produto"), rs.getInt("qtd_produto")));
            
            conn.closeConnection();   
        }catch(Exception e){throw new RuntimeException("Erro ao listar produtos" + e);}
        return produtos;
    }
    
    public ArrayList<Produto> getProdutosFilter(String nome, String order)
    {
        ArrayList<Produto> produtos = new ArrayList<Produto>();
        try{
            String sql = "SELECT * FROM tb_produto WHERE nome_produto LIKE '%" +nome+ "%'";
            
            if(order!= null && !order.isEmpty())
               switch(order)
               {
                   case "MAX":
                       sql = sql + " ORDER BY qtd_produto DESC";
                       break;
                    case "MIN":
                        sql = sql + " ORDER BY qtd_produto ASC";
                        break;
               }
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null)
                while(rs.next())
                    produtos.add(new Produto(rs.getInt("id_produto"), rs.getString("nome_produto"), rs.getInt("qtd_produto")));
                                            
            conn.closeConnection();
        }catch(Exception e){throw new RuntimeException("Erro ao listar produtos" + e);}
        return produtos;
    }
    
    public Produto getProdutoById(int id)
    {
        Produto produto = null;
        try{
            String sql = "SELECT * FROM tb_produto WHERE id_produto = "+id;
            
            conn.openConnection();
            ResultSet rs = conn.query(sql);
            
            if(rs != null && rs.next())
                produto = new Produto(rs.getInt("id_produto"), rs.getString("nome_produto"), rs.getInt("qtd_produto"));
            
            conn.closeConnection();
        }catch(Exception e){throw new RuntimeException("Erro ao listar produto pelo id" + e);}
        return produto;
    }
}
