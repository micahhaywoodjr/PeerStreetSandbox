@isTest(SeeAllData=true)
public class LH_TEST_Loan {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Loan__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Loan__c()
            );
        }
       Database.upsert(sourceList);
    }
}