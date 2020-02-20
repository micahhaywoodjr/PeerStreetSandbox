@isTest
public class OpptyTextRollupTest {

    @isTest static void testUpdateFields()
    {
        Test.StartTest();
        Runpositioncreation__c rp=new Runpositioncreation__c();
        rp.Name='test';
        rp.IsRunn__c=true;
        insert rp;
        
        Account ac=new Account();
        ac.Name='test';
        insert ac;
        
        Investment_Account__c inv=new Investment_Account__c();
        inv.Name='InvTest';
        insert inv;

        Loan__c ln=new Loan__c();
        ln.Originator__c=ac.id;
        ln.note_status__c='active';
        insert ln;
        
        Series__c sr=new Series__c();
        sr.Loan__c=ln.id;
        sr.Name='srName';
        insert sr;
        
        List<Opportunity> lstop=new List<Opportunity>();
        for(Integer I=0;I<501;I++){     
        Opportunity op=new Opportunity();
        op.Name='Serieoppty';
        op.CloseDate=Date.today();
        op.Investment_Account__c=inv.id;
        op.Type='Pledge';
        op.StageName='Pending';
        op.Loan__c=sr.Id;
        op.AccountId=ac.Id;
            lstop.add(op);
        }
        
        insert lstop;
        
        for(Opportunity ot:lstop)
        {
        	ot.Amount=50;
        	ot.StageName='Completed';
        	
        }
         update lstop;
        
        delete lstop;
        Test.stopTest();
       
      
        
    }
}