<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>
<title>Upload Image</title>
</head>
<body>
	<%
	String msg = request.getParameter("message");
	%>
	<%
	if (msg != null) {
	%>
	<h2 align="center"><%=msg%></h2>
	<%
	}
	%>
	<div align="center"
		style="margin-top: 30px; margin-left: 700px; width: 200px; align-items: center;">
		<form action="UploadImage" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<input type="text" name="name" class="form-control"
					id="formGroupExampleInput" placeholder="Name" required="required">
			</div>
			<div class="form-group">
				<input type="tel" name="phone" class="form-control"
					id="formGroupExampleInput2" placeholder="Phone" required="required">
			</div>
			<div class="form-group">
				<label for="exampleFormControlFile1">Select Image</label> <input
					type="file" class="form-control-file" name="image" style="margin-bottom: 20px"
				 accept="image/*" id="exampleFormControlFile1" required="required">
					<img id="preview" src="#"  alt="Image Preview" style="max-width: 100px; max-height: 100px;"><br>
				<input type="submit" class="btn btn-primary mb-2" />
			</div>

		</form>
		<script>
        // Function to handle file input change
        function previewImage() {
            var input = document.getElementById('exampleFormControlFile1');
            var preview = document.getElementById('preview');

            var file = input.files[0];

            if (file) {
                var reader = new FileReader();

                // Closure to capture the file information.
                reader.onload = function (e) {
                    preview.src = e.target.result;
                };

                // Read in the image file as a data URL.
                reader.readAsDataURL(file);
            } else {
                // If no file is selected, clear the preview.
                preview.src = '#';
            }
        }

        // Attach the previewImage function to the change event of the file input.
        document.getElementById('exampleFormControlFile1').addEventListener('change', previewImage);
    </script>
	</div>
	<%
	String connectionURL = "jdbc:mysql://localhost:3306/jsp_image";
	String user = "root";
	String pass = "root";

	Connection con = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(connectionURL, user, pass);

		PreparedStatement ps = con.prepareStatement("select * from images");

		ResultSet rs = ps.executeQuery();
	%>
	<div style="margin: 30px">
		<table class="table">
			<thead class="thead-dark">
				<tr align="center">
					<th scope="col">#</th>
					<th scope="col">Name</th>
					<th scope="col">Phone</th>
					<th scope="col">Image</th>
					<th scope="col">Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				int ct = 1;
				while (rs.next()) {
					int id=rs.getInt("id");
				%>


				<tr align="center">
					<th scope="row"><%=ct++%></th>
					<td><%=rs.getString("name")%></td>
					<td><%=rs.getLong("phone")%></td>
					<td style="width: auto; height: auto"><img
						src="getImage.jsp?id=<%=id%>" width="auto"
						height="100px" /></td>
					<td><a href="delete?id=<%=id%>" class="btn btn-danger">Delete</a></td>
				</tr>

				<%
				}
				%>
				<%
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
				%>
			</tbody>
		</table>
	</div>
</body>
</html>