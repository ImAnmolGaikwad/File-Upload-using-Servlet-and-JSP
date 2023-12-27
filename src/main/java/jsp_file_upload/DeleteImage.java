package jsp_file_upload;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class DeleteImage extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 int id=Integer.parseInt(req.getParameter("id"));
		 
		 String connectionURL = "jdbc:mysql://localhost:3306/jsp_image";
			String user = "root";
			String pass = "root";
			 
			int result = 0;
			Connection con = null;
			
			
			try{
			Class.forName("com.mysql.jdbc.Driver");
			    con = DriverManager.getConnection(connectionURL, user, pass);
			    
			    PreparedStatement ps = con.prepareStatement("delete from images where id=?");
			    ps.setInt(1, id);
			    
			   
			    result = ps.executeUpdate();
			}
			catch(Exception e){
			e.printStackTrace();
			}
			finally{
			if(con != null){
			try{
			con.close();
}
			catch(Exception e){
				e.printStackTrace();
				}
				}
				}
				
				if(result > 0){
				     resp.sendRedirect("index.jsp");
				    }
				else{
				resp.sendRedirect("index.jsp?message=Some+Error+Occurred");
				}

	}
}
