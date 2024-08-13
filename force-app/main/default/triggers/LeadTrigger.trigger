trigger LeadTrigger on Lead (before insert,before update) {
    List<String> mailList = new List<String>();
    Map<String,contact> contactMap = new Map<String,contact>();
    for(Lead l : Trigger.new){
        mailList.add(l.email);
    }
    List<Contact> conList = [Select id,email,lastname from contact where email in :mailList];
    for(contact con : conList){
        contactMap.put(con.email,con);
    }
    
    for(Lead l : Trigger.new){
        if(contactMap.containsKey(l.email)){
            l.addError('contact alredy exists');
        }
    }

}