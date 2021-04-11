public class JobWizardController {
    @AuraEnabled
    public static List<Job__c> getJobs(){
        List<Job__c> lstJobs = [Select Name from Job__c ];
        return lstJobs;
    }
    @AuraEnabled
    public static List<Skill__c> getSkills(String jobId){
        List<Skill__c> lstSkills = [Select Name, Candidate__r.Name ,Job__r.Name, CreatedDate from Skill__c where Job__c=:jobId ];
        return lstSkills;
    }
    @AuraEnabled
    public static List<Contact> getContacts(String jobId){
        List<Contact> lstContact = [Select Name, Account.Name ,Phone from Contact where Job__c=:jobId ];
        return lstContact;
    }
}