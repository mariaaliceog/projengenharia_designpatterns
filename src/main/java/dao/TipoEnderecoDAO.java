package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dominio.TipoEndereco;
import util.Conexao;

public class TipoEnderecoDAO{

	public List<TipoEndereco> consultar() {
		List<TipoEndereco> listaTipos = new ArrayList<>();
		String sql = "SELECT id_tip_end,descricao_tip_end FROM tipos_endereco";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {					
					int id = rs.getInt(1);
					String descricao = rs.getString(2);					
					TipoEndereco tipo = TipoEndereco.valueOf(descricao.toUpperCase());					
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
