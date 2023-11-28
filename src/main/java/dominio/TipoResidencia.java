package dominio;

public enum TipoResidencia {
    CASA(1,"Casa"),
    APARTAMENTO(2,"Apartamento"),
    CHACARA(3,"Chácara"),
    CONDOMINIO(4,"Condominio"),
    OUTRO(5,"Outro");

    private String descricao;
    private int id;

    TipoResidencia(int id,String descricao) {
    	this.setId(id);
        this.descricao = descricao;
    }
    
	public String getDescricao() {
        return descricao;
    }
	
	public void setDescricao(String descricao) {
        this.descricao=descricao;
    }
	
    public void setId(int id) {
		this.id=id;		
	}
    
    public int getId() {
    	return id;
    }
}
