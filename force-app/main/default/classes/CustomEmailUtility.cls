public class CustomEmailUtility {

    public static CustomEmail_Config__mdt getCustomEmailConfig(){

        CustomEmail_Config__mdt config = [SELECT EndPoint__c, Token__c, Logo__c FROM CustomEmail_Config__mdt WHERE DeveloperName = 'Default' LIMIT 1];
         system.debug(config);
        return config;

    }
}
