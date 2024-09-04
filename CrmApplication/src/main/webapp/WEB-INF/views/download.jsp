<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resumes</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Syncfusion CSS -->
    <link href="https://cdn.syncfusion.com/ej2/material.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
        }
        .modal-content {
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="text-right mb-3">
            <button id="openUploadModal" class="btn btn-primary" data-toggle="modal" data-target="#uploadModal">Upload New Resume</button>
        </div>
        <h2 class="text-center mb-4">Download Resumes</h2>
        <div class="form-group">
            <label for="categoryFilter">Filter by Category:</label>
            <input type="text" id="categoryFilter" />
        </div>
        <table id="resumeTable" class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Resume Name</th>
                    <th>Category</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="resume" items="${resumes}">
                    <tr>
                        <td>${resume.fileName}</td>
                        <td>${resume.category}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/candidates/download/${resume.fileName}" class="btn btn-primary">Download</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- The Modal -->
    <div id="uploadModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Upload Resume</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="modal-body"></div>
                    <form id="resumeUploadForm" action="${pageContext.request.contextPath}/candidates/upload" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select class="form-control" id="category" name="category" required>
                                <option value="Resume">Resume</option>
                                <option value="Cover letter">Cover letter</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="fileUploader">Choose file</label>
                            <input type="file" id="fileUploader" name="file" class="form-control-file" required>
                        </div>
                        <button type="submit" class="btn btn-primary btn-block" id="modalUploadButton">Upload</button>
                    </form>
                </div>
            </div>
        </div>
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
				                saveUrl: '${pageContext.request.contextPath}/candidates/upload',
				                removeUrl: '${pageContext.request.contextPath}/candidates/remove'
				            },
				            autoUpload: false,
				            allowedExtensions: '.pdf, .doc, .docx',
				            upload: function (args) {
				                var formData = new FormData();
				                formData.append('file', args.file);
				                formData.append('category', document.getElementById('category').value);
				                args.customFormData = formData;
								
				            }
				        });
				        uploadObj.appendTo('#fileUploader');

				        // Initialize the DropDownList component for category filtering
				        var categoryFilter = new ej.dropdowns.DropDownList({
				            dataSource: [
				                { id: 'All', text: 'All' },
				                { id: 'Resume', text: 'Resume' },
				                { id: 'Cover letter', text: 'Cover letter' },
				                { id: 'Other', text: 'Other' }
				            ],
				            fields: { text: 'text', value: 'id' },
				            value: 'All',
				            change: function (args) {
				                filterResumes(args.value);
				            }
				        });
				        categoryFilter.appendTo('#categoryFilter');

				        // Function to filter resumes by category
				        function filterResumes(category) {
				            var tableBody = document.getElementById('resumeTable').getElementsByTagName('tbody')[0];
				            var rows = tableBody.getElementsByTagName('tr');
				            for (var i = 0; i < rows.length; i++) {
				                var row = rows[i];
				                var categoryCell = row.getElementsByTagName('td')[1];
				                if (category === 'All' || categoryCell.textContent === category) {
				                    row.style.display = '';
				                } else {
				                    row.style.display = 'none';
				                }
				            }
				        }
						
						
				    </script>
					<script>
					    // Initialize the Uploader component
					    var uploadObj = new ej.inputs.Uploader({
					        asyncSettings: {
					            saveUrl: '',  // This is not used since we are handling the upload manually via AJAX
					            removeUrl: ''
					        },
					        autoUpload: false,
					        allowedExtensions: '.pdf, .doc, .docx',
					    });
					    //uploadObj.appendTo('#fileUploader');

					    //document.getElementById('modalUploadButton').addEventListener('click', function () {
					        var formData = new FormData();
					        var filesData = uploadObj.getFilesData();
					        if (filesData.length > 0) {
					            // Append the file to FormData
					            formData.append('file', filesData[0].rawFile);
					            formData.append('category', document.getElementById('category').value);

					            // Send the form data via AJAX
					            $.ajax({
					                url: '${pageContext.request.contextPath}/candidates/upload',
					                type: 'POST',
					                data: formData,
					                processData: false, // Prevent jQuery from converting the data
					                contentType: false, // Tell jQuery not to set content type
					                success: function(response) {
					                    alert(response.message);
					                    $('#uploadModal').modal('hide');
					                    location.reload();
					                },
					                error: function(xhr, status, error) {
					                    alert("Error uploading file: " + xhr.responseText);
					                }
					            });
					        } else {
					            alert('Please select a file to upload.');
					        }
					    });
					</script>

				</body>
				</html>