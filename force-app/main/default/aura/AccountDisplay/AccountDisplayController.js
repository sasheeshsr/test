({
	doSave : function(component, event, helper) {
        var action = component.get("c.CreateAccountmethod");
        
        action.setParams({'accobj':component.get('v.accountObj')});
        action.setCallback(this,function(data){           
            component.set('v.accountId',data.getReturnValue())
        });
        $A.enqueueAction(action);
                           
		
	}
})