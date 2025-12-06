public  class ContactTriggerHandler {
    public static void checkEmail(List<Contact> conList) {
      List<Contact> conList1 = new List<Contact>();
        for (Contact  eachCon : conList) {
          EmailVerificationAPI.verifyEmail(eachCon.id);
          Contact con =[SELECT Id, Email_is_verified__c FROM Contact WHERE Id = :eachCon.id LIMIT 1];
          if(con.Email_is_verified__c == false){
          con.Email_is_verified__c = true;
          conList1.add(con);
         }
    
        if (!conList1.isEmpty()) {
            update conList1;
            System.debug(conList1);   
        }
    }
    
  }

  public static void notifyContact(List<Contact> conList){

        for(Contact con : conList){

                CustomEmail.sendSingleEmailWithoutAttachmentFuture(con.Email, 'New Contact Create',
                'new contact created with the name ' + con.firstname + ' ' + con.LastName);
            }
        }
      }