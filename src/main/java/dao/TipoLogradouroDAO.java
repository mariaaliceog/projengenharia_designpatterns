package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.*;


public class TipoLogradouroDAO {
	public List<TipoLogradouro> consultar() {
		List<TipoLogradouro> listaTiposLog = new ArrayList<>();
		String sql = "SELECT id_tip_log,descricao_tip_log FROM tipos_logradouro";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {					
					int id = rs.getInt(1);
					String descricao = rs.getString(2);					
					TipoLogradouro tipo = TipoLogradouro.valueOf(descricao.toUpperCase());					
					tipo.setId(id);
					tipo.setDescricao(descricao);					
					listaTiposLog.add(tipo);	
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}		
		return listaTiposLog;
	}
}
