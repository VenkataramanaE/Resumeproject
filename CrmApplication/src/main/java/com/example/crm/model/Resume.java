package com.example.crm.model;

public class Resume {
    private String fileName;
    private String category;

    public Resume(String fileName, String category) {
        this.fileName = fileName;
        this.category = category;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
