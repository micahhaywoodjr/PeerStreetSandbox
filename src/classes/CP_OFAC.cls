public class CP_OFAC {
public set<id> setbuyid {get; set;}
Public List<loan__c> lstLoan;  
public id lid;
public string returnUrl {get; set;}


    public CP_OFAC(ApexPages.StandardController controller1) {
    
      returnUrl = ApexPages.CurrentPage().getParameters().get('retURL');
        
    }
    
    public CP_OFAC(ApexPages.StandardSetController controller) {
        
        ApexPages.StandardSetController setController = controller;
        setBuyId = new set<Id>();
        
        for(Loan__c loan1 : (List<loan__c>) setController.getSelected())
        {
            setBuyId.add(loan1.Id);
        }
        
        if(setbuyid.size() > 0){
        
        lstloan = [Select id, name,Borrower_Name__c, OFAC_Check__c,Terminus_Effective_Date__c from Loan__c where id in: setBuyId];
        
        returnUrl = ApexPages.CurrentPage().getParameters().get('retURL');
        }else
        {
        lid = string.valueOf(ApexPages.currentPage().getParameters().get('id'));
        lstloan = [Select id, name,Borrower_Name__c, OFAC_Check__c,Terminus_Effective_Date__c from Loan__c  where id =: lid];
        
        returnUrl = '/' + lid;
        }
    }
    
    Public void Getresults(){
    
    If(lstLoan != null && lstLoan.size() >0){
     
     List<loan__c> updloan = new List<Loan__c>(); 
      
        for(loan__c loan : lstLoan){
        
            If(loan.Borrower_Name__c != null && loan.Borrower_Name__c != '') {
                        
                        string borrowername = loan.Borrower_Name__c.trim();
                        
                        
                        
                        string endpointUrl = label.OFACKey;
                        endpointUrl = endpointUrl.replace('Borrower_Name__c', borrowername);
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
                                
                                    If ((parser.getCurrentToken() == JSONToken.FIELD_NAME)&& parser.gettext() == 'total'){
                                   
                                    parser.nextToken();
                                     loan.OFAC_Check__c = decimal.valueof(parser.gettext());
        
                                    }
                                    
                                    
                         ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'OFAC Processed Successfully for Loan ' + Loan.name));
                        }
                }else{
                        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.warning, 'Borrower Name Missing in Loan ' + Loan.name));
                }
                    updloan.add(loan);
                
                }
                
                update updloan;
                }
    }
Public pagereference BackToList(){

return new PageReference(returnUrl);

}

Public string httpresponse(){
string setresponse =  '{'+  
  '"total":0,'+
  '"offset":0,'+
  '"sources_used":['+  
    '{'+  
      '"source":"Unverified List (UVL) - Bureau of Industry and Security",'+
      '"source_last_updated":"2015-11-22T07:46:50+00:00",'+
      '"last_imported":"2016-02-02T07:03:04+00:00"'+
    '}'+
  '],'+
  '"search_performed_at":"2016-02-02T07:57:04+00:00",'+
  '"results":['+  
  ']'+
'}';
 return setresponse;
}

}