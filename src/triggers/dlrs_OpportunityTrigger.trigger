/**
* Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
**/
trigger dlrs_OpportunityTrigger on Opportunity
(before delete, before insert, before update, after delete, after insert, after undelete, after update)
{
    dlrs.RollupService.triggerHandler();
  
     List<Runpositioncreation__c> listCodes = Runpositioncreation__c.getAll().values(); 
    if(listCodes.get(0).IsRunn__c){
         if(Trigger.Isinsert && Trigger.IsBefore)
    	{
       		 OpptyHelper.positionCreate(Trigger.New);
    	 }
         OpptyTextRollup objChildTrigHand = new OpptyTextRollup();
        if((trigger.isInsert || trigger.isUpdate) && (Trigger.IsAfter)) {
               objChildTrigHand.UpdateFields(Trigger.new);
               OpptyHelper.getRollup(Trigger.new);
         }
        if(trigger.isDelete && Trigger.IsAfter){
          OpptyHelper.UpdateDelRollup(Trigger.old);
        }
    }
    
    
}