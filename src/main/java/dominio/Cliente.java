package dominio;

import java.util.List;

public class Cliente extends EntidadeDominio{
	private String nome;
	private Genero genero;
	private String dataNascimento;
	private String cpf;	
	private String email;
	private String senha;
	private String confirmarSenha;
	private Telefone telefone;	
	private boolean status;  
	private Endereco enderecoResidencial;		    
    private List<Endereco> enderecoEntrega;  
    private List<Endereco> enderecoCobranca;
    private List<Cartao> cartao;   
	
       
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Genero getGenero() {
		return genero;
	}
	public void setGenero(Genero genero) {
		this.genero = genero;
	}	
	public String getDataNascimento() {
		return dataNascimento;
	}
	public void setDataNascimento(String dataNascimento) {
		this.dataNascimento = dataNascimento;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public Telefone getTelefone() {
		return telefone;
	}
	public void setTelefone(Telefone telefone) {
		this.telefone = telefone;
	}
	public List<Cartao> getCartao(){
		return cartao;
	}
	public void setCartao(List<Cartao> cartao){
		this.cartao = cartao;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}	
	public String getConfirmarSenha() {
		return confirmarSenha;
	}
	public void setConfirmarSenha(String confirmarSenha) {
		this.confirmarSenha = confirmarSenha;
	}
	public Endereco getEnderecoResidencial() {
		return enderecoResidencial;
	}
	public void setEnderecoResidencial(Endereco enderecoResidencial) {
		this.enderecoResidencial = enderecoResidencial;
	}
	public List<Endereco> getEnderecoCobranca() {
		return enderecoCobranca;
	}
	public void setEnderecoCobranca(List<Endereco> enderecoCobranca) {
		this.enderecoCobranca = enderecoCobranca;
	}
	public List<Endereco> getEnderecoEntrega() {
		return enderecoEntrega;
	}	  	
	public boolean getStatus() {
		return status;
	}
    public void setStatus(boolean status) {
		this.status = status;
	}
}
