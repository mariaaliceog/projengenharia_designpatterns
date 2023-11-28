package regrasnegocio.implementacao;

import dominio.Cartao;
import dominio.EntidadeDominio;
import regrasnegocio.IStrategy;

public class ValidarCartao implements IStrategy {

    @Override
    public String processar(EntidadeDominio entidade) {
        StringBuilder stringBuilder = new StringBuilder();
        
        if(entidade==null){
            return "Entidade nula";
        }
        
        if(entidade instanceof Cartao){        	
            Cartao cartao = (Cartao)entidade; //converte entidade para o tipo cartao
            
			if(cartao.getNumero()==null || cartao.getNumero().equals("")){
				stringBuilder.append("Número do cartão é obrigatório");
			}
			if(cartao.getNomeTitular()==null){
				stringBuilder.append("Nome do Titular é obrigatório");
			}
            if(cartao.getCodSeguranca()==null || cartao.getCodSeguranca().equals("")){
				stringBuilder.append("Codigo de segurança é obrigatório");
			}else if(cartao.getCodSeguranca().length()!=3){
                stringBuilder.append("Código de segurança inválido");
            }
			            
		}
        return stringBuilder.toString();
    }
}
    

