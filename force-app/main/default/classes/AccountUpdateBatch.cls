public class AccountUpdateBatch implements Database.Batchable<sObject> {

    public Database.Querylocator start(Database.BatchableContext con){
        return Database.getQueryLocator([Select id,achk__c from account where achk__c	=false and Active__c = 'Yes']);
    }
    public void execute(Database.BatchableContext con,List<Account> acc){
        
        List<Account> accountlist = new List<Account>();
        
        for(Account ac: acc){
            
            Account accounts = new Account();
            accounts.id	=	ac.id;
            accounts.achk__c = true;
            
            accountlist.add(accounts);
        }
        if(!accountlist.isEmpty())
        Database.Update(accountlist);
        
    }
    
    public void finish(Database.BatchableContext con){
        
    }
}