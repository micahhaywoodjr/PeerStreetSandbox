Public class CP_Zip_forecastapi
{

Public List<Loan__c> GetZipAPI(List<Loan__c> lstloan, boolean flag)
{
List<loan__c> updloan = new List<Loan__c>(); 
      
        for(loan__c loan : lstLoan){
        
            If(loan.zip_code__c != null && loan.zip_code__c != ''){
                        
                        string zipcode = loan.zip_code__c;
                        zipcode = zipcode.trim();
                        string endpointUrl = Label.ZipKey;
                        endpointUrl = endpointUrl.replace('Zip_Code__c', zipcode);
                        endpointUrl = endpointUrl.replace(' ','%20');
                        string test2 = string.valueOf(loan.Max_Remaining_Term__c);
                    
                        HttpRequest req1 = new HttpRequest();
                        req1.setEndPoint(endpointUrl);
                        req1.setMethod('GET');
                        req1.setHeader('Content-Type','application/json');
                        req1.setHeader('Accept','application/json');
                        
                        Http http1 = new Http();
                        string response1 = 'test';
                        
                        if(!test.IsRunningTest()){
                        
                            HttpResponse res1 = http1.send(req1);
                            response1 = res1.getbody(); 
                        }else{
                        
                        response1 = httpresponse();
                        
                        }      
                            JSONParser parser = JSON.createParser(response1);
                            
                            while (parser.nextToken() != null) {
                            
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'projected_12'){
                                    parser.nextToken();
                                    if(flag == true){
                                    loan.Forecast_Next_12_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }else
                                    {
                                    loan.zForecast_Next_12_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }
                                    
                                    }
           
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'projected_24'){
                                    parser.nextToken();
                                    
                                    if(flag == true){
                                    loan.Forecast_Next_24_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }else
                                    {
                                    loan.zForecast_Next_24_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }
    
                                    }
                                    
                                    if(loan.Max_Remaining_Term__c != null){
                                    
                                        if(loan.Max_Remaining_Term__c >= 0 && loan.Max_Remaining_Term__c <= 3 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_3_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }
                                                    
                                             }                                
                                        }
                                        
                                        if(loan.Max_Remaining_Term__c > 3 && loan.Max_Remaining_Term__c <= 6 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_6_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }

                                        if(loan.Max_Remaining_Term__c > 6 && loan.Max_Remaining_Term__c <= 9 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_9_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 9 && loan.Max_Remaining_Term__c <= 12 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_12_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 12 && loan.Max_Remaining_Term__c <= 15 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_15_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 15 && loan.Max_Remaining_Term__c <= 18 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_18_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 18 && loan.Max_Remaining_Term__c <= 21 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_21_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 21 && loan.Max_Remaining_Term__c <= 24 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_24_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 24 && loan.Max_Remaining_Term__c <= 27 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_27_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 27 && loan.Max_Remaining_Term__c <= 30 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_30_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 30 && loan.Max_Remaining_Term__c <= 33 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_33_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }

                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 33 && loan.Max_Remaining_Term__c <= 36 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_36_max_decrease'){
                                                    parser.nextToken();
                                                    If (flag == true){
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }else
                                                    {
                                                    loan.zWorst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                                    }
                                                    
                                             }                                
                                        }
                                        
                                        If (flag == true)
                                        {
                                          loan.Terminus_Effective_Date__c = system.today();
                                        }else
                                        {
                                          loan.zTerminus_Effective_Date__c = system.today();
                                        }
                                        
                                    
                                    }
                            }
                            
                            updloan.add(loan);
                            
                            
                        
         }
      }

return updloan;
}

Public string httpresponse(){

string jsonresponse = '{'+  
    '"data":{'+  
    '"recorded_at":"2015-05-31",'+
    '"geo_type":"ZIP",'+
    '"geo_id":"90266",'+
    '"quarter_over_quarter":"0.0179697069",'+
    '"year_over_year":"0.143037904",'+
    '"projected_12":"0.0787140183",'+
    '"projected_24":"0.1688024117",'+
    '"peak_at":"2015-05-31",'+
    '"trough_at":"1995-07-31",'+
    '"peak_to_trough":"-0.1829471488",'+
    '"trough_to_current":"3.769665042",'+
    '"peak_to_current":"0.0",'+
    '"rolling_12_max_increase":"0.24169349",'+
    '"rolling_24_max_increase":"0.4968812637",'+
    '"rolling_36_max_increase":"0.6992661422",'+
    '"rolling_3_max_decrease":"-0.0433048026",'+
    '"rolling_6_max_decrease":"-0.0816336329",'+
    '"rolling_9_max_decrease":"-0.1115058127",'+
    '"rolling_12_max_decrease":"-0.1347485238",'+
    '"rolling_15_max_decrease":"-0.1500516976",'+
    '"rolling_18_max_decrease":"-0.1603005452",'+
    '"rolling_21_max_decrease":"-0.1607238087",'+
    '"rolling_24_max_decrease":"-0.1607238087",'+
    '"rolling_27_max_decrease":"-0.1607238087",'+
    '"rolling_30_max_decrease":"-0.1607238087",'+
    '"rolling_33_max_decrease":"-0.1710293326",'+
    '"rolling_36_max_decrease":"-0.1810252277",'+
    '"distressed_saturation":"0.0073",'+
    '"id":"6aa86873-f56a-4d1e-9560-547ffdc52386",'+
    '"type":"summaries"'+
  '}'+
'}';

return jsonresponse;


}


}