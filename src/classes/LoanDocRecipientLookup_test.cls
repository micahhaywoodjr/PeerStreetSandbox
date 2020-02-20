@IsTest
 private class LoanDocRecipientLookup_test{  
   static testmethod void initData() {
    String accName = 'Test Micah';
              account acc = new account();
              acc.name = 'test';
       		  acc.DocGen_Account__c = true;
              insert acc;
              
              
              contact con = new contact();
              con.FirstName = 'test';
              con.LastName = 'TestLName';
              con.AccountId = acc.Id;
       		  con.Email = 'micah.haywoodjr@gmail.com';
              insert con;
       
       			string testContact = con.Id;
       			string email = con.email;
              
              Loan_Document__c ld = new Loan_Document__c();
              ld.name = 'Test Micah Says Hi';
        	  ld.Document_Recipient_Contact__c = testContact;
       	      ld.Document_Recipient__c = con.email;
     		  ld.PS_Loan_ID__c = '123456789';

              //ld.Drawloop_Next__c= 'SFLoan_Document__c:a2Xq0000000lkgR;SFContact:;DDPId:a0eq0000004wbsv;Deploy:a0dq0000002XWI1;DeployType:autoemail';
              insert ld;
                    
        	ld = [Select Id,name from Loan_Document__c where Id =:ld.Id];
       			String id = con.id;
       			string key = con.email;
              //Loan_Document__c ld = new Loan_Document__c();
              ld.name = 'Test Micah Says Hi';
        	  ld.Document_Recipient_Contact__c = id;
       	      ld.Document_Recipient__c = con.email;
     		  ld.PS_Loan_ID__c = '123456789';

              //ld.Drawloop_Next__c= 'SFLoan_Document__c:a2Xq0000000lkgR;SFContact:;DDPId:a0eq0000004wbsv;Deploy:a0dq0000002XWI1;DeployType:autoemail';
              update ld;

                    
                    
                    }
        
  }