trigger loanTrigger on Loan__c (before insert , before update) {
if(trigger.isBefore)
     {
        for(integer i=0;i<trigger.new.size();i++){
            if((trigger.isInsert || (trigger.isUpdate && trigger.new[i].Fully_Funded_Loan__c != trigger.old[i].Fully_Funded_Loan__c)) && trigger.new[i].Fully_Funded_Loan__c != null && trigger.new[i].Fully_Funded_Loan__c > 0)
            {
                String Temp = ConvertCurrencyToWords.GetCurrencyToWords(String.valueof(trigger.new[i].Fully_Funded_Loan__c));
                trigger.new[i].Fully_Funded_Loan_Amount_text__c = Temp.length() > 255 ? Temp.substring(255):Temp; // length of Fully_Funded_Loan_Amount_text__c is 255 char, so we put a check so it wont fail
            }
        }
     }
}