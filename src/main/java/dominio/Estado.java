package dominio;

public class Estado extends EntidadeDominio {	
	private String nomeEstado;
	private Pais pais;
	
	public String getNome() {
		return nomeEstado;
	}

	public void setNome(String nomeEstado) {
		this.nomeEstado = nomeEstado;
	}

	public Pais getPais() {
		return pais;
	}

	public void setPais(Pais pais) {
		this.pais = pais;
	}	
	
}
