/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
trigger dlrs_LoanTrigger on Loan__c
    (before delete, before insert, before update, after delete, after insert, after undelete, after update)
{
    dlrs.RollupService.triggerHandler();
    
    //Added by CloudPanthers on 26th Feb 2016
    //Creating new Folder in Box when a new Loan is getting created.
    if(trigger.isAfter && trigger.IsInsert) {
        if(trigger.new.size() <= 99) {
            // AlexP 6/6/16: Disable Box folder creation, it's done by LP now
            // CreateNewFolder.CreateNewFolder_Loan(trigger.newMap.keySet());        
        }
    }
    
    // Trigger ths logic for Currency number to Word Logic
    
    if(Trigger.IsBefore)
	{
		if(Trigger.IsInsert || Trigger.Isupdate)
		{
			for(Loan__c ln:Trigger.New)
			{
			   if(ln.Fully_Funded_Loan__c !=null){
				ln.Fully_Funded_Loan_Amount_text__c=LoanHelper.english_number(integer.valueOf(ln.Fully_Funded_Loan__c));
				}
				else
				{
					ln.Fully_Funded_Loan_Amount_text__c=null;
				}
			}
		}
		
    
    }
	List<Id> lstLoanId=new List<Id>();    
    if(Trigger.IsAfter && Trigger.Isupdate)
    {
            for(Loan__c ln:Trigger.New)
            {
                if(ln.note_status__c !=null){
                	if(String.valueof(ln.note_status__c).toLowerCase() =='active' || String.valueof(ln.note_status__c).toLowerCase() =='paid_off')
                lstLoanId.add(ln.Id);
                }
            }
        
        System.debug('lstLoanId==>'+lstLoanId);
        List<Opportunity> lstop=new List<Opportunity>();
        for(Opportunity op:[SELECT ID,Parent_Loan_Status_Hidden__c,Parent_Loan_Status__c FROM Opportunity WHERE Loan__r.Loan__c=:lstLoanId and positions__C !=null])
        {
            op.Parent_Loan_Status_Hidden__c=op.Parent_Loan_Status__c;
            lstop.add(op);
        }
        System.debug('lstop==>'+lstop);
        if(!lstop.isEmpty())
        {
            update lstop;
        }
}

}