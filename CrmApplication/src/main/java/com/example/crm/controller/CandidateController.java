package com.example.crm.controller;

import com.example.crm.model.Resume;
import com.example.crm.service.ResumeParserService;
import com.example.crm.service.S3Service;
import org.apache.tika.exception.TikaException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Controller
public class CandidateController {

    @Autowired
    private S3Service s3Service;

    @Autowired
    private ResumeParserService resumeParserService;

    @GetMapping("/upload")
    public String showUploadForm() {
        return "upload";
    }

    @PostMapping("/candidates/upload")
    public String uploadResume(@RequestParam("file") MultipartFile file, @RequestParam("category") String category, Model model) {
        try {
            if (file.isEmpty()) {
                model.addAttribute("message", "No file selected");
                return "upload";
            }
            
            // Upload file to S3
            String fileName = s3Service.uploadFile(file, category);
            
            // Process the category and file
            model.addAttribute("message", "File uploaded successfully. Category: " + category);
        } catch (IOException e) {
            model.addAttribute("message", "Failed to upload file due to an I/O error: " + e.getMessage());
        } catch (Exception e) {
            model.addAttribute("message", "Failed to upload file: " + e.getMessage());
        }
        return "upload";
    }




    @GetMapping("/download")
    public String showDownloadPage(Model model) {
        // List all files with their categories
        List<Resume> resumes = s3Service.listFiles();
        model.addAttribute("resumes", resumes);
        return "download";
    }

    @GetMapping("/candidates/download/{key}")
    public ResponseEntity<InputStreamResource> downloadFile(@PathVariable String key) {
        InputStream inputStream = s3Service.downloadFile(key);
        if (inputStream == null) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
        InputStreamResource resource = new InputStreamResource(inputStream);
        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + key)
                .body(resource);
    }
}
