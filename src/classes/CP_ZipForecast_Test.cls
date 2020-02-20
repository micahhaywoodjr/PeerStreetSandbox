@isTest

Private Class CP_ZipForecast_Test{
    static testMethod void Method1(){
    
        Account acc = new Account(Name='Test Account');
        System.debug(acc);
        Insert acc;
        List<loan__c> insertloan = new List<loan__c>();
        
        Loan__c ln = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90266', Address__c = 'test1', Loan_Maturity_Date__c = system.today().addmonths(2));
        insertloan.add(ln);
        
        Loan__c ln1 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90267', Address__c = 'test10', Loan_Maturity_Date__c = system.today().addmonths(5));
        insertloan.add(ln1);
        
        Loan__c ln2 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90268', Address__c = 'test11', Loan_Maturity_Date__c = system.today().addmonths(8));
        insertloan.add(ln2);
        
        Loan__c ln3 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90269', Address__c = 'test12', Loan_Maturity_Date__c = system.today().addmonths(11));
        insertloan.add(ln3);
        
        Loan__c ln4 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90270', Address__c = 'test13', Loan_Maturity_Date__c =system.today().addmonths(14));
        insertloan.add(ln4);
        Loan__c ln5 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90271', Address__c = 'test14', Loan_Maturity_Date__c = system.today().addmonths(17));
        insertloan.add(ln5);
        Loan__c ln6 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90272',Address__c = 'test15', Loan_Maturity_Date__c = system.today().addmonths(20));
        insertloan.add(ln6);
        Loan__c ln7 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90273',Address__c = 'test16', Loan_Maturity_Date__c = system.today().addmonths(23));
        insertloan.add(ln7);
        Loan__c ln8 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90274',Address__c = 'test17', Loan_Maturity_Date__c = system.today().addmonths(26));
        insertloan.add(ln8);
        Loan__c ln9 = new Loan__c(Is_Address_Changed__c = true,Originator__c = acc.id, zip_code__c = '90275',Address__c = 'test18', Loan_Maturity_Date__c = system.today().addmonths(29));
        insertloan.add(ln9);
        Loan__c ln10 = new Loan__c(Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90276',Address__c = 'test19', Loan_Maturity_Date__c = system.today().addmonths(32));
        insertloan.add(ln10);
        Loan__c ln11 = new Loan__c(Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90277',Address__c = 'test20', Loan_Maturity_Date__c = system.today().addmonths(35));
        insertloan.add(ln11);
        
        insert insertloan;
        
        
        Test.StartTest();

        PageReference pageRef = Page.zipforecast;
        pageRef.getParameters().put('id',ln.id);
        pageRef.getParameters().put('retURL','www.google.com');
        Test.setCurrentPageReference(pageRef);
        ApexPages.StandardSetController StandardsObjectController = new ApexPages.StandardSetController(insertloan);//TestExamples);
        StandardsObjectController.setSelected(insertloan);
        
        Zipforecast gi = new zipforecast(StandardsObjectController);
        gi.getapi();
        gi.BackToList();
        Test.StopTest();

    }
}