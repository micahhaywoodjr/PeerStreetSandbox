@isTest(SeeAllData=true)
public class LH_TEST_Forecast_Rollup {
   static testMethod void LH_Testmethod() {
        List<sObject> sourceList = [SELECT Id 
           FROM Forecast_Rollup__c LIMIT 1];
        if(sourceList.size() == 0) {
            sourceList.add(
                    new Forecast_Rollup__c()
            );
        }
       Database.upsert(sourceList);
    }
}