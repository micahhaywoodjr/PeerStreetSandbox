/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
global class future_Zillow {
	@future (callout=true)
	public static void ZillowValue(List<Id> leadIds) {
		System.debug(LoggingLevel.DEBUG, '***********  future_Zillow.ZillowValue START');
		// declare local vars
		zillow_connection zillow  = new zillow_connection();
		
		//  Make Query
		zillow.identifyHomeValues(leadIds);
		System.debug(LoggingLevel.DEBUG, '***********  future_Zillow.ZillowValue End');
	}
}