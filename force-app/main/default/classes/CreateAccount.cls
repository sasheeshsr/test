public class CreateAccount {

    @Auraenabled
    Public static string CreateAccountmethod(Account accobj){
        insert accobj;
        return accobj.id;
    }
    
    
}