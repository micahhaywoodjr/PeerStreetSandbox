trigger LoanDocRecipientLookup on Loan_Document__c (before insert, before update) {
    Map<String, Loan_Document__c> emailToLoanDoc = new Map<String, Loan_Document__c>();
    if (trigger.isInsert) {
        for(integer i=0;i<trigger.new.size();i++){
            if (trigger.new[i].Document_Recipient__c != null) {
                emailToLoanDoc.put(trigger.new[i].Document_Recipient__c, trigger.new[i]);
            }
        }
    } else if (trigger.isUpdate) {
        for(integer i=0;i<trigger.new.size();i++){
            if (trigger.new[i].Document_Recipient__c != null && !trigger.new[i].Document_Recipient__c.equals(trigger.old[i].Document_Recipient__c)) {
                emailToLoanDoc.put(trigger.new[i].Document_Recipient__c, trigger.new[i]);
            }
        }
    } else {
        return;
    }
    
    Set<Id> accountId = new Set<Id>();
    account acc = [SELECT Id FROM Account where DocGen_Account__c = true];
        accountId.add(acc.Id);
    system.debug(accountId + ' Mapping for accountId');

    List<Contact> contacts = [SELECT Id, Email FROM Contact OFFSET where email in :emailToLoanDoc.keySet() and AccountId =: accountId];
    Map<String, String> emailToContactId = new Map<String, String>();
    for (integer i=0; i<contacts.size(); i++) {
        emailToContactId.put(contacts[i].id, contacts[i].email);
    }
    
    for(integer i = 0; i < contacts.size(); i++) {
        String id = contacts[i].id;
        String key = contacts[i].email;
        Loan_Document__c doc = emailToLoanDoc.get(key);
        doc.Document_Recipient_Contact__c = id;
    }
    
}