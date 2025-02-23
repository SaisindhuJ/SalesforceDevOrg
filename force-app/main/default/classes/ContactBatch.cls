public with sharing class ContactBatch implements Database.Batchable<SObject>  {

    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'select LastName, Email from Contact';
        return Database.getQueryLocator(query);

    }
     public void Execute(Database.BatcableContext BC, List<contact>scope){
        List<Contact> toUpdateList = new List<Contact>();
        for(Contact con : scope){
            //process the logc
        }

        if(ToUpdateList.size() > 0){
            update toUpdateList;
        }

     }

     public void finish(Database.BatchableContext BC){

     }
}