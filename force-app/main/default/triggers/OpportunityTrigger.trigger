trigger OpportunityTrigger on Opportunity (before insert, before update,before delete,after insert,after update,after delete,after undelete) {
    //getting the profile info
    Profile p = [select id from profile where name = 'System Administrator'];
    if(Trigger.isBefore && Trigger.isDelete) {
        for(Opportunity opp : Trigger.old) {
            if(opp.stageName == 'Closed Won' || opp.stageName == 'Closed Lost')  {
                if (userInfo.getProfileId() != P.id) {
                    opp.addError('Only system administrators can delete closed opportunities');  
                }  
            }           
        }
    }
    
    if(Trigger.isBefore && Trigger.isInsert) {
        set<Id> accids = new set<Id>();
        for(Opportunity opp : Trigger.new ) {
            accids.add(opp.accountId);
            if(opp.Amount == Null) {
                opp.AddError('Opportunity Amount Should not be null');
            }
        }
        
        Map<Id,Account> accMap = new Map<Id,Account>([select id,ownerId from account where id in:accids]);
        for(Opportunity opp: Trigger.new){
            opp.ownerId = accMap.get(opp.accountId).ownerId;
        }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        List<task> tlist = new List<task>();
        for(Opportunity opp : Trigger.new) {
            if(opp.StageName != Trigger.oldMap.get(opp.id).stageName) {
                Task t = new Task();
                t.Subject = 'TestTask';
                t.Status = 'Not Started';
                t.Priority = 'Normal';
                t.WhoId = userInfo.getUserId();
                t.WhatId = opp.Id;
                tlist.add(t);
            }
        }
        if(tlist.size() >0 && !tlist.isEmpty()) {
            insert tlist;
        }
    }
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        for (Opportunity opp: Trigger.new) {
            if( opp.stageName == 'Closed Lost' && opp.StageName != Trigger.oldMap.get(opp.id).StageName && (opp.Description == '' || opp.Description == Null)) {
                opp.addError('Please specify the lost reason');
                
            }
        }
    }
    
    //Rollup field logic to count number of opportunities per account
    OpportunityTriggerHandler handler = new OpportunityTriggerHandler();
    if(Trigger.isAfter) {
        List<Id> accIds = new List<Id>();
        if(Trigger.isInsert){
            for(Opportunity opp : Trigger.new) {
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            }
            
        }
        
        if(Trigger.isUpdate) {
            for(opportunity opp: Trigger.new){
                if(opp.AccountId != Trigger.oldMap.get(opp.id).AccountId && opp.AccountId != null){
                    accIds.add(opp.AccountId);
                    accIds.add(Trigger.oldMap.get(opp.id).AccountId);
                }
            }
        }
        
        if(Trigger.isDelete){
            for(opportunity opp: Trigger.old){
                if(opp.AccountId != null) {
                  accIds.add(opp.AccountId);  
                }
            }
        }
        
        if(Trigger.isUndelete){
            for(opportunity opp: Trigger.new){
                if(opp.AccountId != null){
                    accIds.add(opp.AccountId);
                }
            }
        }
        if(accIds.size() >0){
           handler.checkOpps(accIds); 
        }
        
            
    }
    
}