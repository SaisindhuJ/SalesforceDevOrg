public class AccountTriggerHelper {
    
    public static void setRating(List<Account> newValues){
        for (Account acc : newValues){
            if (acc.Industry == 'Banking' || acc.Industry == 'HealthCare') {
                acc.Rating = 'Hot';
            } 
        }
    }
    
    public static void preventNameEdit(List<Account> oldValues , Map<Id,Account> oldMap, List<Account> newValues,  Map<Id,Account> newMap) {
        
        for(Account acc : newValues){
            if(acc.name != oldMap.get(acc.id).name) {
                acc.name.addError('user doesn\'t have the permission to edit the name');
            }
        }
        
    }
    
    public static void setAnnualRevenue(List<Account> newValues) {
        
        for(Account acc : newValues ) {
            if(acc.Industry == 'Banking') {
                acc.AnnualRevenue = 1000000;
            } else if(acc.Industry == 'Agriculture') {
                acc.AnnualRevenue = 4000000;
            }
        }
        
    }
    
    public static void checkDuplicate(List<Account> newValues) {
        set<String> accName = new set<String>();
        Map<String,Account> mapWiseAccount = new Map<String,Account>();
        for(Account acc : newValues) {
            accName.add(acc.Name);
        }
        List<Account> accs = [SELECT id,name from Account where Name In:accName];
        for(Account acc : accs) {
            mapWiseAccount.put(acc.Name,acc);
        }
        for(Account acc: newValues){
            if(mapWiseAccount.containsKey(acc.Name)){
                acc.addError('Name already Exists');
            }
        }
        
    }
    
    public static void preventContactDeletion(Map<Id,Account> oldMap){
        system.debug('coming here');
        List<Contact> conTobeUpdated = new List<Contact>();
        List<Account> accs = [Select id,name,(select id,AccountId,lastname from contacts) from account where id in: oldMap.keyset()];
        system.debug(accs.size());
        for(Account acc: accs){
            for(contact con: acc.contacts){
                con.AccountId = null;
                conTobeUpdated.add(con);
            }
        }
        if(conTobeUpdated.size() > 0) {
            update conTobeUpdated;
        }
        
   }
    public static void checkForCaseBeforeDelete(List<Account> OldValues, Map<Id,Account> OldMap){
        
        Map<Id,List<Case>> accWithCases = new Map<Id,List<case>>();
        
        List<Account> accs = [select id,name,(select id from cases) from Account where id in :OldMap.keyset()];
        for(Account acc: accs ) {
            accWithCases.put(acc.id,acc.cases);
        }
        for(Account acc: OldValues){
            if(accWithCases.get(acc.id).size() > 0){
                Account NoDelete = OldMap.get(acc.id);
                NoDelete.addError('Should not delete account when case is active');
            }
        }
        
    } 
    
    public static void checkForAccountCreatedDate(List<Account> oldRecords, Map<Id,Account> oldRecordsMap,List<Account> newRecords, Map<Id,Account> newRecordsMap){
        
        for(Account acc: newRecords) {
            if(acc.CreatedDate == system.Today() - 6) {
                acc.addError('Account created 7 days back can\'t be editied');
            }
        }
        
    }
    
    public void setOppOwnerId(List<Account> oldRecords, Map<Id,Account> oldRecordsMap, List<Account> newRecords, Map<id,Account> newRecordsMap){
        Map<Id,Opportunity> oppMap = new Map<Id,Opportunity>([select AccountId,OwnerId from opportunity where AccountId in :oldRecordsMap.keyset()]);
        for(Account acc : newRecords ) {
            if(acc.ownerId != oldRecordsMap.get(acc.id).ownerId && acc.ownerId != null){
                opportunity opp = new opportunity();
                opp.id = oppMap.get(acc.Id).id;
                opp.OwnerId = acc.ownerId;
                
            }
        }
    }
    
    public static void checkOpportunities(List<Account> oldRecords, Map<Id,Account> oldRecordsMap, List<Account> newRecords, Map<id,Account> newRecordsMap){
        Map<id,List<opportunity>> accWithOpps = new Map<id,List<opportunity>>();
        List<Opportunity> oppTobeUpdated = new List<Opportunity>();
        for (Account acc : [select id, name,(select id,stagename from opportunities) from Account where id in : newRecordsMap.keyset()] ) {
            if(acc.opportunities.size()>0){
                accWithOpps.put(acc.id,acc.opportunities);
            }
        }
        
        for(id accid : accWithOpps.keyset()){
            for(opportunity opp : accWithOpps.get(accid)) {
                if(opp.StageName != 'Closed Won'){
                    opp.StageName = 'ClosedLost';
                    oppTobeUpdated.add(opp);
                }
            }  
        }
        
        if(oppTobeUpdated.size() > 0 && !oppTobeUpdated.isEmpty()){
            update oppTobeUpdated;
        }
    }
    
}