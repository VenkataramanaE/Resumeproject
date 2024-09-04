package com.example.crm.service;

import org.apache.tika.Tika;
import org.apache.tika.exception.TikaException;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;

@Service
public class ResumeParserService {

    private final Tika tika = new Tika();

    public String parseResume(InputStream fileInputStream) throws IOException, TikaException {
        return tika.parseToString(fileInputStream);
    }

    public String extractSpecificData(String parsedContent) {
        // Implement your logic to extract specific data, e.g., name, email, etc.
        // Example: Extract email
        String email = parsedContent.replaceAll(".*?(\\S+@\\S+).*", "$1");
        return email; // Placeholder example for extracting email
    }
    
}
