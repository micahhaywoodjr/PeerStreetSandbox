public class OpptyHelper {
    public static Integer runTest=0;
    public static void positionCreate(List<Opportunity> lstOppty)
    {
        Set<Id> stInvestAcctId=new Set<Id>();
        Set<Id> stSeriesId=new Set<Id>();
        Map<String,Opportunity> mpOppty=new Map<String,Opportunity>();
        Map<String,Positions__c> mpPos=new Map<String,Positions__c>();
        
        
        
        
        for(Opportunity o:lstOppty)
        {
            if(o.Loan__c !=null)
            {
                stSeriesId.add(o.Loan__c);
            }
            
            stInvestAcctId.add(o.Investment_Account__c);
            mpOppty.put(string.valueof(o.Investment_Account__c)+string.valueOf(o.Loan__c), o);
            
        }
    system.debug('stSeriesId==>'+stSeriesId);
        if(stSeriesId.size()>0){
            List<Positions__c> lstChkPos=[SELECT ID,Investment_Account__c,Series__c FROM Positions__c WHERE Series__c IN :stSeriesId AND Investment_Account__c IN :stInvestAcctId];
            for(Positions__C pos:lstChkPos)
            {
                mpPos.put(string.valueof(pos.Investment_Account__c)+string.valueof(pos.Series__c), pos);
            }
            
            List<Positions__c> lstPosupdate=new List<Positions__c>();
            for(string st:mpOppty.keySet())
            {
                if(mppos.containsKey(st))
                {
                    mpOppty.get(st).Positions__c=mppos.get(st).Id;
                }
                else
                {
                    Positions__c pos=new Positions__C();
                    pos.Name='POS -'+' '+String.valueOf(Math.round(Math.random()*1000));
                    pos.Investment_Account__c=mpoppty.get(st).Investment_Account__c;
                    pos.series__C=mpoppty.get(st).Loan__c;
                    lstPosupdate.add(pos);
                    
                }
            }
            if(!lstPosupdate.isEmpty()){
                insert lstPosupdate;}
            
            for(Positions__c ps:lstPosupdate)
            {
                mpoppty.get(string.valueof(ps.Investment_Account__c)+string.valueof(ps.Series__c)).positions__c=ps.Id;
            }
        }
        
   
    }
    public static void getRollup(List<Opportunity> lstOppty)
    {
        Set<Decimal> stAmount=new Set<Decimal>();
        for(Opportunity o:lstOppty)
        {
            if(o.Amount !=null)
            {
                stAmount.add(o.Amount);
            }
            
            
        }
        
        Set<Id> stPosId=new Set<Id>();
        for(Opportunity op:lstOppty)
        {
            if(op.Positions__c !=null)
            {
                stPosId.add(op.Positions__c);
            }
        }
        
        if(stPosId.size() > 0){
         // Amount SUM Updated in to position object
        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsP = 
            new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount','Cash_Completed_Pledge_Amount__c')};
                
                list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsInterest = 
                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Interest_Distributions__c')
                    };
                        
                        list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPP = 
                        new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Principal_Payments__c')
                            };
                                
                                list<RollUpSummaryUtility.fieldDefinition> fieldDefinitionsPI = 
                                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Promotional_Interest_Distributions__c')
                                    };
                                        
                                        if(stAmount.size() >0){                           
         RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsP, lstOppty, 
                                                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Pledge\' and StageName=\'Completed\'');
       
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsInterest, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Interest\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPP, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Principal\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fieldDefinitionsPI, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'PromotionalInterest\' and StageName=\'Completed\'');
        
                                        
        //-------------------------------------------------------------------------------------------------------------
        //Record Count
        
        list<RollUpSummaryUtility.fieldDefinition> fdP_Count = 
            new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount','Number_of_Completed_Pledges__c')};
                
                list<RollUpSummaryUtility.fieldDefinition> fdInterest_Count = 
                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Number_Interest_Distributions__c')
                    };
                        
                        list<RollUpSummaryUtility.fieldDefinition> fdPP_Count = 
                        new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Number_Principal_Payments__c')
                            };
                                
                                list<RollUpSummaryUtility.fieldDefinition> fdPI_Count = 
                                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Num_Promotional_Interest_Distributions__c')
                                    };
                                        
                                        
                                        RollUpSummaryUtility.rollUpTrigger(fdP_Count, lstOppty, 
                                                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Pledge\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdInterest_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Interest\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPP_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Principal\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPI_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'PromotionalInterest\' and StageName=\'Completed\'');
                                        }
        //-------------------------------------------------------------------------------------------------------------
        }
       
    }
    
     public static void UpdateDelRollup(List<Opportunity> lstOppty)
    {
        system.debug('lstOppty==>'+lstOppty);
        Set<Id> stPosId=new Set<Id>();
        for(Opportunity op:lstOppty)
        {
            if(op.Positions__c !=null)
            {
                stPosId.add(op.Positions__c);
            }
        }
        if(stPosId.size() > 0){
         list<RollUpSummaryUtility.fieldDefinition> fdP = 
            new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 
                                                                                                     'Cash_Completed_Pledge_Amount__c') 
                };
                    
                    list<RollUpSummaryUtility.fieldDefinition> fdInterest = 
                    new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Interest_Distributions__c')
                        };
                            
                            list<RollUpSummaryUtility.fieldDefinition> fdPP = 
                            new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Principal_Payments__c')
                                };
                                    
                                    list<RollUpSummaryUtility.fieldDefinition> fdPI = 
                                    new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('SUM', 'Amount', 'Cash_Promotional_Interest_Distributions__c')
                                        };
                                            
                                            RollUpSummaryUtility.rollUpTrigger(fdP, lstOppty, 
                                                                               'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Pledge\' and StageName=\'Completed\'');
       
        RollUpSummaryUtility.rollUpTrigger(fdInterest, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Interest\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPP, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Principal\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPI, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'PromotionalInterest\' and StageName=\'Completed\'');
      
        
        //-------------------------------------------------------------------------------------------------------------
        //Record Count
        
        list<RollUpSummaryUtility.fieldDefinition> fdP_Count = 
            new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount','Number_of_Completed_Pledges__c')};
                
                list<RollUpSummaryUtility.fieldDefinition> fdInterest_Count = 
                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Number_Interest_Distributions__c')
                    };
                        
                        list<RollUpSummaryUtility.fieldDefinition> fdPP_Count = 
                        new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Number_Principal_Payments__c')
                            };
                                
                                list<RollUpSummaryUtility.fieldDefinition> fdPI_Count = 
                                new list<RollUpSummaryUtility.fieldDefinition> {new RollUpSummaryUtility.fieldDefinition('COUNT', 'Amount', 'Num_Promotional_Interest_Distributions__c')
                                    };
                                        
                                        
                                        RollUpSummaryUtility.rollUpTrigger(fdP_Count, lstOppty, 
                                                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Pledge\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdInterest_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Interest\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPP_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'Principal\' and StageName=\'Completed\'');
        
        RollUpSummaryUtility.rollUpTrigger(fdPI_Count, lstOppty, 
                                           'Opportunity', 'Positions__c', 'Positions__c', 'and Type = \'PromotionalInterest\' and StageName=\'Completed\'');
        //-------------------------------------------------------------------------------------------------------------
    }
    }

}