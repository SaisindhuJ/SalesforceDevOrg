public class AccountTriggerHandler {
    
    Public void onBeforeInsert(List<Account> newValues){
        AccountTriggerHelper.setRating(newValues);
        AccountTriggerHelper.setAnnualRevenue(newValues);
        AccountTriggerHelper.checkDuplicate(newValues);
        
        
    }
    Public void onAfterInsert(List<Account> newValues, Map<Id,Account> newMap){
        
    }
    Public void onBeforeUpdate(List<Account> oldValues , Map<Id,Account> oldMap, List<Account> newValues,  Map<Id,Account> newMap){
        AccountTriggerHelper.preventNameEdit(oldValues,oldMap,newValues,newMap);
        AccountTriggerHelper.setRating(newValues);
        AccountTriggerHelper.setAnnualRevenue(newValues);
        //AccountTriggerHelper.checkDuplicate(newValues);
    }
    Public void onAfterUpdate(List<Account> oldValues , Map<Id,Account> oldMap, List<Account> newValues,  Map<Id,Account> newMap){
        
    }
    Public void onBeforeDelete(List<Account> oldValues, Map<Id,Account> oldMap){
        AccountTriggerHelper.preventContactDeletion(oldMap);
        
    }
    Public void onAfterDelete(List<Account> oldValues){
        
    }
    Public void onAfterUndelete(List<Account> newValues, Map<Id,Account> newMap ){
        
    }

}