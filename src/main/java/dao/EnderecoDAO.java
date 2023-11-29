package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.*;

public class EnderecoDAO implements IDAO{
	public String salvar(EntidadeDominio entidade) {
		String sql = "INSERT INTO endereco(cep,logradouro,numero,bairro,cliente_id,tipo_endereco_id, tipo_logradouro_id, tipo_residencia_id, cidade, estado, pais, observacao) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";			
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			// criar uma conexao com o banco de dados
			conn = Conexao.createConnectionToMySQL();
			
			// foi criada uma prepareStatement para executar uma Query
			mysql = conn.prepareStatement(sql);
			
			// adicionar os valores que sao esperados pela query	
			mysql.setString(1,((Endereco)entidade).getCep());
			mysql.setString(2,((Endereco)entidade).getLogradouro());
			mysql.setInt(3,((Endereco)entidade).getNumero());		
			mysql.setString(4,((Endereco)entidade).getBairro());
			mysql.setInt(5,((Endereco)entidade).getIdCliente());
			mysql.setInt(6,((Endereco)entidade).getTipoEndereco().getId());
			mysql.setInt(7,((Endereco)entidade).getTipoLogradouro().getId());
			mysql.setInt(8,((Endereco)entidade).getTipoResidencia().getId());
			mysql.setString(9,((Endereco)entidade).getCidade().getNome());
			mysql.setString(10,((Endereco)entidade).getCidade().getEstado().getNome());	
			mysql.setString(11,((Endereco)entidade).getCidade().getEstado().getPais().getNome());
			mysql.setString(12,((Endereco)entidade).getObservacao());
			
			//	executar a query
			mysql.execute();
			
			System.out.println("Endereço salvo com sucesso");
			return "Endereço salvo com sucesso";
			
		}catch(Exception e){
			e.printStackTrace();
			return "Erro ao salvar o endereco: " + e.getMessage();
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
	}

	public int alterar(EntidadeDominio entidade) {
		int status=0;
		String sql = "UPDATE endereco SET cep=?, logradouro=?, numero=?, bairro=?,cliente_id=?, tipo_endereco_id=?, tipo_logradouro_id=?, tipo_residencia_id=?, observacao=? WHERE id=?";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			conn = Conexao.createConnectionToMySQL();
			mysql = conn.prepareStatement(sql);				
		
			mysql.setString(1,((Endereco)entidade).getCep());
			mysql.setString(2,((Endereco)entidade).getLogradouro());
			mysql.setInt(3,((Endereco)entidade).getNumero());		
			mysql.setString(4,((Endereco)entidade).getBairro());
			mysql.setInt(5,((Endereco)entidade).getIdCliente());
			mysql.setInt(6,((Endereco)entidade).getTipoEndereco().getId());
			mysql.setInt(7,((Endereco)entidade).getTipoLogradouro().getId());
			mysql.setInt(8,((Endereco)entidade).getTipoResidencia().getId());
			mysql.setString(9,((Endereco)entidade).getObservacao());
			mysql.setInt(10,((Endereco)entidade).getId());
			status = mysql.executeUpdate();		
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(mysql!=null) {
					mysql.close();
				}
				if(conn!=null) {
					conn.close();
				}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}	
		
		return status;
	}

	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {		
		List<EntidadeDominio> listaEnderecos = new ArrayList<>();
		String sql = "SELECT id,cep,logradouro,numero,bairro,cliente_id, descricao_tip_end, descricao_tip_log, descricao_tip_res FROM endereco as a INNER JOIN tipos_endereco as b ON a.tipo_endereco_id=b.id_tip_end INNER JOIN tipos_logradouro as c ON a.tipo_logradouro_id=c.id_tip_log INNER JOIN tipos_residencia as d ON a.tipo_residencia_id=d.id_tip_res WHERE cliente_id=?";

	    try {
	        Connection conn = Conexao.createConnectionToMySQL();
	        PreparedStatement mysql = conn.prepareStatement(sql);	        
	        mysql.setInt(1,((Endereco) entidade).getIdCliente());
	        
	        ResultSet rs = mysql.executeQuery();               
	        
		    while (rs.next()) {
		            Endereco endereco = new Endereco();
		            endereco.setId(rs.getInt(1));
		            endereco.setCep(rs.getString(2));
		            endereco.setLogradouro(rs.getString(3));	
		            endereco.setNumero(rs.getInt(4));
		            endereco.setBairro(rs.getString(5));
		            endereco.setIdCliente(rs.getInt(6));
		            endereco.setTipoEndereco(TipoEndereco.valueOf(rs.getString(7)));
		            endereco.setTipoLogradouro(TipoLogradouro.valueOf(rs.getString(8)));
		            endereco.setTipoResidencia(TipoResidencia.valueOf(rs.getString(9)));		           
		            listaEnderecos.add(endereco);
	        }
		    
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }	    
	    return listaEnderecos;
	}
	

	public String excluir(EntidadeDominio entidade) {
		String sql = "DELETE from endereco WHERE id = ?";
	    Connection conn = null;
	    PreparedStatement mysql = null;
	    
	    try {
	        conn = Conexao.createConnectionToMySQL();
	        mysql = conn.prepareStatement(sql);
	        mysql.setInt(1, ((Endereco) entidade).getId());
	        mysql.execute();
	        
	        System.out.println("Endereco excluído com sucesso");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Erro ao excluir o endereco: " + e.getMessage();
	    } finally {
	        try {
	            if (mysql != null) {
	                mysql.close();
	            }
	            if (conn != null) {
	                conn.close();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return null;
	}

	@Override
	public EntidadeDominio selecionar(EntidadeDominio entidade) {
		Endereco endereco = null;
		String sql = "SELECT * FROM endereco WHERE id=?";
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			mysql.setInt(1,((Endereco) entidade).getId());
			ResultSet rs = mysql.executeQuery();
			
			while (rs.next()) {
				endereco = new Endereco();				
				endereco.setId(rs.getInt(1));
				endereco.setCep(rs.getString(2));
				endereco.setLogradouro(rs.getString(3));
				endereco.setNumero(1);	
				endereco.setBairro(rs.getString(5));
				endereco.setIdCliente(Integer.parseInt(rs.getString(6)));						
			}
		}catch(Exception e) {
			System.out.println(e);			
		}
		System.out.println(endereco);
		return endereco;
	}

}
