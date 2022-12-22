trigger CountContacts on Contact (After insert ,After update, After delete) {
    Set<Id> setid = new Set<Id>();
    List<Account> updateAccountList = new List<Account>();
    if(trigger.isAfter){
        if(trigger.Isinsert || trigger.IsUpdate){
            For(Contact con : trigger.new){
               setid.add(con.AccountId); 
            }
          }
        if(trigger.IsDelete || trigger.IsUpdate){
            For(Contact con : trigger.old){
                setid.add(con.AccountId);
            }
        }
    }
    List<Account> accountlist = [Select Id, Name, Number_of_Contacts__c,(Select Id, LastName from Contacts) From Account where Id =: setid];
    for(Account acc : accountlist){
        acc.Number_of_Contacts__c = acc.Contacts.size();
        updateAccountList.add(acc);
    }
    update updateAccountList;
}