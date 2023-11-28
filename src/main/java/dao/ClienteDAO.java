package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import dominio.*;


public class ClienteDAO implements IDAO {
	public String salvar(EntidadeDominio entidade) {	
		String clienteId = null;	
		String sql = "INSERT INTO clientes(nome, cpf, email, senha, genero, dataNascimento, telefone, status_ativo) VALUES (?,?,?,?,?,?,?,?)";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			// criar uma conexao com o banco de dados
			conn = Conexao.createConnectionToMySQL();
			
			// foi criada uma prepareStatement para executar uma Query
			mysql = conn.prepareStatement(sql);
			
			// adicionar os valores que sao esperados pela query			
			mysql.setString(1,((Cliente) entidade).getNome());
			mysql.setString(2,((Cliente) entidade).getCpf());
			mysql.setString(3,((Cliente) entidade).getEmail());
			mysql.setString(4,((Cliente) entidade).getSenha());
			mysql.setString(5,((Cliente) entidade).getGenero().getDescricao());				
			mysql.setString(6,((Cliente) entidade).getDataNascimento());
			mysql.setString(7,((Cliente) entidade).getTelefone().getNumero());
			mysql.setBoolean(8, true); // status ativo por padrao
			
			/*
			 * EnderecoDAO enderecoDAO = new EnderecoDAO(); ((Cliente)
			 * entidade).getEnderecoResidencial().setIdCliente(((Cliente)
			 * entidade).getId()); String mensagemResidencial =
			 * enderecoDAO.salvar(((Cliente) entidade).getEnderecoResidencial());
			 * System.out.println(mensagemResidencial);
			 * 
			 * // Salvar endereço de entrega (apenas o primeiro da lista) if (!((Cliente)
			 * entidade).getEnderecoEntrega().isEmpty()) { ((Cliente)
			 * entidade).getEnderecoEntrega().get(0).setIdCliente(((Cliente)
			 * entidade).getId()); String mensagemEntrega = enderecoDAO.salvar(((Cliente)
			 * entidade).getEnderecoEntrega().get(0)); System.out.println(mensagemEntrega);
			 * }
			 * 
			 * // Salvar endereço de cobrança (apenas o primeiro da lista) if (!((Cliente)
			 * entidade).getEnderecoCobranca().isEmpty()) { ((Cliente)
			 * entidade).getEnderecoCobranca().get(0).setIdCliente(((Cliente)
			 * entidade).getId()); String mensagemCobranca = enderecoDAO.salvar(((Cliente)
			 * entidade).getEnderecoCobranca().get(0));
			 * System.out.println(mensagemCobranca); }
			 */
		    	    
			
			/*
			 * if (((Cliente) entidade).getTelefone() != null) { mysql.setString(7,
			 * ((Cliente) entidade).getTelefone().getNumero()); }
			 * 
			 * 
			 * 
			 * Telefone telefone = (((Cliente) entidade).getTelefone()); if (telefone !=
			 * null) { TelefoneDAO telefoneDAO = new TelefoneDAO();
			 * telefoneDAO.salvar(telefone); }
			 */
	        
			//	executar a query
			mysql.execute();

			String req = "SELECT * from clientes where cpf = ?";
			mysql = conn.prepareStatement(req);
			mysql.setString(1,((Cliente) entidade).getCpf());
			
			ResultSet rs =  mysql.executeQuery();

		while (rs.next()) {
			clienteId = rs.getString(1);
		}
			
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
		return clienteId;
	}

	public int alterar(EntidadeDominio entidade) {
		int status=0;
		String sql = "UPDATE clientes SET nome=?,"
	            + "cpf=?, email=?, genero=?, dataNascimento=?, status_ativo=? WHERE id=?";
		Connection conn = null;
		PreparedStatement mysql = null;
		
		try {
			conn = Conexao.createConnectionToMySQL();
			mysql = conn.prepareStatement(sql);				
		
			mysql.setString(1,((Cliente) entidade).getNome());
			mysql.setString(2,((Cliente) entidade).getCpf());
			mysql.setString(3,((Cliente) entidade).getEmail());	
			mysql.setString(4,((Cliente) entidade).getGenero().getDescricao());
			mysql.setString(5,((Cliente) entidade).getDataNascimento());
			mysql.setBoolean(6,((Cliente) entidade).getStatus());
			//mysql.setString(6,((Cliente) entidade).getTelefone().getTipo().getNome());			
		    //mysql.setString(7,((Cliente) entidade).getTelefone().getDdd() + ((Cliente) entidade).getTelefone().getNumero());			
			mysql.setInt(7,((Cliente) entidade).getId());	//id que vai ser atualizado
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


	public String excluir(EntidadeDominio entidade) {
	    String sql = "DELETE from clientes WHERE id = ?";
	    Connection conn = null;
	    PreparedStatement mysql = null;
	    
	    try {
	        conn = Conexao.createConnectionToMySQL();
	        mysql = conn.prepareStatement(sql);
	        mysql.setInt(1, ((Cliente) entidade).getId());
	        mysql.execute();
	        System.out.println("Cliente excluído com sucesso");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "Erro ao excluir o cliente: " + e.getMessage();
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

	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {		
		List<EntidadeDominio> listaClientes = new ArrayList<>();
		String sql = "SELECT id, nome, cpf, email, genero, dataNascimento, telefone, status_ativo FROM clientes";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {
					Cliente cliente = new Cliente();	
					Telefone telefone = new Telefone();
					
					cliente.setId(rs.getInt(1));
					cliente.setNome(rs.getString(2));
					cliente.setCpf(rs.getString(3));
					cliente.setEmail(rs.getString(4));
					cliente.setGenero(Genero.valueOf(rs.getString(5)));
					cliente.setDataNascimento(rs.getString(6));					
				    telefone.setNumero(rs.getString(7));
				    cliente.setTelefone(telefone);
				    
					cliente.setStatus(rs.getBoolean(8));
					
//					List<EntidadeDominio> entidades = consultarCartoesPorCliente(((Cliente)entidade).getId());
//					List<Cartao> cartoes = new ArrayList<>();
//
//					for (EntidadeDominio ent : entidades) {
//					    if (ent instanceof Cartao) {
//					        cartoes.add((Cartao) ent);
//					    }
//					}
//					cliente.setCartao(cartoes);
		            
				    listaClientes.add(cliente);			
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}
		return listaClientes;
	}
	
	public Cliente selecionar(EntidadeDominio entidade) {
		Cliente cliente = null;
		String sql = "SELECT * FROM clientes WHERE id=?";
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			mysql.setInt(1,((Cliente) entidade).getId());
			ResultSet rs = mysql.executeQuery();
			
			while (rs.next()) {
				cliente = new Cliente();
				cliente.setId(rs.getInt(1));
				cliente.setNome(rs.getString(2));
				cliente.setCpf(rs.getString(3));
				cliente.setEmail(rs.getString(4));	
				cliente.setSenha(rs.getString(5));	
				cliente.setGenero(Genero.valueOf(rs.getString(6)));
				cliente.setDataNascimento(rs.getString(7));									    
				cliente.setStatus(rs.getBoolean(8));
			}
		}catch(Exception e) {
			System.out.println(e);			
		}
		
		return cliente;
	}
	
	public int alterarSenha(int id, String novaSenha) throws Exception {
		int status = 0;
        String sql = "UPDATE clientes SET senha = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement preparedStatement = null;

        try {
            conn = Conexao.createConnectionToMySQL();
            preparedStatement = conn.prepareStatement(sql);

            // Configurar os parâmetros da consulta           
            preparedStatement.setString(1, novaSenha);
            preparedStatement.setInt(2,id);

            // Executar a atualização da senha
            status = preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Fechar as conexões e recursos
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return status;    
	}	
	
//	private List<EntidadeDominio> consultarCartoesPorCliente(EntidadeDominio entidade) {
//	    List<EntidadeDominio> listaCartoes = new ArrayList<>();
//	    String sql = "SELECT * FROM cartao WHERE cliente_id = ?";
//
//	    try {
//	        Connection conn = Conexao.createConnectionToMySQL();
//	        PreparedStatement mysql = conn.prepareStatement(sql);
//	        mysql.setInt(1, ((Cliente)entidade).getId());
//	        ResultSet rs = mysql.executeQuery();
//	        while (rs.next()) {
//	            Cartao cartao = new Cartao();
//	            cartao.setId(rs.getInt(1));
//	            cartao.setNumero(rs.getString(2));
//	            cartao.setNomeTitular(rs.getString(3));
//	            cartao.setCodSeguranca(rs.getString(4));
//	            cartao.setPreferencial(rs.getBoolean(5));
//	            cartao.setBandeira(BandeiraCartao.valueOf(rs.getString(6)));
//	            listaCartoes.add(cartao);
//	        }
//	        conn.close();
//
//	    } catch (Exception e) {
//	        e.printStackTrace();
//	    }
//	    return listaCartoes;
//	}

}
