public class ProcessLogsHelper {
    private static void logInfo(Boolean isError, String logTitle, List<String> logMessages) {
          Process_Log__c log = new Process_Log__c();
                log.Is_Error__c = isError;
                log.Log_Title__c = logTitle;
                log.Log_Message__c = JSON.serialize(logMessages);
                    
              insert log;

    }

    public static void successLog(String logTitle, List<String> logMessages) {
        if (logMessages.size()!= 0) {
           logInfo(false, logTitle, logMessages);  
        }
       
    }
    public static void errorLog(String logTitle, List<String> logMessages) {
         if (logMessages.size()!= 0) {
           logInfo(true, logTitle, logMessages);  
        }
    }
}