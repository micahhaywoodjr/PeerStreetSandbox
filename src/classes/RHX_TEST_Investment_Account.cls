@isTest(SeeAllData=true)
public class RHX_TEST_Investment_Account {
	static testMethod void RHX_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
			FROM Investment_Account__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Investment_Account__c()
            );
        }
    	rh2.ParentUtil.UpsertRollupTestRecords( sourceList );
    }
}