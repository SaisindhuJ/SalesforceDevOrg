public class AccountBatch implements Database.Batchable<Sobject> {
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        String Query = 'Select id, name, BillingStreet, BillingCity, BillingState, BillingPostalCode, ' + 
                       '(select id,MailingStreet,MailingCity,MailingState,MailingPostalCode from contacts)' + 
                       'from Account';
        return Database.getQueryLocator(Query);
    }
    
    public void execute(Database.BatchableContext BC, List<Account> scope){
        
        List<contact> ToUpdateListContacts = new List<contact>();
        
        for(Account acc : scope) {
            for(contact con : acc.contacts){
                con.MailingStreet = acc.BillingStreet;
                con.MailingCity = acc.BillingCity;
                con.MailingState = acc.BillingState;
                con.MailingPostalCode = acc.BillingPostalCode;
                ToUpdateListContacts.add(con);
            }
        }
        
        if(ToUpdateListContacts.size() > 0 && !ToUpdateListContacts.isEmpty()){
            update ToUpdateListContacts;
        }
        
        
        
    }
    
    public void finish(Database.BatchableContext BC){
        
        
    }

}