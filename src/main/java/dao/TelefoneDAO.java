package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.util.List;
import dominio.*;


public class TelefoneDAO implements IDAO {
	public String salvar(EntidadeDominio entidade) {
		String sql = "INSERT INTO telefones(ddd, numero,tipo) VALUES (?,?,?)";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			// criar uma conexao com o banco de dados
			conn = Conexao.createConnectionToMySQL();
			
			// foi criada uma prepareStatement para executar uma Query
			mysql = conn.prepareStatement(sql);
			
			// adicionar os valores que sao esperados pela query
			mysql.setString(1,((Telefone) entidade).getDdd());
			mysql.setString(2,((Telefone) entidade).getNumero());
			mysql.setString(3,((Telefone) entidade).getTipo().getNome());			
			
			//	executar a query
			mysql.execute();
			
			System.out.println("Telefone salvo com sucesso");
			
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			// fechar as conexoes
			try {
				if(mysql!=null) {
					mysql.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return sql;
	}

	public int alterar(EntidadeDominio entidade) {
		return 0;
		// TODO Auto-generated method stub
		
	}

	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	public String excluir(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EntidadeDominio selecionar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}

}
