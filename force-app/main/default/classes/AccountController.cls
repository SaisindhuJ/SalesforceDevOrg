public with sharing class AccountController {
    
    @AuraEnabled
    public static List<Account> getAccounts(){
       List<Account> acc = [select Name,Industry,Phone,Rating,AnnualRevenue from Account LIMIT 200];
       return acc; 
    }
    
    @AuraEnabled
    public static List<contact> getContactsOfAccount(String accountId){
        List<Contact> con = [select Name,Account.Name,Phone,Fax,Email from contact where AccountId =:accountId];
        return con;
    }

}