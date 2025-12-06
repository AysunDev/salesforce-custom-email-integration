trigger ContactTrigger on CONTACT (after insert) {

    if(Trigger.isInsert && Trigger.isAfter){
      ContactTriggerHandler.checkEmail(trigger.new);
      ContactTriggerHandler.notifyContact(trigger.new);
    
    }  

    if(trigger.isAfter && Trigger.isUpdate){
       ContactTriggerHandler.checkEmail(trigger.new);
    }

    
}
