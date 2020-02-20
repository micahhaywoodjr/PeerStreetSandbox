@isTest

public class cpanCalculateWeightedAverage_Tracker{

public static testMethod void MyTest1(){

account acc = new account();

acc.name = 'Test Account';
insert acc;

loan__c ln = new loan__c();
ln.originator__c = acc.id;
ln.name = 'test name';
ln.Address__c = 'weighted average';
ln.PS_Allocation__c = 100;
ln.Initial_Loan_Amount__c = 100;
insert ln;

PageReference pageRef = Page.cpanCalculateWeightedAverage; //replace with your VF page name
Test.setCurrentPage(pageRef);

cpanCalculateWeightedAverage cn = new cpanCalculateWeightedAverage();
cn.CalculateWeight();
cn.objLoan.Property_Type__c = 'Commercial';
cn.objLoan.Originator__c = acc.id;
cn.objLoan.Date_of_Note__c = system.today();
cn.objLoan.Coming_Soon_Date__c = system.today();

cn.objLoan.PS_Close_Date__c = system.today();
cn.objLoan.Date_of_Deed_of_Trust__c = system.today();
cn.objLoan.Paid_Off_Date__c = system.today();
cn.objloan.Loan_Maturity_Date__c = system.today();
cn.Selectedstatus1.add('AK');
cn.SelectedStatus.add('01. PS Evaluating / Need Additional Information');
cn.objloan.PS_ID__c = 'test';
cn.CalculateWeight();

cn.Selectedstatus1.add('AK1');
cn.SelectedStatus.add('01. PS Evaluating / Need Additional Information');
cn.Selectedstatus1.add('AK');
cn.SelectedStatus.add('02. Meets PS Guidelines');
cn.CalculateWeight();


}

}