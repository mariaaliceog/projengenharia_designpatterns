package dominio;

public class Telefone extends EntidadeDominio {
	private TipoTelefone tipo;
	private String ddd;
	private String numero;	
	 
//	public Telefone(TipoTelefone tipo, String ddd, String numero) {
//		String[] partes = numero.split(":");
//		
//		if (partes.length == 3) {
//            this.tipo = TipoTelefone.valueOf(partes[0]);
//            this.ddd = partes[1];
//            this.numero = partes[2];
//        }
//	}
		
	public TipoTelefone getTipo() {
		return tipo;
	}
	public void setTipo(TipoTelefone tipo) {
		this.tipo = tipo;
	}
	public String getDdd() {
		return ddd;
	}
	public void setDdd(String ddd) {
		this.ddd = ddd;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}	
	public String getNumeroCompleto() {
        return ddd + numero;
    }
	
}
