package dao;

import java.sql.Connection;
import util.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;
import dominio.Pais;



public class PaisDAO {
	public List<Pais> consultar() {
		List<Pais> paises = new ArrayList<>();
		String sql = "SELECT id_pais,nome_pais FROM paises";
		
		try {
			Connection conn = Conexao.createConnectionToMySQL();
			PreparedStatement mysql = conn.prepareStatement(sql);
			ResultSet rs = mysql.executeQuery();			
				while (rs.next()) {		
					Pais pais = new Pais();
					pais.setId(rs.getInt(1));
					pais.setNome(rs.getString(2));						
									
					paises.add(pais);	
				}
			conn.close();
			
		}catch(Exception e) {
			System.out.println();
		}		
		return paises;
	}	

}
