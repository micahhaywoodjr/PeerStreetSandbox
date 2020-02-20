@isTest(SeeAllData=true)
public class RHX_TEST_Loan {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Loan__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Loan__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}