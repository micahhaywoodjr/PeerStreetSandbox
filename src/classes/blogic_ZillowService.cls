/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
public with sharing class blogic_ZillowService {
	public static void InitIncompleteAddress(list<lead> newRecs) {
		System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.InitIncompleteAddress START');
		for (Lead aLead : newRecs) {
		if (((aLead.Street == null) || (aLead.Street.trim().length() == 0)) ||
    			((aLead.City == null) || (aLead.City.trim().length() == 0)) ||
    			((aLead.State == null) || (aLead.State.trim().length() == 0))) {
    			System.debug(LoggingLevel.DEBUG, '***********  Incomplete Address for company: '+ aLead.Company);
    			aLead.Home_Value__c = 0.00;
    		}
		}
    	System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.InitIncompleteAddress START');
	}
		
	public static void HomeValue(list<Lead> oldRecs, list<Lead> newRecs) {
		System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue START');
		 
		List<Id> leadIds = new List<Id>();
		if (oldRecs == null) {
			for (integer cnt=0; cnt < newRecs.size(); cnt++) {
				if (hasAllFields(newRecs[cnt])) { 
					leadIds.add(newRecs[cnt].Id);
				}
			}
		}
		else { // test if an address has changed if old was null then update address, test was already made that new not null
			for (integer cnt=0; cnt < newRecs.size(); cnt++) {
				boolean doZillow = false;	
				System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue Initial doZillow: ' + doZillow);
				if (hasAllFields(newRecs[cnt])) { 
					if (((oldRecs[cnt].Street == null) || (oldRecs[cnt].Street.trim().length() == 0)) || (oldRecs[cnt].Street != newRecs[cnt].Street)) {
						doZillow = true;
					}
					System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue After Street doZillow: ' + doZillow);
				
    				if (doZillow == false) {
    					 
    					if (((oldRecs[cnt].City == null) || (oldRecs[cnt].City.trim().length() == 0)) || (oldRecs[cnt].City != newRecs[cnt].City)) {
							doZillow = true;
						}
    				}	
    				System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue After City doZillow: ' + doZillow);
				
    				if (doZillow == false) {
 	
    					if (((oldRecs[cnt].State == null) || (oldRecs[cnt].State.trim().length() == 0)) || (oldRecs[cnt].State != newRecs[cnt].State)) {
							doZillow = true;
						}
    				}	
    				System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue After State doZillow: ' + doZillow);
				
    				if (doZillow == true) {
						leadIds.add(newRecs[cnt].Id);
					}
				}
				
			}
		}
		 
		if (leadIds.size() > 0) {
			future_Zillow.ZillowValue(leadIds); 
		}
		System.debug(LoggingLevel.DEBUG, '***********  blogic_ZillowService.HomeValue END');
 
	}
	
	private static Boolean hasAllFields(lead aLead) {
		Boolean result = true;
		// don't send incomplete addresses to Zillow
    		if (((aLead.Street == null) || (aLead.Street.trim().length() == 0)) ||
    			((aLead.City == null) || (aLead.City.trim().length() == 0)) ||
    			((aLead.State == null) || (aLead.State.trim().length() == 0))) {
    			System.debug(LoggingLevel.DEBUG, '***********  Incomplete Address for company: '+ aLead.Company);
    			result = false;
    		}
    	return result;
	}
}