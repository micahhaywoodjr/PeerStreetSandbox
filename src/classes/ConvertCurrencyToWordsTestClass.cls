@isTest
private class ConvertCurrencyToWordsTestClass {
    @isTest static void myTest() {
    Account accobj = new Account();
    accobj.name='testAccount';
    insert accobj;
        Loan__c obj = new Loan__c();
        obj.Fully_Funded_Loan__c = 748648.45;
        obj.Originator__c = accobj.id;
        insert obj;
    }
}