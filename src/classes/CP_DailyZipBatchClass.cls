global class CP_DailyZipBatchClass implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful
{
    public List<Loan__c> lstLoanToUpdate = new List<Loan__c>();
    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
    string strQuery = '';
    
        If(!test.isRunningTest())
        {
            strQuery = 'select id, Address__c, City__c,zForecast_Next_12_Mo_Zip__c, zForecast_Next_24_Mo_Zip__c, zWorst_Rolling_Downside_Scenario__c, Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c,Max_Remaining_Term__c, Terminus_Effective_Date__c, zTerminus_Effective_Date__c, State__c,Zip_Code__c from Loan__c where Daily_batch__c = true'; 
        }else
        {
           strQuery = 'select id, Address__c, City__c,zForecast_Next_12_Mo_Zip__c, zForecast_Next_24_Mo_Zip__c, zWorst_Rolling_Downside_Scenario__c, Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c,Max_Remaining_Term__c, Terminus_Effective_Date__c, zTerminus_Effective_Date__c, State__c,Zip_Code__c from Loan__c'; 
        }
        return Database.getQueryLocator(strQuery);
    }
    
    // Execute Logic
    global void execute(Database.BatchableContext BC, List<Loan__c> lstLoans)
    {
        
         CP_Zip_forecastapi zipfcst = new CP_Zip_forecastapi();
         List<Loan__c> Lstzipapi = zipfcst.GetZipAPI(lstLoans, false);
         update Lstzipapi;
        
        
    }
    
    global void finish(Database.BatchableContext BC)
    {
        
    }
}