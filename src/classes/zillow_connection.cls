/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
public virtual class zillow_connection {
	/* custom exception methods */
   // public class ZillowLimitException extends Exception{}
   
   	/* class attributes */
   // private Map<ID, Lead > leadMap = null;

	/* constructor */
	public zillow_connection() {}
	
	/* main method to get zillow record */	
	public void identifyHomeValues(List <Id> leadIds) {
		System.debug(LoggingLevel.DEBUG, '***********  zillow_connection.identifyHomeValues START');
    	System.debug(LoggingLevel.DEBUG, '***********  received ' + leadIds.size() + ' records to process: ' + leadIds);
    	List<Lead> aLeadList = new List<Lead>();	
    	List<Lead> leads = [SELECT Id, City, Street, State, PostalCode 
    		FROM Lead
    		where Id in: leadIds];
    	System.debug(LoggingLevel.DEBUG, '***********  leads ' + leads.size() + ' leads found: ' + leadIds);	
    	for (Lead aLead: leads) {
    		System.debug(LoggingLevel.DEBUG, '***********  Starting the call to zillow for each lead.');
    		
	    	ZillowService p = new ZillowService();
	    	ZillowTypes.PropertySearchResponse r = null;
	    	try {	 
		    	if ((aLead.PostalCode == null) || (aLead.PostalCode.trim().length() == 0)) {
					r = p.searchZillow( aLead.Street, aLead.City, aLead.State) ;
		    	}
		    	else {
		    		r = p.searchZillow( aLead.Street, aLead.City, aLead.State, aLead.PostalCode) ;
		    	}
		    	if (r != null) {
					aLead.Home_Value__c = r.getZEstimateAmount() ;
					aLeadList.add(aLead) ;
		    	} 		
	    	}
	    	catch (ZillowTypes.ZillowException e) {
	    		//Error in Zillow response - code = 508 Description : null means address  not found
	    		aLead.Home_Value__c = 0;
	    		aLeadList.add(aLead) ;
	    	} 	
    	}
    	if (aLeadList.size() > 0) {
    		upsert aLeadList;
    	}
    	System.debug(LoggingLevel.DEBUG, '***********  zillow_connection.identifyHomeValues END');
	}
}