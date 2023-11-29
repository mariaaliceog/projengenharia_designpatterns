package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dominio.TipoTelefone;
import util.Conexao;

public class TipoTelefoneDAO {
	public List<TipoTelefone> consultar() {
		List<TipoTelefone> listaTiposTel = new ArrayList<>();
		String sql = "SELECT id_tip_tel,nome_tip_tel FROM tipos_telefone";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {					
					int id = rs.getInt(1);
					String nome = rs.getString(2);					
					TipoTelefone tipo = TipoTelefone.valueOf(nome.toUpperCase());					
					tipo.setId(id);
					tipo.setNome(nome);					
					listaTiposTel.add(tipo);	
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}		
		return listaTiposTel;
	}
}
