package controle;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dao.*;
import dominio.*;
import regrasnegocio.implementacao.*;
import regrasnegocio.IStrategy;


public class Fachada implements IFachada {

	private Map<String, IDAO> daos;
	private Map<String, List<IStrategy>> rns;	
	
	public Fachada() {
        definirRNS();
        definirDAOS();	 
	}

    private void definirRNS() {
		rns = new HashMap<String, List<IStrategy>>();
				
		ValidarCliente vCliente = new ValidarCliente();
		ValidarCPF vCpf = new ValidarCPF();
		ValidarTelefone vTelefone = new ValidarTelefone();
		ValidarCartao vCartao = new ValidarCartao();
		ValidarEndereco vEndereco = new ValidarEndereco();				 
				 
		List<IStrategy> rnsCliente = new ArrayList<IStrategy>(); //Cria instâncias de classes que implementam a interface IStrategy para validações específicas.
		rnsCliente.add(vCliente); 
		rnsCliente.add(vCpf);
		rnsCliente.add(vTelefone);
		rnsCliente.add(vEndereco);
		rns.put(Cliente.class.getName(), rnsCliente); //adiciona a lista de estrategias a chave cliente.class.getname() 
		 
		List<IStrategy> rnsCartao = new ArrayList<IStrategy>();
		rnsCartao.add(vCartao);
		rns.put(Cartao.class.getName(), rnsCartao);
			    
		List<IStrategy> rnsEndereco = new ArrayList<IStrategy>();
		rnsEndereco.add(vEndereco);			    
		rns.put(Endereco.class.getName(), rnsEndereco);
		
		 
    }

    private void definirDAOS() {
        daos = new HashMap<String, IDAO>();
        daos.put(Cliente.class.getName(), new ClienteDAO()); //adiciona uma instancia de ClienteDAO associada a chave cliente.class.getName() 
        daos.put(Cartao.class.getName(), new CartaoDAO());		
        daos.put(Endereco.class.getName(), new EnderecoDAO());
        //daos.put(Telefone.class.getName(), new TelefoneDAO());
    }

    @Override
	public String salvar(EntidadeDominio entidade) {    	
		String classe = entidade.getClass().getName();		
		String msg = executar(entidade);
						
        if (msg == null) {
			IDAO dao = daos.get(classe);
			LoggerDAO log = new LoggerDAO();
			log.saveLogToDatabase(new Date().toString(), classe);
			return dao.salvar(entidade);
		} else {
			return msg;
		}
		
	}

    @Override
	public String alterar(EntidadeDominio entidade) {
		String classe = entidade.getClass().getName();
		
		IDAO dao = daos.get(classe);		
		dao.alterar(entidade);	
		LoggerDAO log = new LoggerDAO();
		log.saveLogToDatabase(new Date().toString(), classe);		
		return null;
	}

    @Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {    	
		String classe = entidade.getClass().getName();		
        IDAO dao = daos.get(classe);        
        return dao.consultar(entidade);
	}

    @Override
	public String excluir(EntidadeDominio entidade) {
		String classe = entidade.getClass().getName();		
        IDAO dao = daos.get(classe);
        dao.excluir(entidade);
        return null;
	}
    
    @Override
    public EntidadeDominio selecionar(EntidadeDominio entidade) {    	
		String classe = entidade.getClass().getName();		
        IDAO dao = daos.get(classe);        
        return dao.selecionar(entidade);
	}

    private String executar(EntidadeDominio entidade){
        String classe = entidade.getClass().getName();
        
		List<IStrategy> rnEntidade = rns.get(classe); //obtem a lista de estrategias associadas a classe
		
		StringBuilder sb = new StringBuilder(); 
		for(IStrategy s:rnEntidade) {
			String msg =s.processar(entidade); //itera sobre as estrategias e chama o metodo processar de cada uma			
			if(msg != null) { 
				sb.append(msg); //se tiver um campo em branco adiciona no string builder
			}
		}
		if(sb.length()>0) { // se tiver conteudo dentro do string builder, ele exibe o erro
			return sb.toString();
		}else { //se tudo tiver sido preenchido corretamente, salva no banco				
			return null;
		}
    }     

}
