/* Copyright 2011 Shimon Rothschild
This code is based on the sample code provided by Salesforce for Zillow Mashup 
http://wiki.developerforce.com/page/Force.com_Zillow_Mashup
This software may be used and modified without restriction with the stipulation that if significant portions
remain unmodified then this copyright notice shall be retained.
*/

global class ZillowService {
	public ZillowService() {
	}

	public  ZillowTypes.PropertySearchResponse searchZillow( String street, String City, String state, String zip ){
				
		return searchZillow( street, city+ ' ' + state + ' ' + zip ) ;
	}
	public ZillowTypes.PropertySearchResponse searchZillow( String street, String City, String state ){
				
		return searchZillow( street, city+ ' ' + state ) ;
	}
	
	
	public ZillowTypes.PropertySearchResponse searchZillow( String address, String citystatezip ){
		ZillowConfig.Init();
		if (ZillowConfig.ZWSID != '') {
			// construct the URL		
			String endpointURL = ZillowConfig.PROPERTY_SEARCH_URL + ZillowConfig.ZWSID + '&address=' + 	EncodingUtil.urlEncode(address, 'UTF-8') + '&citystatezip=' + EncodingUtil.urlEncode(citystatezip, 'UTF-8') ;						
			ZillowTypes.PropertySearchResponse searchResponse = null ;		
			try{			
				HttpResponse response = invokeZillow( 'GET', endpointURL ) ;
				searchResponse = processZillowResponse(response.getBody()); 
			}
			catch( System.Exception e){
				System.debug( 'Error ' +e) ;
				throw e ;
			} 
			
			return searchResponse ;
		}
		else  {
			throw new ZillowTypes.ZillowException( 'No Zillow Web Identification was provided in the configuration.');	
		} 
	}
	
	// Web service call out 
	private HttpResponse invokeZillow( String method, String url ){		 	
	    HttpRequest  req = new HttpRequest();   
		HttpResponse response = null;
		try {
			if( method != 'GET' ){
				throw new ZillowTypes.ZillowException('ZillowService::invokeZillow - only GET supported  '+method +' is not supported') ;
			}	
		   	req.setEndpoint(url); 
		   	req.setMethod(method) ;
			Http http = new Http();
			response = http.send(req);
		}
		catch( System.Exception e){			
				throw new ZillowTypes.ZillowException('Error sending HTTP message - ERROR: '+ e) ;
		}					
		if (response.getStatusCode() != 200) { 
			throw  new ZillowTypes.ZillowException('Error in HTTP Response - STATUS: ' +response.getStatus() + 'STATUS_CODE:'+ response.getStatusCode()) ;	
		}	
		System.debug(LoggingLevel.DEBUG, '***-------------***  ZillowService.HttpResponse invokeZillow response body: '+ response.getBody());
					
	    return response ;
	}
	private ZillowTypes.PropertySearchResponse processZillowResponse(string responseBody) {
		ZillowTypes.PropertySearchResponse searchResponse = null;
		XMLDom responseXML = new XMLDom( responseBody ) ;
		System.debug(LoggingLevel.DEBUG, '***********  processZillowResponse XMLDom: '+ responseBody);	
		String code = responseXML.getElementByTagName('code').nodeValue;
		if( code == ZillowTypes.CODE_SUCCESS){
			searchResponse = new ZillowTypes.PropertySearchResponse( responseXML.getElementByTagName('response') ) ;
		}
		else{
			throw new ZillowTypes.ZillowException( 'Error in Zillow response - code = '+code +' Description : ' +ZillowTypes.PropertySearchResponseCode.get(code) );	
		}
		System.debug(LoggingLevel.DEBUG, '***********  ZillowService.ZillowTypes.PropertySearchResponse processZillowResponse End');
		return searchResponse;
	}
	
	public static ZillowTypes.PropertySearchResponse testProcessResponse(string responseBody) {
		ZillowService z = new ZillowService();
		return z.processZillowResponse(responseBody);
	}
	 
}