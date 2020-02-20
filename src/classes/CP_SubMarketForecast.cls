public class CP_SubMarketForecast {
public set<id> setbuyid {get; set;}
Public List<loan__c> lstLoan;  
public id lid;
public string returnUrl {get; set;}  

    public CP_SubMarketForecast(ApexPages.StandardController controller1) {
    
      returnUrl = ApexPages.CurrentPage().getParameters().get('retURL');
        
    }
    
    
    public CP_SubMarketForecast(ApexPages.StandardSetController controller) {
        /*
        
        ApexPages.StandardSetController setController = controller;
        setBuyId = new set<Id>();
        
        for(Loan__c loan1 : (List<loan__c>) setController.getSelected())
        {
            setBuyId.add(loan1.Id);
        }
        
        if(setbuyid.size() > 0){
        
        lstloan = [Select id, name, Zip_Code__c, address__c,As_is_valuation__c, Terminus_Price_Tier__c, Terminus_Geo_Level__c, Forecast_Next_12_Mo_Market__c, Forecast_Next_24_Mo_Market__c, Max_Remaining_Term__c, Terminus_Effective_Date__c from Loan__c where id in: setBuyId];
        
        returnUrl = ApexPages.CurrentPage().getParameters().get('retURL');
        }else
        {
        lid = string.valueOf(ApexPages.currentPage().getParameters().get('id'));
        lstloan = [Select id, name, Zip_Code__c,address__c,As_is_valuation__c, Terminus_Price_Tier__c, Terminus_Geo_Level__c, Forecast_Next_12_Mo_Zip__c, Forecast_Next_24_Mo_Zip__c,Max_Remaining_Term__c, Terminus_Effective_Date__c from Loan__c where id =: lid];
        
        returnUrl = '/' + lid;
        }
        
        */
    }
    
    Public void Getresults(){
    
    /*
    
    If(lstLoan != null && lstLoan.size() >0){
     
     List<loan__c> updloan = new List<Loan__c>(); 
      
        for(loan__c loan : lstLoan){
        
            If(loan.zip_code__c != null && loan.zip_code__c != ''&& loan.address__c != null && loan.address__c != '' && loan.As_is_valuation__c != null) {
                        
                        string zipcode = loan.zip_code__c.trim();
                        string address = loan.address__c.trim();
                        decimal valuation = loan.As_is_valuation__c;
                        string date1 = string.valueof(system.today());
                        
                        
                        string endpointUrl = Label.SubMarketForecastKey;
                        endpointUrl = endpointUrl.replace('Zip_Code__c', zipcode);
                        endpointUrl = endpointUrl.replace('Address__c', address);
                        endpointUrl = endpointUrl.replace('As_Is_Valuation__c', string.valueof(valuation));
                        endpointUrl = endpointUrl.replace('Today()', date1);
                        endpointUrl = endpointUrl.replace(' ','%20');
                        
                    
                        HttpRequest req1 = new HttpRequest();
                        req1.setEndPoint(endpointUrl);
                        req1.setMethod('GET');
                        req1.setHeader('Content-Type','application/json');
                        req1.setHeader('Accept','application/json');
                        req1.settimeout(10000);
                        Http http1 = new Http();
                        string response1 = httpresponse();
                        
                        if(!test.IsRunningTest()){
                        
                            HttpResponse res1 = http1.send(req1);
                            response1 = res1.getbody(); 
                            
                        }
                        
                        JSONParser parser = JSON.createParser(response1);
                            
                            while (parser.nextToken() != null) {
                                
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'QTR_FC_4_APPR '){
                                   
                                    parser.nextToken();
                                     loan.Forecast_Next_12_Mo_Market__c = decimal.valueof(parser.gettext())*100;
                                    
                                    
                                    }
                                    
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'QTR_FC_8_APPR '){
                                   
                                    parser.nextToken();
                                    loan.Forecast_Next_24_Mo_Market__c = decimal.valueof(parser.gettext())*100;
                                    
                                    
                                    }
                                    
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'PRICE_TIER'){
                                   
                                    parser.nextToken();
                                    loan.Terminus_Price_Tier__c = parser.gettext();
                                    
                                    
                                    }
                                    
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'GEO_LEVEL'){
                                   
                                    parser.nextToken();
                                    loan.Terminus_Geo_Level__c = parser.gettext();
                                    
                                    
                                    }
                                    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Market Forecast Processed Successfully for Loan ' + Loan.name));
                        }
                }else{
                ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.warning, 'Incomplete information found in Loan ' + Loan.name));
                }
                    updloan.add(loan);
                
                }
                
                update updloan;
                }
    */
    }
    
Public pagereference BackToList(){

return new PageReference(returnUrl);

}

Public string httpresponse(){
string setresponse =  '{' + 
 ' "data":{'+  
  '  "created_at":"2015-12-29T10:32:10.869-08:00",'+
   ' "effective_at":"2015-12-29",'+
    '"valued_at":"2015-01-01",'+
    '"value":300000,'+
    '"response":{'+  
     ' "hdiResult":{'+  
      '  "HPI_1":"121.75160",'+
       ' "HPI_2":"120.87299",'+
        '"HPI_3":"118.10507",'+
        '"HPI_4":"113.80730",'+
        '"HPI_5":"108.06317",'+
        '"HPI_6":"102.08130",'+
        '"HPI_7":"98.04611",'+
        '"TREND_IS":"DEGRADING",'+
        '"GEO_LEVEL":"ZIP",'+
        '"HPI_FC_1 ":"123.33527",'+
        '"HPI_FC_2 ":"125.04746",'+
        '"HPI_FC_3 ":"127.15560",'+
        '"HPI_FC_4 ":"129.66510",'+
        '"HPI_FC_5 ":"132.24569",'+
        '"HPI_FC_6 ":"134.49546",'+
        '"HPI_FC_7 ":"136.56794",'+
        '"HPI_FC_8 ":"137.99379",'+
        '"PRICE_TIER":"L",'+
        '"QTR_1_APPR":"0.0073",'+
        '"QTR_2_APPR":"0.0309",'+
        '"QTR_4_APPR":"0.1267",'+
        '"FIRST_MODEL":"PAIRED SALES",'+
        '"QTR_FC_1_APPR ":"0.0130",'+
        '"QTR_FC_2_APPR ":"0.0271",'+
        '"QTR_FC_3_APPR ":"0.0444",'+
        '"QTR_FC_4_APPR ":"0.0650",'+
        '"QTR_FC_5_APPR ":"0.0862",'+
        '"QTR_FC_6_APPR ":"0.1047",'+
        '"QTR_FC_7_APPR ":"0.1217",'+
        '"QTR_FC_8_APPR ":"0.1334"'+
      '},'+
      '"statusCode":"0",'+
      '"orderDetails":{'+  
       ' "orderId":5042024,'+
       ' "transactionId":"20688119"'+
      '},'+
      '"statusMessage":"success",'+
      '"processingDetails":{'+  
       ' "zip":"90266",'+
       ' "value":"300000",'+
        '"street":"300 Manhattan Beach Blvd",'+
        '"message":"",'+
        '"latitude":33.884953,'+
        '"longitude":-118.4094,'+
        '"valueDate":"01/01/2015",'+
        '"geo-accuracy":"PROPERTY",'+
        '"effectiveDate":"12/29/2015"'+
      '}'+
    '},'+
    '"id":"fe595098-d320-435a-8e09-76f4ece33da8",'+
    '"type":"market_trends"'+
  '}'+
'}';
 return setresponse;
}

}