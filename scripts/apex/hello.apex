// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

string tempvar = 'Enter_your_name_here';
System.debug('Hello World!');
System.debug('My name is ' + tempvar);

Map<String, Contact> aMap1 = new Map<String, Contact>([Select Id,LastName, Email from Contact Limit 5]);
System.debug('Map -->' +  aMap1);
System.debug('keyset -->' + aMap1.keySet());

Account acc = new Account(name='tcs', Industry='Banking');
system.debug('name -->' +  acc.name);
if(aMap1.containsKey(acc.name)){
    system.debug('Can not Create the Account with duplicate Name');
}

List<AggregateResult> topAccounts = [select Account.Name, sum(Amount) totalrevenue from Opportunity where AccountId != null group by Account.Name orderby totalrevenue desc limit 5];

system.debug('topAccounts -->'+ topAccounts);
