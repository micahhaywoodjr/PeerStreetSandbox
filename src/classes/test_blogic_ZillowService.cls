/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/ 
@isTest
private class test_blogic_ZillowService {
	private static integer items = 10;
	
    static testMethod void newLeadHasAddress() {
    	list<Lead> leads = new list<Lead>();
        for (integer i =0; i< items; i++) {
        	Lead l = new Lead();
        	l.FirstName = 'first';
        	l.LastName = 'last';
        	l.Company = 'na';
        	l.Street = '12444 Killion St';
        	l.City = 'Valley Village';	
        	l.State = 'CA';
        	l.PostalCode = '91607';
        	leads.add(l);
        }
        system.Test.startTest();
        insert leads;
        system.Test.stopTest();
        list<Lead> rsLead = [SELECT AnnualRevenue, City, Company, IsConverted, ConvertedAccountId, ConvertedContactId, ConvertedDate, ConvertedOpportunityId, Country, CreatedById, CreatedDate, IsDeleted, Description, Email, EmailBouncedDate, EmailBouncedReason, NumberOfEmployees, Fax, FirstName, Name, Home_Value__c, Industry, LastActivityDate, LastModifiedById, LastModifiedDate, LastName, Id, LeadSource, MasterRecordId, MobilePhone, OwnerId, Phone, Rating, Salutation, State, Status, Street, SystemModstamp, Title, IsUnreadByOwner, Website, PostalCode 
        	FROM Lead
        	WHERE Id in: leads]; 
        system.assertEquals(items, rsLead.size());
        system.assertNotEquals(null, rsLead[0].Home_Value__c);
    }
    static testMethod void existingLeadHasAddress() {
		list<Lead> leads = new list<Lead>();
        for (integer i =0; i< items; i++) {
        	Lead l = new Lead();
        	l.FirstName = 'first';
        	l.LastName = 'last';
        	l.Company = 'na';
        	l.Street = '12444 Killion St';
        	l.City = 'Valley Village';	
        	l.State = 'CA';
        	l.PostalCode = '91607';
        	leads.add(l);
        }
        system.Test.startTest();
        insert leads;
        list<Lead> existing =  [SELECT Id, City, Street, State, PostalCode, Home_Value__c FROM Lead where Id in: leads];
        System.assertEquals(leads.size(), existing.size());
        for (integer i =0; i< existing.size(); i++) {
        	existing[i].Street = '12438 Killion St';	
        }
        update existing;
        system.Test.stopTest();
         list<Lead> rsLead = [SELECT AnnualRevenue, City, Company, IsConverted, ConvertedAccountId, ConvertedContactId, ConvertedDate, ConvertedOpportunityId, Country, CreatedById, CreatedDate, IsDeleted, Description, Email, EmailBouncedDate, EmailBouncedReason, NumberOfEmployees, Fax, FirstName, Name, Home_Value__c, Industry, LastActivityDate, LastModifiedById, LastModifiedDate, LastName, Id, LeadSource, MasterRecordId, MobilePhone, OwnerId, Phone,  Rating, Salutation, State, Status, Street, SystemModstamp, Title, IsUnreadByOwner, Website, PostalCode 
        	FROM Lead
        	WHERE Id in: existing]; 
        system.assertEquals(items, rsLead.size());
        system.assertNotEquals(null, rsLead[0].Home_Value__c);
    }
    
    static testMethod void newLeadHasAddressNoZip() {
    	list<Lead> leads = new list<Lead>();
        for (integer i =0; i< items; i++) {
        	Lead l = new Lead();
        	l.FirstName = 'first';
        	l.LastName = 'last';
        	l.Company = 'na';
        	l.Street = '12444 Killion St';
        	l.City = 'Valley Village';	
        	l.State = 'CA';
        	 
        	leads.add(l);
        }
        system.Test.startTest();
        insert leads;
        system.Test.stopTest();
         list<Lead> rsLead = [SELECT AnnualRevenue, City, Company, IsConverted, ConvertedAccountId, ConvertedContactId, ConvertedDate, ConvertedOpportunityId, Country, CreatedById, CreatedDate, IsDeleted, Description, Email, EmailBouncedDate, EmailBouncedReason, NumberOfEmployees, Fax, FirstName, Name, Home_Value__c, Industry, LastActivityDate, LastModifiedById, LastModifiedDate, LastName, Id, LeadSource, MasterRecordId, MobilePhone, OwnerId, Phone, Rating, Salutation, State, Status, Street, SystemModstamp, Title, IsUnreadByOwner, Website, PostalCode 
        	FROM Lead
        	WHERE Id in: leads]; 
        system.assertEquals(items, rsLead.size());
        system.assertNotEquals(null, rsLead[0].Home_Value__c);
    }
   
   static testMethod void existingLeadHasAddressZipRemoved() {
		list<Lead> leads = new list<Lead>();
        for (integer i =0; i< items; i++) {
        	Lead l = new Lead();
        	l.FirstName = 'first';
        	l.LastName = 'last';
        	l.Company = 'na';
        	l.Street = '12444 Killion St';
        	l.City = 'Valley Village';	
        	l.State = 'CA';
        	l.PostalCode = '91607';
        	leads.add(l);
        }
        system.Test.startTest();
        insert leads;
        list<Lead> existing =  [SELECT Id, City, Street, State, PostalCode, Home_Value__c FROM Lead where Id in: leads];
        System.assertEquals(leads.size(), existing.size());
        for (integer i =0; i< existing.size(); i++) {
        	
        	existing[i].PostalCode = '';
        }
        update existing;
        system.Test.stopTest();
         list<Lead> rsLead = [SELECT AnnualRevenue, City, Company, IsConverted, ConvertedAccountId, ConvertedContactId, ConvertedDate, ConvertedOpportunityId, Country, CreatedById, CreatedDate, IsDeleted, Description, Email, EmailBouncedDate, EmailBouncedReason, NumberOfEmployees, Fax, FirstName, Name, Home_Value__c, Industry, LastActivityDate, LastModifiedById, LastModifiedDate, LastName, Id, LeadSource, MasterRecordId, MobilePhone, OwnerId, Phone, Rating, Salutation, State, Status, Street, SystemModstamp, Title, IsUnreadByOwner, Website, PostalCode 
        	FROM Lead
        	WHERE Id in: existing]; 
        system.assertEquals(items, rsLead.size());
        system.assertNotEquals(null, rsLead[0].Home_Value__c);
    }
    
    // testing would not allow street, city or state to be set to '' 
    
    static testMethod void testResult()
    {   
    	httpResponse r = new httpResponse();
    	String s = '<?xml version="1.0" encoding="utf-8"?><SearchResults:searchresults xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.zillow.com/static/xsd/SearchResults.xsd http://www.zillowstatic.com/vstatic/a6c1d644d15b49d0eeba1ea715392fe1/static/xsd/SearchResults.xsd" xmlns:SearchResults="http://www.zillow.com/static/xsd/SearchResults.xsd"><request><address>6106 Preston Crest LN</address><citystatezip>Dallas TX 75230</citystatezip></request><message><text>Request successfully processed</text><code>0</code></message><response><results><result><zpid>26849035</zpid><links><homedetails>http://www.zillow.com/homedetails/6106-Preston-Crest-Ln-Dallas-TX-75230/26849035_zpid/</homedetails><graphsanddata>http://www.zillow.com/homedetails/6106-Preston-Crest-Ln-Dallas-TX-75230/26849035_zpid/#charts-and-data</graphsanddata><mapthishome>http://www.zillow.com/homes/26849035_zpid/</mapthishome><myestimator>http://www.zillow.com/myestimator/Edit.htm?zprop=26849035</myestimator><myzestimator deprecated="true">http://www.zillow.com/myestimator/Edit.htm?zprop=26849035</myzestimator><comparables>http://www.zillow.com/homes/comps/26849035_zpid/</comparables></links><address><street>6106 Preston Crest Ln</street><zipcode>75230</zipcode><city>Dallas</city><state>TX</state><latitude>32.921256</latitude><longitude>-96.801242</longitude></address><zestimate><amount currency="USD">323800</amount><last-updated>11/04/2011</last-updated><oneWeekChange deprecated="true"></oneWeekChange><valueChange duration="30" currency="USD">4700</valueChange><valuationRange><low currency="USD">249326</low><high currency="USD">395036</high></valuationRange><percentile>0</percentile></zestimate><localRealEstate><region id="271495" type="neighborhood" name="North Dallas"><links><overview>http://www.zillow.com/local-info/TX-Dallas/North-Dallas/r_271495/</overview><forSaleByOwner>http://www.zillow.com/homes/fsbo/North-Dallas-Dallas-TX/</forSaleByOwner><forSale>http://www.zillow.com/homes/for_sale/North-Dallas-Dallas-TX/</forSale></links></region></localRealEstate></result></results></response></SearchResults:searchresults>';
    	ZillowTypes.PropertySearchResponse sr = ZillowService.testProcessResponse(s);
    	system.assertNotEquals(null, sr);
    }
    
    static testMethod void testgetZEstimateAmount() {
    	
    	xmldom.element e = new xmldom.Element();
    	e.nodeName = 'amount';
    	e.nodeValue ='323800'; 		
 		ZillowTypes.PropertySearchResponse r = new ZillowTypes.PropertySearchResponse( e ) ;		 
 		Double d = r.getZEstimateAmount();   	
 		system.assertEquals(Double.valueOf( e.nodeValue), d);
    }
}