/* Copyright 2011 Shimon Rothschild
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/
public class ZillowConfig {
    public static string ZWSID;
    public static final String PROPERTY_SEARCH_URL='http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=' ;
    public static final String DEMOGRAPHICS_URL='http://www.zillow.com/webservice/GetDemographics.htm?zws-id=' ; 
    
    public static void Init() {
       ZillowPp__c appSettings = ZillowPp__c.getInstance();
        if (appSettings != null) {
            ZWSID = appSettings.ZWSID__c;
        }
    }
}