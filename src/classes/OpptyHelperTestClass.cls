@isTest
private class OpptyHelperTestClass {
    @isTest static void myTest() {
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
        ln.Fully_Funded_Loan__c = 4578454;
        insert ln;
        
        Series__c sr=new Series__c();
        sr.Loan__c=ln.id;
        sr.Name='srName';
        insert sr;
        
        List<Opportunity> lstop=new List<Opportunity>();
           
        Opportunity op=new Opportunity();
        op.Name='Serieoppty';
        op.CloseDate=Date.today();
        op.Investment_Account__c=inv.id;
        op.Type='Pledge';
        op.StageName='Pending';
        op.Loan__c=sr.Id;
        op.AccountId=ac.Id;
        op.Amount = 500000;
        
        lstop.add(op);
        
        Positions__c pos=new Positions__C();
        pos.Name='POS -'+' '+String.valueOf(Math.round(Math.random()*1000));
        pos.Investment_Account__c=inv.id;
        pos.series__C=sr.id;
        
        
        insert lstop;
        
        OpptyHelper.positionCreate(lstop);
        OpptyHelper.getRollup(lstop);
        OpptyHelper.UpdateDelRollup(lstop);
        
        Test.stopTest();
    }
}