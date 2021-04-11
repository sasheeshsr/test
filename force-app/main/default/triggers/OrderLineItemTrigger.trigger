trigger OrderLineItemTrigger on Order_Line_Item__c (After insert) 

{
    if(trigger.isAfter)
    {
        Map<Id,sproduct__c> mapofproducts = new Map<Id,sproduct__c> ( [SELECT Id, Quantity__c FROM sproduct__c] );
        if(trigger.isInsert )
        {
            for(Order_Line_Item__c   oItem : trigger.new)
            {
                //System.debug(oItem);
                if(oItem.sproduct__c != null)
                {
                    //System.debug(oItem.sproduct__c);
                    sproduct__c product = mapofproducts.get(oItem.sproduct__c);
                    if(product.Quantity__c - oItem.Quantity__c >0 )
                    {
                        product.Quantity__c -= oItem.Quantity__c;
                    } 
                    else
                    {
                        System.debug('Error No stock left');
                    }   
                }
            }
            update mapofproducts.values();
        }
    }
}