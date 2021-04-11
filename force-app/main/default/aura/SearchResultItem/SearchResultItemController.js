({
    
    getSelectedCandidate : function(component,event,helper){
        console.log(component.get("v.isChecked"));
        
        var conId = event.getSource().get("v.value");
       var obj = component.get("v.listOfCandidates") != undefined ? component.get("v.listOfCandidates") : [];
        if(component.get("v.isChecked") ) {
               obj.push(conId);  
            }
            else {
            obj.splice(obj.indexOf(conId), 1);
        }
        console.log('Selected--',obj); 
        component.set("v.listOfCandidates", obj);
        
    }
})