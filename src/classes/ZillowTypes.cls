/*  
This code is based on the sample code provided by Salesforce for Zillow Mashup 
http://wiki.developerforce.com/page/Force.com_Zillow_Mashup
*/
public class ZillowTypes {
	
	public static final String CODE_SUCCESS = '0' ;  // success is always indioated by '0'
	
	// NOTE - some response codes are not consistent across API calls so need a new Map for each API call
	public static final Map<String, String> PropertySearchResponseCode = 
					new Map<String, String>{ '0' => 'Success',
											 '1' => 'Service error-there was a server-side error while processing the request',
											 '2' => 'The specified ZWSID parameter was invalid or not specified in the request',
											 '3' => 'Web services are currently unavailable',
											 '4' => 'The API call is currently unavailable',
											 '500' => 'Invalid or missing address parameter',
											 '501' => 'Invalid or missing citystatezip parameter',
											 '502' => 'No results found',
											 '503' => 'Failed to resolve city, state or ZIP code',
											 '504' => 'No coverage for specified area',
											 '505' => 'Timeout' } ;
																		 
	

																		 	
	
	public class PropertySearchResponse {
		
		xmldom.element searchResult ;
		
		public PropertySearchResponse( xmldom.element e){
			searchResult = e ;
		}	
		
		public Double getZEstimateAmount(){
			Double d = Double.valueOf( searchResult.getElementByTagName( 'amount').nodeValue ) ;
			System.debug('%%%%%%%' + d ) ;
			return d ;	
		}	
	}
	
	public class ZillowException extends Exception{
	}
	
}