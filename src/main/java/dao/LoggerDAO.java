package dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import util.Conexao;


public class LoggerDAO {
//    public static void log(EntidadeDominio entidade) throws Exception {
//    	Class<?> clazz = entidade.getClass();
//        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//        String formattedDate = dateFormat.format(new Date());
//
//        saveLogToDatabase(formattedDate,logMessage);
//    }
    public void saveLogToDatabase(String formattedDate, String entidade){
        // Lógica para salvar a mensagem de log no banco de dados
        Connection conn = null;
        PreparedStatement statement = null;

        try {
            try {
				conn = Conexao.createConnectionToMySQL();
			} catch (Exception e) {
				e.printStackTrace();
			}
            System.out.println(formattedDate + entidade);
            String sql = "INSERT INTO logs (entidade,user,data) VALUES (?,?,?)";
            statement = conn.prepareStatement(sql);            
            statement.setString(1, entidade);
            statement.setString(2, "admin");
            statement.setString(3, formattedDate);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // ou você pode logar isso em outro lugar, se necessário
        } finally {
            // Feche as conexões
            try {
                if (statement != null) {
                    statement.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

