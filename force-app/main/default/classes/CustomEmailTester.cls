public class CustomEmailTester {
   public static void testCustomEmail(){

    CustomEmailRequest emailRequest = new CustomEmailRequest();

    emailRequest.emailAddresses = new List<String>{'enginhoca1983@gmail.com'};
    emailRequest.ccAddresses = new List<String>{'aysundoslu324@gmail.com'};
    emailRequest.bccAddresses = new List<String>{'hacer83838@gmail.com'};
    emailRequest.emailSubject ='Email from CUSTOM Email 4';
    emailRequest.emailBody ='Deneme Email Body 2';
    emailRequest.logoURL ='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjsSCwYmyfPv3XdKNdEFVJ1wLDKM0gcSWUcg&s';

    CustomEmailRequest.AttachmentFile file1 = new CustomEmailRequest.AttachmentFile();
    file1.fileName ='TEST Report PDF';
    file1.content =EncodingUtil.base64encode(Blob.valueof('Report Test Body'));

    List<CustomEmailRequest.AttachmentFile> attachments = new List<CustomEmailRequest.AttachmentFile>();
    attachments.add(file1);

    emailRequest.attachments = attachments;


    List<CustomEmailRequest> requestList = new List<CustomEmailRequest>();
    requestList.add(emailRequest);
   

    CustomEmail.sendEmailWithAttachment(JSON.serialize(requestList));
}

}