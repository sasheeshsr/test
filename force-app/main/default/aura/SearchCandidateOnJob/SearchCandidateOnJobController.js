({
     addtojob : function(component, event, helper) {

         var par = component.get('v.item.Candidate__r.Id');
         var action = component.get("c.addCandidateToJob");
         action.setParams({
             "strCanId" : component.get("v.listOfCandidatesP"),
             "strJobId" : component.get("v.recordId")
         });
         action.setCallback(this, function(response) {
             console.log(response.getState());
             if(response.getReturnValue() != 'SUCCESS'){
                 var toastEvent = $A.get("e.force:showToast");
                 toastEvent.setParams({
                     "type": 'Error',
                     "mode": 'dismissible',
                     "duration": 3000,
                     "title": "Error!",
                     "message": "You cannot select "+response.getReturnValue()+ ", it already exist on this record."
                 });
                 toastEvent.fire();
             }else{
                 component.set('v.ButtonClicked', false);
                 component.set("v.showRecord",true);
             }
             
             // window.location.reload('https://samasr92-dev-ed.lightning.force.com/lightning/n/Job_Wizard' , "_self" );
             //window.open("/"+component.get("v.jobId"), "_self"); 
         });
        
        $A.enqueueAction(action); 
    
         
     },
    searchCandidate : function(component, event, helper) {
        console.log('Check searchCandidate: '+component.find("enter-search").get("v.value"));	
        component.set('v.recId', component.get('v.recordId'));
        var searchKey = component.get("v.searchKey");
        if(searchKey.length > 2) {
            var action = component.get("c.getCandidates");
            action.setParams({
                "strSkillsKey" : searchKey,
                "JobId" : component.get("v.recordId")
            });
            action.setCallback(this, function(response) {
                /* console.log(response.getState());
                    console.log(response.getReturnValue());
                    component.set("v.lstCan", response.getReturnValue());
                    component.set("v.showPanel", true);
                    console.log('showPanel '+component.get("v.showPanel"));	
                    console.log('lstCan '+component.get("v.lstCan"));	*/
                    debugger;
                    var state = response.getState();
                    var storeResponse = response.getReturnValue();
                    if (state === "SUCCESS") {
                        if (storeResponse!=null) {
                            // if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                            if (storeResponse==null || storeResponse.length == 0) {
                                component.set("v.Message", 'No Result Found...');
                            } else {
                                component.set("v.Message", '');
                            }
                            // set searchResult list with return value from server.
                            component.set("v.listOfSearchRecords", storeResponse);
                            component.set("v.showPanel", true);
                        }
                    }
                    
                });
                
                $A.enqueueAction(action); 
            }
        },
    cancel : function(component,event,helper){
       component.set('v.ButtonClicked', false); 
    }
        
    })