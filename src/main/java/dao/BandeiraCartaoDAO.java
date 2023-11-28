package dao;

import util.Conexao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.BandeiraCartao;

public class BandeiraCartaoDAO{
	public List<BandeiraCartao> consultar() {
		List<BandeiraCartao> listaBandeiras= new ArrayList<>();
		String sql = "SELECT id_band,descricao_band FROM bandeiras_cartao";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {					
					int id = rs.getInt(1);
					String descricao = rs.getString(2);					
					BandeiraCartao tipo = BandeiraCartao.valueOf(descricao.toUpperCase());					
					tipo.setId(id);
					tipo.setDescricao(descricao);
					listaBandeiras.add(tipo);		
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}
		
		return listaBandeiras;
	}
}
