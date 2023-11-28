package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
		
	public static Connection createConnectionToMySQL() throws Exception{
		Connection conexao = null;
		try {
			//carrega o driver do bdd
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			//para instanciar um objeto connection preciso utilizar o driver manager
			conexao = DriverManager.getConnection("jdbc:mysql://localhost:3306/projcrudcliente","root","root"); 
		}catch(ClassNotFoundException e) {
			System.out.println("Driver do banco de dados não localizado.");
		} catch (SQLException e) {
			System.out.println("Ocorreu um erro ao acessar o banco." + e.getMessage());
		} 
		return conexao;
	}
	
		public static void encerrarConexao(Connection con) throws Exception {
			
			//recuperar uma conexao com o banco de dados
			Connection conn = createConnectionToMySQL();
			
			// se existe uma conexao aberta, ela é encerrada
			if(conn!=null) {
				System.out.println("Conexao obtida com sucesso!");
				conn.close();
			}
		}
		
}

