package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.*;

public class EstadoDAO {
	public List<Estado> consultar() {
		List<Estado> estados = new ArrayList<>();
		String sql = "SELECT id_estado,nome_estado,id_paises FROM estados";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {		
					Estado estado = new Estado();
					Pais pais = new Pais();
					estado.setId(rs.getInt(1));
					estado.setNome(rs.getString(2));
					pais.setId(rs.getInt(3));
					estado.setPais(pais);				
					estados.add(estado);	
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}		
		return estados;
	}
	
    public List<Estado> obterEstadosPorPais(String idPais) {
        List<Estado> estados = new ArrayList<>();
        String sql = "SELECT id_estado, nome_estado FROM estados WHERE id_paises = ?";
        
        try {
            Connection conn = Conexao.createConnectionToMySQL();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, idPais);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Estado estado = new Estado();
                estado.setId(rs.getInt("id_estado"));
                estado.setNome(rs.getString("nome_estado"));
                
                estados.add(estado);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace(); // Trate adequadamente em um ambiente de produção
        }

        return estados;
    }
}


