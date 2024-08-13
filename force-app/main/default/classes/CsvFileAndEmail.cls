public with sharing class CsvFileAndEmail {
    public void createCsvAndSendEmail(String AccountId){
        List<Opportunity> oppList = new List<opportunity>([select id,Name,StageName from opportunity where accountId =: AccountId]);
        String CSVstring = 'Id,Name,StageName\n';
            for(opportunity opp : oppList){
                CSVstring = CSVstring+opp.Id+','+opp.Name+','+opp.stageName+'\n';
            }  
        
        Messaging.EmailFileAttachment csvFile = new Messaging.EmailFileAttachment();
        csvFile.setfileName('opportunityList');
        csvFile.setBody(Blob.valueOf(CSVstring));
        
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setToAddresses(new List<String>{oppList[0].account.owner.email});
        email.setSubject('Opportunity List');
        email.setFileAttachments(new List<Messaging.EmailFileAttachment> {csvFile});
        email.setPlainTextBody('Please Find the Attachment');
        Messaging.sendEmail(new List<Messaging.singleEmailMessage>{email});
    }

}