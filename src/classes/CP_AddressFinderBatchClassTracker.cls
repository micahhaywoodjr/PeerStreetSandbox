@isTest
public class CP_AddressFinderBatchClassTracker
{
    static testMethod void TestAddressFinder()
    {
        CreateData();
        
        CP_AddressFinderBatchClass objAddress = new CP_AddressFinderBatchClass();
        Database.executeBatch(objAddress, 15);
        
        CP_DailyZipBatchClass dbzip = new CP_DailyZipBatchClass();
        Database.executeBatch(dbzip, 15);
        
    }
     static testMethod void DailyZipBatch()
    {
       
   
        CP_DailyZipBatchClass dbzip = new CP_DailyZipBatchClass();
        Database.executeBatch(dbzip, 15);
    }
    
    
    private static void CreateData()
    {
        //Creating Account record to create loan record
        Account acc =  new Account();
        
        acc.Name = 'NR';
        acc.Type = 'Originator';
        acc.Account_Status__c = '01. Cold Account';
        acc.Do_They_Sell_Notes__c = 'TBD';
        
        insert acc;
        
        //Craeting Loan Record
      
        
         List<loan__c> insertloan = new List<loan__c>();
         Loan__c ln = new Loan__c(status__c = '07. Loan Funded - Performing', Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90266', City__c = 'city1',Address__c = '1test1', Loan_Maturity_Date__c = system.today().addmonths(2));
        insertloan.add(ln);
        
        Loan__c ln1 = new Loan__c(status__c = '07. Loan Funded - Performing', Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90267', City__c = 'city2', Address__c = '1test10', Loan_Maturity_Date__c = system.today().addmonths(5));
        insertloan.add(ln1);
        
        Loan__c ln2 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90268', City__c = 'city3', Address__c = '1test11', Loan_Maturity_Date__c = system.today().addmonths(8));
        insertloan.add(ln2);
        
        Loan__c ln3 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90269', City__c = 'city4', Address__c = '1test12', Loan_Maturity_Date__c = system.today().addmonths(11));
        insertloan.add(ln3);
        
        Loan__c ln4 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90270', City__c = 'city5', Address__c = '1test13', Loan_Maturity_Date__c =system.today().addmonths(14));
        insertloan.add(ln4);
        Loan__c ln5 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90271', City__c = 'city6',Address__c = '1test14', Loan_Maturity_Date__c = system.today().addmonths(17));
        insertloan.add(ln5);
        Loan__c ln6 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90272', City__c = 'city7',Address__c = '1test15', Loan_Maturity_Date__c = system.today().addmonths(20));
        insertloan.add(ln6);
        Loan__c ln7 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90273', City__c = 'city8',Address__c = '1test16', Loan_Maturity_Date__c = system.today().addmonths(23));
        insertloan.add(ln7);
        Loan__c ln8 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90274',City__c = 'city9',Address__c = '1test17', Loan_Maturity_Date__c = system.today().addmonths(26));
        insertloan.add(ln8);
        Loan__c ln9 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90275',City__c = 'city10',Address__c = '1test18', Loan_Maturity_Date__c = system.today().addmonths(29));
        insertloan.add(ln9);
        Loan__c ln10 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90276',City__c = 'city11',Address__c = '1test19', Loan_Maturity_Date__c = system.today().addmonths(32));
        insertloan.add(ln10);
        Loan__c ln11 = new Loan__c(status__c = '07. Loan Funded - Performing',Is_Address_Changed__c = true, Originator__c = acc.id, zip_code__c = '90277',City__c = 'city12',Address__c = '1test20', Loan_Maturity_Date__c = system.today().addmonths(35));
        insertloan.add(ln11);
        
        insert insertloan;
    }
}