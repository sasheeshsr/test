public class AccountUpdateScheduler implements Schedulable {
    
    Public Static void execute(Schedulablecontext se){
        
        AccountUpdateBatch AB = new AccountUpdateBatch();
        database.executebatch(AB);
        
        
    }
    
    
}