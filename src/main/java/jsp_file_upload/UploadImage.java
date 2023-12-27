package jsp_file_upload;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class UploadImage
 */
@WebServlet("/UploadImage")
@MultipartConfig(maxFileSize = 16177216)
public class UploadImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UploadImage() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String connectionURL = "jdbc:mysql://localhost:3306/jsp_image";
		String user = "root";
		String pass = "root";

		int result = 0;
		Connection con = null;
		String name = request.getParameter("name");
		long phone = Long.parseLong(request.getParameter("phone"));
		Part part = request.getPart("image");

		if (part != null) {
			try {
				Class.forName("com.mysql.jdbc.Driver");
				con = DriverManager.getConnection(connectionURL, user, pass);

				PreparedStatement ps = con.prepareStatement("insert into images(data,name,phone) values(?,?,?)");

				InputStream is = part.getInputStream();

				ps.setBlob(1, is);
				ps.setString(2, name);
				ps.setLong(3, phone);

				result = ps.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}
		if (result > 0) {
			response.sendRedirect("index.jsp");
		} else {
			response.sendRedirect("index.jsp?message=Some+Error+Occurred");
		}
	}
}
