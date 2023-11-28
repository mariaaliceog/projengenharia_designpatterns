package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dominio.BandeiraCartao;
import dominio.Cartao;
import dominio.EntidadeDominio;


public class CartaoDAO implements IDAO{
	public String salvar(EntidadeDominio entidade) {
		
		String sql = "INSERT INTO cartao(numero,nomeTitular,codSeguranca,preferencial,cliente_id,bandeiraCartao_id) VALUES (?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			// criar uma conexao com o banco de dados
			conn = Conexao.createConnectionToMySQL();
			
			// foi criada uma prepareStatement para executar uma Query
			mysql = conn.prepareStatement(sql);
			
			// adicionar os valores que sao esperados pela query
			String numeroMascarado = mascaraNumeroCartao(((Cartao) entidade).getNumero());			
			mysql.setString(1,numeroMascarado);			
			mysql.setString(2,((Cartao) entidade).getNomeTitular());
			
			String codSegurancaMascarado = mascaraCodSeguranca(((Cartao) entidade).getCodSeguranca());
			mysql.setString(3,codSegurancaMascarado);	
			
			mysql.setBoolean(4,((Cartao)entidade).isPreferencial());
			mysql.setInt(5,((Cartao) entidade).getIdCliente());		
			mysql.setInt(6,((Cartao) entidade).getBandeira().getId());			
//			
						
			//	executar a query
			mysql.execute();
			
			System.out.println("Cartão salvo com sucesso");
			return "Cartão salvo com sucesso";
			
		}catch(Exception e){
			e.printStackTrace();
			return "Erro ao salvar o endereco: " + e.getMessage();
		}finally {
			if(conn!=null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			if(mysql!=null) {
				try {
					mysql.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}		
	}

	public int alterar(EntidadeDominio entidade) {
		int status=0;
		String sql = "UPDATE cartao SET numero=?,"
	            + "nomeTitular=?, codSeguranca=?, preferencial=?, bandeiraCartao_id=? WHERE id=?";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			conn = Conexao.createConnectionToMySQL();
			mysql = conn.prepareStatement(sql);		
			
			mysql.setString(1,((Cartao) entidade).getNumero());
			mysql.setString(2,((Cartao) entidade).getNomeTitular());		
			mysql.setString(3,((Cartao) entidade).getCodSeguranca());		
			mysql.setBoolean(4,((Cartao) entidade).isPreferencial());
			mysql.setString(5,((Cartao) entidade).getBandeira().getDescricao());			
			mysql.setInt(6,((Cartao) entidade).getId());	//id que vai ser atualizado
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
		List<EntidadeDominio> listaCartoes = new ArrayList<>();
		String sql = "SELECT id,numero,nomeTitular,codSeguranca, preferencial, descricao_band " +
		          "FROM cartao as c " +
		          "INNER JOIN bandeiras_cartao as b ON c.bandeiraCartao_id = b.id_band";	    
		try {
	        Connection conn = Conexao.createConnectionToMySQL();
	        PreparedStatement mysql = conn.prepareStatement(sql);
	        ResultSet rs = mysql.executeQuery();
		        while (rs.next()) {
		            Cartao cartao = new Cartao();
		            
		            cartao.setId(rs.getInt(1));
		            cartao.setNumero(rs.getString(2));	            
		            cartao.setNomeTitular(rs.getString(3));
		            cartao.setCodSeguranca(rs.getString(4));
		            cartao.setPreferencial(rs.getBoolean(5));
		            cartao.setBandeira(BandeiraCartao.valueOf(rs.getString(6)));		            
		            listaCartoes.add(cartao);
	        }
	        conn.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return listaCartoes;
	}


	public String excluir(EntidadeDominio entidade) {
		String sql = "DELETE from cartao WHERE id = ?";
	    Connection conn = null;
	    PreparedStatement mysql = null;
	    
	    try {
	        conn = Conexao.createConnectionToMySQL();
	        mysql = conn.prepareStatement(sql);
	        mysql.setInt(1, ((Cartao) entidade).getId());
	        mysql.execute();
	        
	        System.out.println("Cartao excluído com sucesso");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Erro ao excluir o cartao: " + e.getMessage();
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
	public Cartao selecionar(EntidadeDominio entidade) {
		Cartao cartao = null;
		String sql = "SELECT * FROM cartao WHERE id=?";
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			mysql.setInt(1,((Cartao) entidade).getId());
			ResultSet rs = mysql.executeQuery();
			
			while (rs.next()) {
				cartao = new Cartao();
				cartao.setId(rs.getInt(1));
				cartao.setNumero(rs.getString(2));
				cartao.setNomeTitular(rs.getString(3));
				cartao.setCodSeguranca(rs.getString(4));	
				cartao.setPreferencial(rs.getBoolean(5));				
			}
		}catch(Exception e) {
			System.out.println(e);			
		}
		
		return cartao;
	}
	
	private String mascaraNumeroCartao(String numeroCartao) {
	    // Mascarar o número do cartão para exibir apenas os últimos 4 dígitos
	    int tamanho = numeroCartao.length();
	    System.out.println(tamanho);
	    String ultimosQuatroDigitos = numeroCartao.substring(tamanho - 4, tamanho);
	    String mascara = "*".repeat(Math.max(0, tamanho - 4)) + ultimosQuatroDigitos;
	    return mascara;
	}
	
	private String mascaraCodSeguranca(String codSeguranca) {        
		int tamanho = codSeguranca.length();        
        String mascara = "*".repeat(tamanho);
        return mascara;
    }
}
