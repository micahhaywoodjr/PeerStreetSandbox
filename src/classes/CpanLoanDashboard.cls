public class CpanLoanDashboard {

id aid {get; set;}
public decimal evaluating {get; set;}
public decimal Qualified {get; set;}
public decimal Duediligence {get; set;}
public decimal Comingsoon {get; set;}
public decimal Closed {get; set;}
public decimal CurrentlyAvailable {get; set;}

public integer evaluatingCount {get; set;}
public integer QualifiedCount {get; set;}
public integer DuediligenceCount {get; set;}
public integer ComingsoonCount {get; set;}
public integer ClosedCount {get; set;}
public integer CurrentlyAvailableCount {get; set;}

public Opportunity OEvaluating {get; set;}
public Opportunity OQualified {get; set;}
public Opportunity ODuediligence {get; set;}
public Opportunity OComingsoon {get; set;}
public Opportunity OClosed {get; set;}
public Opportunity OCurrentlyAvailable {get; set;}


public CpanLoanDashboard(){
    
    evaluating = 0;
    Qualified = 0;
    Duediligence = 0;
    Comingsoon = 0;
    CurrentlyAvailable = 0;
    Closed = 0;
    
    evaluatingCount = 0;
    QualifiedCount = 0;
    DuediligenceCount = 0;
    ComingsoonCount = 0;
    CurrentlyAvailableCount = 0;
    ClosedCount = 0;
    
    OEvaluating = new Opportunity();
    OQualified = new Opportunity();
    ODuediligence = new Opportunity();
    OComingsoon = new Opportunity();
    OCurrentlyAvailable = new Opportunity();
    OClosed = new Opportunity();
    CalculateLoans();

}

Public void CalculateLoans()
{
    
    List<loan__c> lstLoan = [select id, PS_Allocation__c, Initial_Loan_Amount__c, status__c from loan__c order by createddate desc limit 50000];
    If(lstLoan.size() > 0){
        for(loan__c ln: lstLoan)
        {
             if(ln.status__c == '01. PS Evaluating / Need Additional Information' )
            {
                
                if(ln.PS_Allocation__c != null)
                evaluating += ln.PS_Allocation__c;
                evaluatingCount ++;
            }
            
            if((ln.status__c == '02. Meets PS Guidelines'))
            {
                if(ln.PS_Allocation__c != null)
                Qualified += ln.PS_Allocation__c;
                QualifiedCount ++;
            }
            
            if((ln.status__c == '03. In Due Diligence' || ln.status__c == '03b. Passed Due Diligence - Loan Not Yet Funded'))
            {
                if(ln.PS_Allocation__c != null)
                Duediligence += ln.PS_Allocation__c;
                DuediligenceCount ++;
            }
            
            if((ln.status__c == '04. Coming Soon / Ready for Investment'))
            {
                
                if(ln.PS_Allocation__c != null)
                Comingsoon += ln.PS_Allocation__c;
                ComingsoonCount ++;
            }
            
            if((ln.status__c == '05. Currently Available on PS Site' || ln.status__c == '06. Loan Funded - Not Yet Performing'))
            {
                if(ln.PS_Allocation__c != null)
                CurrentlyAvailable += ln.PS_Allocation__c;
                CurrentlyAvailableCount ++;
            }
            
            if((ln.status__c == '07. Loan Closed - Performing' || ln.status__c == '08. Loan Closed - Extension Period' ||
                ln.status__c == '09. Loan Closed - Matured' || ln.status__c == '10. Loan Closed - Paid Off' ))
            {
                if(ln.PS_Allocation__c != null)
                Closed += ln.PS_Allocation__c;
                ClosedCount ++;
            }
            
            
        }
        
        OEvaluating.Amount = Evaluating ;
        OQualified.Amount = Qualified;
        ODuediligence.Amount = Duediligence;
        OComingsoon.Amount = Comingsoon;
        OClosed.Amount = Closed;
        OCurrentlyAvailable.Amount = CurrentlyAvailable;
    
    }
}

}