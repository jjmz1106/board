package connector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Connector {
//	private static final String url = "jdbc:mariadb://localhost:3306/java";  //마리아db
	private static final String url = "jdbc:oracle:thin:@localhost:1522/xe"; //오라클
//	private static final String user = "test"; //마리아db
	private static final String user = "c##test"; //오라클
	private static final String password = "test";
	private static Connection conn;
	
	private static void init() {		
		try {
//			Class.forName("org.mariadb.jdbc.Driver");
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
			
	}
	public static Connection getConnection() {
		if(conn==null) {
			init();
			try {
				conn = DriverManager.getConnection(url,user,password);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return conn;
	}
	public static void close(){
		if(conn!=null) {
			try {
				conn.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		conn = null;
	}
	public static void main(String[] args) throws SQLException {
		Connection con = getConnection();
		Statement stmt = con.createStatement();
		String sql = "select * from board";
		ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()) {
			System.out.println("출력");
		}

	}
	
}
