public class CP_AddressDetail 
{
    public string response{get;set;}
    
    public void CallAddress()
    {
        GetAddressDetails('300 manhattan beach blvd manhattan beach');
    }
    
    public Loan__c GetAddressDetails(string strAddress)
    {
        Loan__c objLoan = new Loan__c();
        
        if(strAddress != null && strAddress != '')
        {        
            strAddress = strAddress.replace(' ', '%20');
            string endpointUrl = 'https://maps.googleapis.com/maps/api/geocode/xml?address=' + strAddress + '&key=' + Label.GoogleAPIKey;
        
            endpointUrl = endpointUrl.replace(' ','%20');
            HttpRequest req1 = new HttpRequest();
            
            req1.setEndPoint(endpointUrl);
            req1.setMethod('GET');
            req1.setHeader('Content-Type','application/json');
            req1.setHeader('Accept','application/json');
            
            Http http1 = new Http();
            
            //Initializing with test response if calling by test class
            string response1 = TestHttpResponse();
            
            if(!test.isRunningTest())
            {
                HttpResponse res1 = http1.send(req1);
                response1 = res1.getbody();
            }
            System.debug('=======response'+response1);
            
            Dom.Document doc = new Dom.Document();
            doc.load(response1);
            Dom.XMLNode ordDtls = doc.getRootElement();
            
            for(Dom.XMLNode child : ordDtls.getChildElements()) 
            {
                System.debug('NNNN+'+child.getName());
                
                if(child.getName() == 'result')
                {
                    for(Dom.XMLNode comp : child.getChildElements())
                    {
                        System.debug('NCNCN+'+comp.getName());
                        
                        if(comp.getName() == 'address_component')
                        {
                            string fieldName = comp.getChildElement('type', null).getText();
                            system.debug(fieldName); 
                            if(fieldName == 'street_number')
                            {
                                string strStreetNumber = comp.getChildElement('short_name', null).getText();                                
                                objLoan.Address__c = strStreetNumber;                                
                                system.debug('NRAC'+fieldName+'=='+strStreetNumber);                                
                            }   
                            if(fieldName == 'route')
                            {
                                string strStreet = comp.getChildElement('short_name', null).getText();                                
                                objLoan.Address__c += ' ' + strStreet ;                                
                                system.debug('NRAC'+fieldName+'=='+strStreet);                                
                            }
                            if(fieldName == 'locality')
                            {
                                string strCity = comp.getChildElement('short_name', null).getText();                                
                                objLoan.City__c = strCity ;                                
                                system.debug('NRAC'+fieldName+'=='+strCity );                                
                            }
                            if(fieldName == 'administrative_area_level_1')
                            {
                                string strState = comp.getChildElement('short_name', null).getText();                                
                                objLoan.State__c = strState;                                
                                system.debug('NRAC'+fieldName+'=='+strState);                                
                            }
                            if(fieldName == 'postal_code')
                            {
                                string strZipCode = comp.getChildElement('short_name', null).getText();                                
                                objLoan.Zip_Code__c = strZipCode;                                
                                system.debug('NRAC'+fieldName+'=='+strZipCode);                                
                            }
                        }
                    }
                    
                    response = objLoan.Address__c +','+ objLoan.City__c +','+ objLoan.State__c +','+ objLoan.Zip_Code__c;
                    System.debug('NRAC FINAL ADDRESS===' + response);
                }
            }            
        }
        
        return objLoan;       
    }
    
    Public string TestHttpResponse()
    {        
        string testResponseString = '<?xml version="1.0" encoding="UTF-8"?>'+
        '<GeocodeResponse>'+
            '<status>OK</status>'+
            '<result>'+
                '<type>street_address</type>'+
                '<formatted_address>B-21, C Block, Sector 58, Noida, Uttar Pradesh 201301, India</formatted_address>'+
                '<address_component>'+
                    '<short_name>B-21</short_name>'+
                    '<type>premise</type>'+
                '</address_component>'+
                '<address_component>'+
                    '<short_name>Noida</short_name>'+
                    '<type>locality</type>'+
                '</address_component>'+
                '<address_component>'+
                    '<short_name>UP</short_name>'+
                    '<type>administrative_area_level_1</type>'+
                '</address_component>'+
                '<address_component>'+
                    '<short_name>201301</short_name>'+
                    '<type>postal_code</type>'+
                '</address_component>'+
            '</result>'+
        '</GeocodeResponse>';
                                    
        return testResponseString;
    }
}