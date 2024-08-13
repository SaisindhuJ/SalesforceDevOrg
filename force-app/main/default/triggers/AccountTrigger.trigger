trigger AccountTrigger on Account (before insert,After insert, before update, after update, before delete, after undelete) {
	AccountTriggerHandler handler = new AccountTriggerHandler(); 
    if( Trigger.isInsert){
        if(Trigger.isBefore){
           handler.onBeforeInsert(Trigger.new); 
        } 
        if(Trigger.isAfter){
           handler.onAfterInsert(Trigger.new,Trigger.newMap);  
        }
    }
    
    if( Trigger.isUpdate){
        if(Trigger.isBefore){
           handler.onBeforeUpdate(Trigger.old,Trigger.oldMap,Trigger.new,Trigger.newMap); 
        } 
        if(Trigger.isAfter){
           handler.onAfterUpdate(Trigger.old,Trigger.oldMap,Trigger.new,Trigger.newMap);  
        }
    }
    
    if(Trigger.isDelete) {
        if(Trigger.isBefore){
            handler.onBeforeDelete(Trigger.old,Trigger.oldMap);
        }
        if(Trigger.isAfter){
           handler.onAfterDelete(Trigger.old); 
        }
        
        }
    
    if(Trigger.isUndelete) {
    handler.onAfterUndelete(Trigger.new,Trigger.newMap);
}
    }