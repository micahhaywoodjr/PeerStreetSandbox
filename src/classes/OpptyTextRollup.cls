public with sharing class OpptyTextRollup {
    public void UpdateFields(List<Opportunity> newList) {
        
        Map<id,List<Opportunity>> mapParentIDAndChild = new Map<id,List<Opportunity>>();
        boolean flag;
        set<Id> parenetTrue = new set<Id>();
        set<Id> InvestAcctId=new set<Id>();
        for(Opportunity objChild : newList) {
            if(objChild.Positions__c !=null){
            parenetTrue.add(objChild.Positions__c);
            InvestAcctId.add(objChild.Investment_Account__c);}
        }
        for(Opportunity objChild : [select id , StageName ,Type, Positions__c,Parent_Loan_Status__c from Opportunity where Positions__c IN: parenetTrue] ){
           
            if(mapParentIDAndChild.containsKey(objChild.Positions__c)) {
               
                mapParentIDAndChild.get(objChild.Positions__c).add(objChild);
               
            } else {
                
                mapParentIDAndChild.put(objChild.Positions__c,new List<Opportunity>{objChild});
                
            }
        }
        
        
        if(parenetTrue.size() >0)
        {
            List<Positions__c> updateList = new List<Positions__c>();
            for(Id objId : mapParentIDAndChild.keySet()) {
                flag = true;
                for(Opportunity objChild : mapParentIDAndChild.get(objId)) {
                    System.debug('objChild==>'+objChild);
                    if(objChild.StageName != 'Canceled' || objChild.Type != 'Pledge'){
                        flag = false;
                        System.debug('objChild==>'+flag);
                        break;
                    }
                    
                }
                if(flag == true) {
                    updateList.add(new Positions__c(Id = objId , Status__c = 'Canceled'));
                    
                } else {
                    
                    updateList.add(new Positions__c(Id = objId , Status__c = null)); 
                }
            }
            // Database update
            if(!updateList.isEmpty()) {
                update updateList;
            }
        
        
                Map<string,string> mpGetPosStatus=new Map<string,string>();
                mpGetPosStatus.put('pledgecompletedpaid_off','paid_off');
                mpGetPosStatus.put('pledgecompletedactive','active');
                mpGetPosStatus.put('pledgepending','pending');
                mpGetPosStatus.put('pledgeinitiated','pending');
                
                Map<Id,Set<string>> mpStatus=new Map<Id,set<String>>();
                for(Opportunity objChild : [select id , StageName ,Type,Investment_Account__c, Positions__c,Parent_Loan_Status__c from Opportunity where Positions__c IN: parenetTrue] )
                { 
                    if (!mpStatus.containskey(objChild.Positions__c))
                        
                        mpStatus.put(objChild.Positions__c,new Set<string>());
                    
                    if(objChild.Type !=null && objChild.StageName !=null)
                    {
                        if((string.valueOf(objChild.Type).toLowercase()+string.valueOf(objChild.StageName).toLowercase()=='pledgepending') || (string.valueOf(objChild.Type).toLowercase()+string.valueOf(objChild.StageName).toLowercase()=='pledgeinitiated'))
                        {
                            mpStatus.get(objChild.Positions__c).add(string.valueOf(objChild.Type).toLowercase()+string.valueOf(objChild.StageName).toLowercase());
                        }
                    }
                    if(objChild.Parent_Loan_Status__c !=null &&  objChild.Type !=null && objChild.StageName !=null && (string.valueof(objChild.Parent_Loan_Status__c).toLowercase() =='paid_off' || string.valueof(objChild.Parent_Loan_Status__c).toLowercase()=='active'))
                    {
                        mpStatus.get(objChild.Positions__c).add(string.valueOf(objChild.Type).toLowercase()+string.valueOf(objChild.StageName).toLowercase()+string.valueOf(objChild.Parent_Loan_Status__c).toLowercase());
                    }
                    
                    
                }
                System.debug('mpStatus==>'+mpStatus);
                List<Positions__c> stupdateList = new List<Positions__c>();
                Map<Id,Positions__c> mpPositions=new Map<Id,Positions__c>();
                for(Opportunity obj :newlist)
                {
                    if(obj.Positions__c !=null)
                    {
                        for(String str :mpGetPosStatus.keySet())
                        {
                            if(mpStatus.get(obj.Positions__c).contains(str))
                            {
                               mpPositions.put(obj.Positions__c, new Positions__c(Id = obj.Positions__c , Status__c = mpGetPosStatus.get(str)));
                            }
                        }
               	   }
                }
                system.debug('mpPositions==>'+mpPositions.values());
                if(!mpPositions.values().isEmpty()) 
                {
                    update mpPositions.values();
                }
        }
        
    }// end of UpdateFields
}// end of childTriggerHandler