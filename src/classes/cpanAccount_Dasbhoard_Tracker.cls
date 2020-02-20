@isTest

Public Class cpanAccount_Dasbhoard_Tracker{

public static testMethod void MyTest1(){
account acc = new account();

acc.name = 'Test Account';
insert acc;
loan__c ln = new loan__c();
ln.originator__c = acc.id;
ln.name = 'test name';
ln.Address__c = 'account Dashboard';
ln.PS_Allocation__c = 100;
ln.Initial_Loan_Amount__c = 100;
insert ln;
PageReference pageRef = Page.cpanAccount_Dashboard;
pageRef.getParameters().put('id', String.valueOf(acc.Id));
Test.setCurrentPage(pageRef);
Apexpages.StandardController stdController = new Apexpages.StandardController(acc); 
cpanAccount_Dasbhoard con = new cpanAccount_Dasbhoard(stdController);
con.calculateLoans();

ln.status__c = '02. Meets PS Guidelines';
update ln;
con.calculateLoans();

ln.status__c = '03. In Due Diligence';
update ln;
con.calculateLoans();

ln.status__c = '04. Coming Soon / Ready for Investment';
update ln;
con.calculateLoans();

ln.status__c = '05. Currently Available on PS Site';
update ln;
con.calculateLoans();

ln.status__c = '07. Loan Closed - Performing';
update ln;
con.calculateLoans();

}

public static testMethod void MyTest2(){

CP_AddressDetail cpan = new CP_AddressDetail();
cpan.CallAddress();

}

public static testMethod void MyTest3(){
account acc = new account();

acc.name = 'Test Account';
insert acc;
loan__c ln = new loan__c();
ln.originator__c = acc.id;
ln.name = 'test name';
ln.Address__c = 'account Dashboard';
ln.PS_Allocation__c = 100;
ln.Initial_Loan_Amount__c = 100;
insert ln;
PageReference pageRef = Page.cpanAccount_Dashboard_ComingSoon;
Test.setCurrentPage(pageRef);
CpanLoanDashboard con = new CpanLoanDashboard();
con.calculateLoans();

ln.status__c = '02. Meets PS Guidelines';
update ln;
con.calculateLoans();

ln.status__c = '03. In Due Diligence';
update ln;
con.calculateLoans();

ln.status__c = '04. Coming Soon / Ready for Investment';
update ln;
con.calculateLoans();

ln.status__c = '05. Currently Available on PS Site';
update ln;
con.calculateLoans();

ln.status__c = '07. Loan Closed - Performing';
update ln;
con.calculateLoans();

}


}