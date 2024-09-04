<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Resume</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Syncfusion CSS -->
    <link href="https://cdn.syncfusion.com/ej2/material.css" rel="stylesheet">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .alert {
            margin-top: 20px;
        }
        .text-center {
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-4"></h2>
        <form id="resumeUploadForm" action="${pageContext.request.contextPath}/candidates/upload" method="post" enctype="multipart/form-data">
            <!--<div class="form-group">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>-->
            <!--<div class="form-group">
                <label for="category">Category</label>
                <select class="form-control" id="category" name="category" required>
                    <option value="Resume">Resume</option>
                    <option value="Cover letter>Cover letter</option>
                    <option value="Other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="fileUploader">Choose file</label>
                <input type="file" id="fileUploader" name="file" class="form-control-file" required>
            </div>
            <button type="button" id="uploadButton" class="btn btn-primary btn-block">Upload</button>-->
        </form>
        <c:if test="${not empty message}">
            <div class="alert alert-info" role="alert">
                ${message}
				<a href="${pageContext.request.contextPath}/download" class="btn btn-secondary btn-block">Back to Home</a>
            </div>
        </c:if>
    </div>

    <!-- Bootstrap JS, Popper.js, and jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- Syncfusion Scripts -->
    <script src="https://cdn.syncfusion.com/ej2/dist/ej2.min.js"></script>
    <script>
        // Initialize the Uploader component
        var uploadObj = new ej.inputs.Uploader({
            asyncSettings: {
                saveUrl: '${pageContext.request.contextPath}/candidates/upload', // URL to handle the file upload
            },
            autoUpload: false, // Prevent auto-upload on file selection
            allowedExtensions: '.pdf, .doc, .docx', // Set allowed file types
        });
        uploadObj.appendTo('#fileUploader');

        // Handle the upload button click
        document.getElementById('uploadButton').addEventListener('click', function () {
            if (uploadObj.getFilesData().length > 0) {
                uploadObj.upload(uploadObj.getFilesData()); // Trigger the file upload
            } else {
                alert('Please select a file to upload.');
            }
        });
    </script>
</body>
</html>
