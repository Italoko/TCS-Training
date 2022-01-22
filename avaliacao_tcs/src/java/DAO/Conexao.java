package DAO;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author ITALO PIOVAN
 */
public class Conexao 
{
    private Statement st;
    
    public Connection getConnection() 
    {
        String schema = "BDAvaliacao";
        String us_bd = "root";
        String pw_bd = "#Senha123";
        
        try{
            String url = "jdbc:mysql://localhost:3306/"+schema+"?useTimezone=true&serverTimezone=UTC";
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(url,us_bd,pw_bd);
        }
        catch (ClassNotFoundException cnfex){throw new RuntimeException("Falha ao ler o driver JDBC: " + cnfex.toString());}
        catch (SQLException sqlex) {throw new RuntimeException("Erro ao conectar com a base de dados: " + sqlex.toString());}
        catch (Exception e) {throw new RuntimeException("Erro: " + e.toString());}
    }
    
    public void openConnection()
    {
        try{
            if(st == null || st.isClosed())
                this.st = getConnection().createStatement();
        }catch (Exception e) {throw new RuntimeException("Erro ao abrir conexão: " + e.toString());}
    }
    
    public void closeConnection()
    {
        try{
            if(st != null && !st.isClosed())
                st.close();
        } catch(Exception e){throw new RuntimeException("Erro ao fechar conexão: " + e.toString());}   
    }
    
    public boolean getStateConnection()
    {
        try{
            if(st != null)
                return !st.isClosed();
        } catch(Exception e){throw new RuntimeException("Erro:" + e.toString());}
        return false;
    }
    
    public boolean manipulate(String sql)
    {
        try {
            return st.executeUpdate(sql) >= 1;
        }catch (SQLException sqlex) {throw new RuntimeException("Erro na manipulação: " + sqlex.toString());}
    }

    public ResultSet query(String sql) 
    {
        ResultSet rs = null;
        try {
            rs = st.executeQuery(sql); 
        } catch (SQLException sqlex) {throw new RuntimeException("Erro na consulta: " + sqlex.toString());}
        return rs;
    }
}
