package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import dominio.*;

public class TipoResidenciaDAO {
	public List<TipoResidencia> consultar() {
		List<TipoResidencia> listaTipos = new ArrayList<>();
		String sql = "SELECT id_tip_res,descricao_tip_res FROM tipos_residencia";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {					
					int id = rs.getInt(1);
					String descricao = rs.getString(2);					
					TipoResidencia tipo = TipoResidencia.valueOf(descricao.toUpperCase());					
					tipo.setId(id);
					tipo.setDescricao(descricao);
	                listaTipos.add(tipo);		
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}
		
		return listaTipos;
	}
}
