public class OpportunityTriggerHandler {
    
    public void checkOpps(List<id> accids) {
        List<Account> accToUpdate = new List<Account>();
        for (Aggregateresult ars : [select count(id)opp,AccountId from opportunity where AccountId in : accids group by AccountId]) {
            Account acc = new Account();
            acc.id = (Id) ars.get('AccountId');
            acc.TotalOpportunities__c = (integer) ars.get('opp');
            accToUpdate.add(acc);
        }
        
        if(accToUpdate.size()>0) {
            update accToUpdate;
        }
        
    }
    
    public void checkMaxAmount(List<id>oppIds){
        List<AggregateResult> ars = [select id,Max(Amount)from opportunity where id in :oppIds group by id];
    }

}