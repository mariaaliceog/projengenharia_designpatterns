package controle;

import java.util.List;

import dominio.EntidadeDominio;

public interface IFachada {
    public String salvar(EntidadeDominio entidade);
	// public String salvarDep(EntidadeDominio entidade, String id);
	public String alterar(EntidadeDominio entidade);
	public String excluir(EntidadeDominio entidade);
	public List<EntidadeDominio> consultar(EntidadeDominio entidade);	
	public EntidadeDominio selecionar(EntidadeDominio entidade);
}
