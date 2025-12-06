public class CustomEmailRequest {
 
    public List<String> emailAddresses;
    public List<String> ccAddresses;
    public List<String> bccAddresses;
    public String emailSubject;
    public String emailBody;
    public String logoURL;
    public List<AttachmentFile> attachments;

    // Inner class for attachments
    public class AttachmentFile {
        public String fileName;
        public String content; // Base64 encoded content
    }
}

