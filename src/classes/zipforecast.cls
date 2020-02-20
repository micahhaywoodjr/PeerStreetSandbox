public class zipforecast {
public set<id> setbuyid {get; set;}
public string zipcode {get; set;}

Public string test2{get; set;}
Public List<loan__c> lstLoan;  
public id lid;
public string returnUrl {get; set;}  
    
    public zipforecast(ApexPages.StandardController controller) {
    
        
    }
    
    public zipforecast(ApexPages.StandardSetController controller1){
        ApexPages.StandardSetController setController = controller1;
        setBuyId = new set<Id>();
        
        for(Loan__c loan1 : (List<loan__c>) setController.getSelected())
        {
            setBuyId.add(loan1.Id);
        }
        
        if(setbuyid.size() > 0){
        
        lstloan = [Select id, Zip_Code__c, Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c, Max_Remaining_Term__c, Terminus_Effective_Date__c from Loan__c where id in: setBuyId];
        test2 = 'i am from list view';
        returnUrl = ApexPages.CurrentPage().getParameters().get('retURL');
        }else
        {
        lid = string.valueOf(ApexPages.currentPage().getParameters().get('id'));
        lstloan = [Select id, Zip_Code__c, Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c,Max_Remaining_Term__c, Terminus_Effective_Date__c from Loan__c where id =: lid];
        test2 = 'i am from page';
        returnUrl = '/' + lid;
        }
        
    }
    
    Public void getapi(){
    
    If(lstLoan != null && lstLoan.size() >0){
     
     List<loan__c> updloan = new List<Loan__c>(); 
      
        for(loan__c loan : lstLoan){
        
            If(loan.zip_code__c != null && loan.zip_code__c != ''){
                        
                        zipcode = loan.zip_code__c;
                        zipcode = zipcode.trim();
                        string endpointUrl =  Label.ZipKey;
                        endpointUrl = endpointUrl.replace('Zip_Code__c', zipcode);
                        endpointUrl = endpointUrl.replace(' ','%20');
                        test2 = string.valueOf(loan.Max_Remaining_Term__c);
                    
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
                                    loan.Forecast_Next_12_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }
           
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'projected_24'){
                                    parser.nextToken();
                                    loan.Forecast_Next_24_Mo_Zip__c = decimal.valueOf(parser.gettext())*100;
                                    }
                                    
                                    if(loan.Max_Remaining_Term__c != null){
                                    
                                        if(loan.Max_Remaining_Term__c >= 0 && loan.Max_Remaining_Term__c <= 3 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_3_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        
                                        if(loan.Max_Remaining_Term__c > 3 && loan.Max_Remaining_Term__c <= 6 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_6_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }

                                        if(loan.Max_Remaining_Term__c > 6 && loan.Max_Remaining_Term__c <= 9 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_9_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 9 && loan.Max_Remaining_Term__c <= 12 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_12_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 12 && loan.Max_Remaining_Term__c <= 15 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_15_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 15 && loan.Max_Remaining_Term__c <= 18 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_18_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 18 && loan.Max_Remaining_Term__c <= 21 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_21_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 21 && loan.Max_Remaining_Term__c <= 24 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_24_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 24 && loan.Max_Remaining_Term__c <= 27 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_27_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 27 && loan.Max_Remaining_Term__c <= 30 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_30_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 30 && loan.Max_Remaining_Term__c <= 33 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_33_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        if(loan.Max_Remaining_Term__c > 33 && loan.Max_Remaining_Term__c <= 36 ){
                                        
                                             If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'rolling_36_max_decrease'){
                                                    parser.nextToken();
                                                    loan.Worst_Rolling_Downside_Scenario__c = decimal.valueOf(parser.gettext())*100;
                                             }                                
                                        }
                                        
                                        loan.Terminus_Effective_Date__c = system.today();
                                    
                                    }
                            }
                            
                            updloan.add(loan);
                            
                            
                        
         }
      }
      ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Zip Forecast has been processed successfully'));
      update updloan;
   }
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

Public pagereference BackToList(){

return new PageReference(returnUrl);

}


}