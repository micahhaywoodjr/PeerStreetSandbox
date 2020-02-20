trigger LoanDocumentTrigger on Loan_Document__c (Before Insert,Before Update) {
    if(trigger.isBefore)
    {
        for(integer i=0;i<trigger.new.size();i++){
            if((trigger.isInsert || (trigger.isUpdate && trigger.new[i].Liability_Policy_Minimum_Coverage__c != trigger.old[i].Liability_Policy_Minimum_Coverage__c)) && trigger.new[i].Liability_Policy_Minimum_Coverage__c != null && trigger.new[i].Liability_Policy_Minimum_Coverage__c > 0)
            {
                String Temp = ConvertCurrencyToWords.GetCurrencyToWords(String.valueof(trigger.new[i].Liability_Policy_Minimum_Coverage__c));
                trigger.new[i].Liability_Policy_Minimum_Coverage_text__c = Temp.length() > 255 ? Temp.substring(255):Temp; // length of Liability_Policy_Minimum_Coverage_text__c is 255 char, so we put a check so it wont fail
            }
            
            if((trigger.isInsert || (trigger.isUpdate && trigger.new[i].Loan_Amount__c != trigger.old[i].Loan_Amount__c)) && trigger.new[i].Loan_Amount__c != null && trigger.new[i].Loan_Amount__c > 0)
            {
                String Temp = ConvertCurrencyToWords.GetCurrencyToWords(String.valueof(trigger.new[i].Loan_Amount__c));
                trigger.new[i].Loan_Amount_text__c = Temp.length() > 255 ? Temp.substring(255):Temp; // length of Loan_Amount_text__c is 255 char, so we put a check so it wont fail
            }
            
            if((trigger.isInsert || (trigger.isUpdate && trigger.new[i].Fully_Funded_Loan_Amount__c != trigger.old[i].Fully_Funded_Loan_Amount__c)) && trigger.new[i].Fully_Funded_Loan_Amount__c != null && trigger.new[i].Fully_Funded_Loan_Amount__c > 0)
            {
                String Temp = ConvertCurrencyToWords.GetCurrencyToWords(String.valueof(trigger.new[i].Fully_Funded_Loan_Amount__c));
                trigger.new[i].Fully_Funded_Loan_Amount_text__c = Temp.length() > 255 ? Temp.substring(255):Temp; // length of Fully_Funded_Loan_Amount_text__c is 255 char, so we put a check so it wont fail
            }
        }
     }
}