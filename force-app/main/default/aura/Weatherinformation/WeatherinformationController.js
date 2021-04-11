({
	doinit : function(component, event, helper) {
        var action = component.get("c.getweatherInformation");
        action.setParams({let : 0,longt : 0, iscity:true});
        action.setCallback(this,function(response){
            component.set("v.objectref",response.getReturnValue());
        });
        $A.enqueueAction(action);
	},
    fatchcurrentweather : function(component, event, helper) {
         if('geolocation' in navigator){
            
            navigator.geolocation.getCurrentPosition(position=>{
               
                var action = component.get("c.getweatherInformation");
                action.setParams({let : position.coords.latitude,longt : position.coords.longitude, iscity:false});
                action.setCallback(this,function(response){
                    component.set("v.objectref",response.getReturnValue());
                });
                $A.enqueueAction(action);

         });
        }else{
            alert('Server is down');
        }           
    }    
})