File Upload and Download System
Overview
This project demonstrates a simple file upload and download system using Spring Boot, AWS S3, JSP, and Bootstrap. Users can upload files to an AWS S3 bucket and download them via a web interface.

Technologies Used
Spring Boot: Framework for building the backend REST API.
AWS S3: Cloud storage service for storing and retrieving files.
JSP: Java Server Pages for rendering the web pages.
Bootstrap: Front-end framework for styling the web pages.
Java: Programming language used to develop the application.
Features
Upload Resumes: Users can upload resume files to the AWS S3 bucket.
Download Resumes: Users can view a list of uploaded resumes and download them.
Project Structure
src/main/java/com/example/crm/controller/CandidateController.java: Controller handling file upload and download operations.
src/main/resources/templates/upload.jsp: JSP page for uploading files.
src/main/resources/templates/download.jsp: JSP page for listing and downloading files.
src/main/resources/application.properties: Configuration file for AWS credentials and S3 bucket details.
