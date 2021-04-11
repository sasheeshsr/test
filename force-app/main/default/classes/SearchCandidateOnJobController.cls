public class SearchCandidateOnJobController {
    
    @AuraEnabled
    public static List<sObject> getCandidates(String strSkillsKey, String JobId) {
        String strName = strSkillsKey+'%'; 
        List<Contact> lstCon = new List<Contact>();
        String sQuery = 'Select Id, Name, Candidate__r.Name, Candidate__r.Id From Skill__c Where Name LIKE ' +  '\'' + strName + '\'';
        System.debug('sQuery: '+sQuery);
        List<Skill__c> lstSK = Database.query(sQuery);
        System.debug('lstSK: '+lstSK);
        return lstSK;
    }
    
    @AuraEnabled
    public static String addCandidateToJob(List<String> strCanId, String strJobId) {
        system.debug('strCanId'+strCanId);
        system.debug('strJobId'+strJobId);
        List<Contact> lstC = new List<Contact>();
        List<Contact> ContactExist = [Select Id, Job__c,Name from Contact where Job__r.Id =: strJobId And Id IN: strCanId];
        
        if(!ContactExist.isEmpty()){
            for(Contact objCt : ContactExist){
                System.debug('error');
                return objCt.Name; 
            }
        }
        
        for(String str: strCanId) {
            Contact objCon = new Contact();
            objCon.Id = str;
            System.debug('jobid'+objCon.Job__c);
            
            objCon.Job__c  = strJobId;
            lstC.add(objCon);
             }
        
        Update lstC; 
     	return 'SUCCESS';   
    }
    
}