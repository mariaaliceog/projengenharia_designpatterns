package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.*;

public class CidadeDAO {	
	public List<Cidade> consultar() {
		List<Cidade> listaCidades = new ArrayList<>();
		String sql = "SELECT id_cidade,nome_cidade FROM cidades";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {		
					Cidade cidade = new Cidade();				
					
					cidade.setId(rs.getInt(1));
					cidade.setNome(rs.getString(2));						
					
					listaCidades.add(cidade);	
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}		
		return listaCidades;
	}
	public List<Cidade> obterCidadesPorEstado(String idEstado) {
        List<Cidade> cidades = new ArrayList<>();
        String sql = "SELECT id_cidade, nome_cidade FROM cidades WHERE id_estados = ?";
        
        try {
            Connection conn = Conexao.createConnectionToMySQL();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idEstado);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cidade cidade = new Cidade();
                cidade.setId(rs.getInt("id_cidade"));
                cidade.setNome(rs.getString("nome_cidade"));
                
                cidades.add(cidade);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace(); // Trate adequadamente em um ambiente de produção
        }

        return cidades;
    }
}
