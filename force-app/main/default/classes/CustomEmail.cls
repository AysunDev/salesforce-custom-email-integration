public class CustomEmail {
    
    @future (callout=true)
    public static void sendMultipleEmailsWithoutAttachmentFuture(List<String> emailAddresses, String emailSubject, String emailBody){
        sendMultipleEmailsWithoutAttachment(emailAddresses, emailSubject, emailBody);
    }

    public static void sendMultipleEmailsWithoutAttachment(List<String> emailAddresses, String emailSubject, String emailBody){

        CustomEmailRequest emailRequest = new CustomEmailRequest();

        emailRequest.emailAddresses = emailAddresses;
        emailRequest.emailSubject   = emailSubject;
        emailRequest.emailBody      = emailBody;

        List<CustomEmailRequest> requestList = new List<CustomEmailRequest>();
        requestList.add(emailRequest);

        CustomEmail.sendEmailWithAttachment(JSON.serialize(requestList));
    }

    @future (callout=true)
    public static void sendSingleEmailWithoutAttachmentFuture(String emailAddress, String emailSubject, String emailBody){
        sendSingleEmailWithoutAttachment(emailAddress, emailSubject, emailBody);
    }

    public static void sendSingleEmailWithoutAttachment(String emailAddress, String emailSubject, String emailBody){

        CustomEmailRequest emailRequest = new CustomEmailRequest();

        emailRequest.emailAddresses = new List<String>{ emailAddress };
        emailRequest.emailSubject   = emailSubject;
        emailRequest.emailBody      = emailBody;

        List<CustomEmailRequest> requestList = new List<CustomEmailRequest>();
        requestList.add(emailRequest);

        CustomEmail.sendEmailWithAttachment(JSON.serialize(requestList));
    }

    @future (callout=true)
    public static void sendEmailWithAttachmentFuture(String requestBody){
        sendEmailWithAttachment(requestBody);
    }

    public static void sendEmailWithAttachment(String requestBody){

        List<String> successMessages = new List<String>();
        List<String> errorMessages   = new List<String>();

        try {
            CustomEmail_Config__mdt CustomEmailConfig = CustomEmailUtility.getCustomEmailConfig();

            HTTPRequest req = new HTTPRequest();
            req.setEndPoint(CustomEmailConfig.EndPoint__c + '?token=' + CustomEmailConfig.Token__c);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
            req.setBody(requestBody);

            HTTP http = new HTTP();
            HTTPResponse res = http.send(req);

            if (res.getStatusCode() == 200) {
                successMessages.add('SUCCESS STATUS Code'  + res.getStatusCode());
                successMessages.add('SUCCESS Response BODY' + res.getBody());
            }

        } catch (Exception e) {
            errorMessages.add('Exception Message (ERROR) ' + e.getMessage());
        }

        ProcessLogsHelper.successLog('Success at CustomEmail', successMessages);
        ProcessLogsHelper.errorLog('Error at CustomEmail', errorMessages);
    }
}
