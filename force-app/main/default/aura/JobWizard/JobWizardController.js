({
    doInit : function(component, event, helper) {
        var action = component.get("c.getJobs");
        
        action.setCallback(this , function(response){
            if(response.getState() === "SUCCESS"){
                var result = response.getReturnValue();
                console.log(result);
                component.set("v.Jobs",result);
            }
        });
        $A.enqueueAction(action);
    },
    Record : function(component,event,helper){
        var idx = event.target.id;
        component.set("v.NameClicked",true);
        component.set("v.record",idx);
        // alert(idx);  
        
        var action = component.get("c.getSkills");
        action.setParams({ jobId : idx });
        action.setCallback(this , function(response){
            if(response.getState() === "SUCCESS"){
                var result = response.getReturnValue();
                console.log(result);
                component.set("v.Skills",result);
            }
        });
        $A.enqueueAction(action);
        
        var action2 = component.get("c.getContacts");
        action2.setParams({ jobId : idx });
        action2.setCallback(this , function(response){
            if(response.getState() === "SUCCESS"){
                var result = response.getReturnValue();
                console.log(result);
                component.set("v.Candidates",result);
            }
        });
        $A.enqueueAction(action2); 
        component.set("v.ButtonClicked",false);
        
    },
    gotoURL : function(component , event , helper){
        component.set("v.ButtonClicked",true);
    },
   itemsChange : function(component,event,helper){
        var isChecked = component.get("v.ButtonClicked");
        
        if(!isChecked){
            var varId = component.get("v.record");
            var action2 = component.get("c.getContacts");
            action2.setParams({ jobId : varId });
            action2.setCallback(this , function(response){
                if(response.getState() === "SUCCESS"){
                    var result = response.getReturnValue();
                    console.log(result);
                    component.set("v.Candidates",result);
                }
            });
            $A.enqueueAction(action2); 
        }
        
        
    }
})