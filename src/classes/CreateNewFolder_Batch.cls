global with sharing class CreateNewFolder_Batch implements Database.Batchable<sObject>, Database.AllowsCallouts{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
        return Database.getQueryLocator([Select Id, Name, Address__c, Current_Lender_Entity__c, FolderId__c from Loan__c where FolderId__c = '']);
    }
    
    global void execute(Database.BatchableContext BC, list<Loan__c> scope){
        box.Toolkit bt = new box.Toolkit();
        
        List<Loan__c> lstLoans = (List<Loan__c>)scope;        
        For(Loan__c objLoan : lstLoans){
			String newFolderId = bt.createFolderForRecordId(objLoan.Id, null, true);
			if(newFolderId == null) {
                system.debug('most recent error: ' + bt.mostRecentError);
            } else {
                // ALWAYS call this method when finished.
                // Since salesforce doesn't allow http callouts after dml operations,
                // we need to commit the pending database inserts/updates or we will
                // lose the associations created
                
                objLoan.FolderId__c = newFolderId;
            }
        }
        bt.commitChanges(); 
        update lstLoans;
    }
    
    global void finish(Database.BatchableContext BC){
    
    }
}