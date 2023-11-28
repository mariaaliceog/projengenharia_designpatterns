package dominio;

import java.time.LocalDate;

public class EntidadeDominio {
	
	private int id;
	private LocalDate dataCadastro;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public LocalDate getDtCadastro() {
		return dataCadastro;
	}
	public void setDtCadastro(LocalDate dataCadastro) {
		this.dataCadastro = dataCadastro;
	}		
}
