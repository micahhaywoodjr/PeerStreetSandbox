global class CP_AddressFinderBatchClass implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful
{
    public List<Loan__c> lstLoanToUpdate = new List<Loan__c>();
    
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        string strQuery = 'select id, Address__c, City__c,Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c,Max_Remaining_Term__c, Terminus_Effective_Date__c, State__c, Zip_Code__c from Loan__c where Is_Address_Changed__c = true';
        return Database.getQueryLocator(strQuery);
    }
    
    // Execute Logic
    global void execute(Database.BatchableContext BC, List<Loan__c> lstLoans)
    {
        lstLoanToUpdate = new List<Loan__c>();
        
        if(lstLoans != null && lstLoans.size() > 0)
        {
            // 3/18/16 AlexP: commenting out the geocoding portion
            // 1) It's currently breaking some loans by deleting the city for some reason
            // 2) It's not using the same format as LP/OpenRefine (short_name vs long_name in places)
            // 3) Geocoding is already done by LP/OpenRefine and we shouldn't add loans to Salesforce manually
        
            // Btw, this class is part of a scheduled job or something, so you have to change the name of the class itself
            // before trying to save it. Then change it back after. Awesome.
        
        
            /*
            for(Loan__c objLoan : lstLoans)
            {
                string strAddress = '';
                
                if(objLoan.Address__c != null)
                    strAddress = objLoan.Address__c;
                    
                if(objLoan.City__c != null)
                    strAddress += '%20' + objLoan.City__c;
                    
                if(objLoan.State__c != null)
                    strAddress += '%20' + objLoan.State__c;
                    
                if(objLoan.Zip_Code__c != null)
                    strAddress += '%20' + objLoan.Zip_Code__c;
                    
                if(strAddress != null && strAddress.trim() != '')
                {
                    CP_AddressDetail objAD = new CP_AddressDetail();
                    Loan__c objLoanAddress = objAD.GetAddressDetails(strAddress);
                    
                    if(objLoanAddress != null)
                    {
                        objLoan.Address__c = objLoanAddress.Address__c;
                        objLoan.City__c = objLoanAddress.City__c;
                        objLoan.State__c = objLoanAddress.State__c;
                        objLoan.Zip_Code__c = objLoanAddress.Zip_Code__c.trim();
               
                    }
                }
                
                lstLoanToUpdate.add(objLoan);
            }
            */
            
            // Code added by DC
            CP_Zip_forecastapi zipfcst = new CP_Zip_forecastapi();
            List<Loan__c> Lstzipapi = zipfcst.GetZipAPI(lstLoans, true);
            update Lstzipapi;
            //finally updating the fetched address
            update lstLoans;
            
            for(Loan__c objLoan : lstLoans)
            {
                objLoan.Is_Address_Changed__c = false;
            }
            update lstLoans;
            
            
            
            
        }
    }
    
    global void finish(Database.BatchableContext BC)
    {
        /*if(lstLoanToUpdate != null && lstLoanToUpdate.size() > 0)
        {
            for(Loan__c objLoan : lstLoanToUpdate)
            {
                objLoan.Is_Address_Changed__c = false;
            }
            
            update lstLoanToUpdate;
        }*/
    }
}