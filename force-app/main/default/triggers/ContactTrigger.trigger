trigger ContactTrigger on Contact (before insert,after insert, before update, after update, before delete, after delete,after undelete) {

    if(Trigger.isBefore && Trigger.isInsert) {
        List<Account> accountListToBeInserted = new List<Account>();
        Map<string,contact> parentMapping = new Map<string,contact>();
        for (contact con : Trigger.new) {
            if (con.AccountId == null) {
                Account acc = new Account(name = con.Lastname, Industry = 'Banking');
                accountListToBeInserted.add(acc);
                parentMapping.put(acc.name, con);
            }
        }
        
        if(accountListToBeInserted.size() > 0 && !accountListToBeInserted.isEmpty()){
            insert accountListToBeInserted;
        }
        
        for(Account acc : accountListToBeInserted) {
            if(parentMapping.containsKey(acc.name)) {
                contact con = parentMapping.get(acc.name);
                con.AccountId = acc.id;
            }
        }
        
    }
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        List<String> parentIds = new List<String>();
        Map<contact,Id> contactMap = new Map<contact,Id>();
        Map<Id,Account> parentAccountMap = new Map<Id,Account>();
        for (contact con : Trigger.new) {
            if(con.Email == null || con.Email == '' || con.Phone == null || con.Phone == '') {
                con.addError('Email and Phone fields should not be blank');
            }
        }
        
        for(contact con: Trigger.new) {
            if(con.AccountId != null) {
                parentIds.add(con.AccountId);
                contactMap.put(con,con.AccountId);
            }
        }
        
        for(Account acc : [select id,name,phone,fax from account where id in :parentIds]) {
            parentAccountMap.put(acc.id,acc);
        }
        
        for(contact con: Trigger.new) {
            if(con.AccountId != null && parentAccountMap.containsKey(con.AccountId)){
            Account acc = parentAccountMap.get(contactMap.get(con));
            con.Phone = acc.phone;
            con.Fax = acc.Fax; 
            }
            
        }
        
    }
}