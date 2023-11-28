package dominio;

public enum TipoTelefone {
	CELULAR(1,"CELULAR"),
	RESIDENCIAL(2,"RESIDENCIAL"),
	COMERCIAL(3,"COMERCIAL"),
	OUTRO(4,"OUTRO");
	
	private int id;
	private String nome;
	
	TipoTelefone(int i, String nome) {
		this.setId(id);
        this.nome = nome;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}	
}
