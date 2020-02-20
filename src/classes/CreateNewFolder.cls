public class CreateNewFolder{

    @future (callout=true)
    public static void CreateNewFolder_Loan(Set<Id> loanIds){
        List<Loan__c> lstLoans = [select Id, Name,Address__c, Current_Lender_Entity__c,FolderId__c from Loan__c where Id in: loanIds];
        
        if(lstLoans.size() == 0 || lstLoans.size() > 99){
            return;
        }
        
        // Source documentation: https://community.box.com/t5/Integrations/Box-For-Salesforce-Developer-Toolkit/ta-p/689
        
        // Instantiate the Toolkit object
        box.Toolkit bt = new box.Toolkit();
        
        For(Loan__c objLoan : lstLoans){
            // Create a folder and associate it with the loan
            String newFolderId = bt.createFolderForRecordId(objLoan.Id, null, true);

            //If there was an error, accountFolderId will be null. 
            // mostRecentError will contain the error message
            if(newFolderId == null) {
                system.debug('most recent error: ' + bt.mostRecentError);
            } else {
                // ALWAYS call this method when finished.
                // Since salesforce doesn't allow http callouts after dml operations,
                // we need to commit the pending database inserts/updates or we will
                // lose the associations created
                bt.commitChanges(); 
                
                objLoan.FolderId__c = newFolderId;
                update objLoan;
            }
        }
    }
}