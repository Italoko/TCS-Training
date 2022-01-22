package MODEL;
/**
 *
 * @author ITALO PIOVAN
 */
public class Produto 
{
    private int id_produto;
    private String nome_produto; 
    private int qtd_produto;
    
    public Produto(String nome_produto, int qtd_produto) {
        this.nome_produto = nome_produto;
        this.qtd_produto = qtd_produto;
    }
    
    public Produto(int id_produto, String nome_produto, int qtd_produto) {
        this.id_produto = id_produto;
        this.nome_produto = nome_produto;
        this.qtd_produto = qtd_produto;
    }

    public int getId_produto() {
        return id_produto;
    }

    public void setId_produto(int id_produto) {
        this.id_produto = id_produto;
    }

    public String getNome_produto() {
        return nome_produto;
    }

    public void setNome_produto(String nome_produto) {
        this.nome_produto = nome_produto;
    }

    public int getQtd_produto() {
        return qtd_produto;
    }

    public void setQtd_produto(int qtd_produto) {
        this.qtd_produto = qtd_produto;
    }
}
