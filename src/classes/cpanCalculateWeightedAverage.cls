public class cpanCalculateWeightedAverage {
Public Loan__c ObjLoan{get; set;}
Public List<Selectoption> lststatus{get; set;}
Public List<string> selectedstatus{get; set;}
Public List<Selectoption> lststatus1{get; set;}
Public List<string> selectedstatus1{get; set;}
Public string query {get; set;}
    
    public PageReference CalculateWeight() {
    
        query = 'select id, name, PS_Allocation__c, weight__c from Loan__c where createddate != null';
    
        If(objLoan.Property_Type__c != null && objloan.Property_Type__c!='')
        {
           query += ' and Property_Type__c = \'' +   objLoan.Property_Type__c +'\'';
            system.debug(query);
        }
        
        If(objLoan.Originator__c != null)
        {
            query += ' and Originator__c = \'' +   objLoan.Originator__c +'\'';
            system.debug(query);
        }
        
        If(selectedstatus.size()>0 )
        {
            string inids = '';
            if(selectedstatus.size() == 1 && selectedstatus[0] == '')
            {
            
            }else if(selectedstatus.size() == 1 && selectedstatus[0] != ''){
                query += ' and status__c = \'' +  selectedstatus[0] +'\'' ;
            }else
            {
                for(string st:selectedstatus)
                {
                   inids += '\'' + st + '\',';
                }
                
                query += ' and status__c IN (' +  inids +'\'test\')';
            }
           
            system.debug(query);
        }
 
        If(objloan.Date_of_Note__c != null)
        {
           string date1 = string.valueof(objloan.Date_of_Note__c);
           date1 = formatdate(date1);
          
           query += ' and Initial_Purchase_Date__c >= ' + date1;
            system.debug(query);
        }
        
        If(objloan.Coming_Soon_Date__c != null)
        {
           string date1 = string.valueof(objloan.Coming_Soon_Date__c);
           date1 = formatdate(date1);
          
           query += ' and Initial_Purchase_Date__c <= ' + date1;
            system.debug(query);
        }
        
        If(objloan.PS_Close_Date__c != null)
        {
           string date1 = string.valueof(objloan.PS_Close_Date__c);
           date1 = formatdate(date1);
          
           query += ' and PS_Close_Date__c >= ' + date1;
            system.debug(query);
        }
        
        If(objloan.Date_of_Deed_of_Trust__c != null)
        {
           string date1 = string.valueof(objloan.Date_of_Deed_of_Trust__c);
           date1 = formatdate(date1);
          
           query += ' and PS_Close_Date__c <= ' + date1;
            system.debug(query);
        }
        
        If(objloan.Paid_Off_Date__c != null)
        {
           string date1 = string.valueof(objloan.Paid_Off_Date__c);
           date1 = formatdate(date1);
          
           query += ' and Paid_Off_Date__c >= ' + date1;
            system.debug(query);
        }
        
        If(objloan.Loan_Maturity_Date__c != null)
        {
           string date1 = string.valueof(objloan.Loan_Maturity_Date__c);
           date1 = formatdate(date1);
          
           query += ' and Paid_Off_Date__c <= ' + date1;
            system.debug(query);
        }
        
        If(selectedstatus1.size()>0 )
        {
            string inids = '';
            if(selectedstatus1.size() == 1 && selectedstatus1[0] == '')
            {
            
            }else if(selectedstatus1.size() == 1 && selectedstatus1[0] != ''){
                query += ' and State__c = \'' +  selectedstatus1[0] +'\'' ;
            }else
            {
                for(string st:selectedstatus1)
                {
                   inids += '\'' + st + '\',';
                }
                
                query += ' and State__c IN (' +  inids +'\'test\')';
            }
           
            system.debug(query);
        }
        
        If(objloan.PS_ID__c != null && objloan.PS_ID__c != '' )
        {
           string PSID = objloan.PS_ID__c;
           PSID = PSID.replace(',','\',\'');
           query += ' and PS_ID__c Not IN (\'' + PSID + '\')';
            system.debug(query);
        }
        
        List<loan__c> lstLoan = Database.query(query);
        query += ' Row count is :' + lstloan.size();
        String uniquekey = uniquekey();
        double totalWeight = 0;
        If(lstLoan.size() > 0){
        
            for(loan__c ln: lstloan)
            {
                 if(ln.PS_Allocation__c != null)
                {
                    totalWeight = totalweight + ln.PS_allocation__c;
                }
            }
        
                
            for(loan__c l : lstLoan)
            {
                if(l.PS_Allocation__c != null && totalWeight != 0)
                {
                    l.weight__c = l.PS_Allocation__c/totalWeight;
                }else
                {
                l.weight__c = 0.00;
                }
                l.Unique_Report_ID__c = uniquekey;
            }
            
            update lstLoan;
        }else
        {
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'No Records Found With Selected Criteria'));
        return null;
        }
       
        
        //system.debug('DC is here ' + lstLoan);
        Pagereference p = new pagereference('/' + Label.Weighted_Report_ID + '?pv0='+uniquekey);
        p.setRedirect(true);
        return p;
        //return null;
    }



    public cpanCalculateWeightedAverage()
    {
        ObjLoan = new Loan__c();
        
        lststatus = new List<SelectOption>();
        selectedstatus = new List<String>();
        lststatus.add(new SelectOption('','None'));
        lststatus.add(new SelectOption('01. PS Evaluating / Need Additional Information','01. PS Evaluating / Need Additional Information'));
        lststatus.add(new SelectOption('02. Meets PS Guidelines','02. Meets PS Guidelines'));
        lststatus.add(new SelectOption('03. In Due Diligence','03. In Due Diligence'));
        lststatus.add(new SelectOption('03b. Passed Due Diligence - Loan Not Yet Funded','03b. Passed Due Diligence - Loan Not Yet Funded'));
        lststatus.add(new SelectOption('04. Coming Soon / Ready for Investment','04. Coming Soon / Ready for Investment'));
        lststatus.add(new SelectOption('05. Currently Available on PS Site','05. Currently Available on PS Site'));
        lststatus.add(new SelectOption('06. Loan Funded - Not Yet Performing','06. Loan Funded - Not Yet Performing'));
        lststatus.add(new SelectOption('07. Loan Funded - Performing','07. Loan Funded - Performing'));
        lststatus.add(new SelectOption('08. Loan Funded - Extension Period','08. Loan Funded - Extension Period'));
        lststatus.add(new SelectOption('09. Loan Closed - Matured','09. Loan Closed - Matured'));
        lststatus.add(new SelectOption('10. Loan Closed - Paid Off','10. Loan Closed - Paid Off'));
        lststatus.add(new SelectOption('11. PS Rejected','11. PS Rejected'));
        lststatus.add(new SelectOption('12. Lender Rejected','12. Lender Rejected'));
        lststatus.add(new SelectOption('13. Removed Due to Lack of Investor Interest','13. Removed Due to Lack of Investor Interest'));
        lststatus.add(new SelectOption('14. PS Special Situation (Not Included)','14. PS Special Situation (Not Included)'));
        
        lststatus1 = new List<SelectOption>();
        selectedstatus1 = new List<String>();
        lststatus1.add(new SelectOption('','--None--'));
        lststatus1.add(new SelectOption('AL','AL'));
        lststatus1.add(new SelectOption('AK','AK'));
        lststatus1.add(new SelectOption('AZ','AZ'));
        lststatus1.add(new SelectOption('AR','AR'));
        lststatus1.add(new SelectOption('CA','CA'));
        lststatus1.add(new SelectOption('CO','CO'));
        lststatus1.add(new SelectOption('CT','CT'));
        lststatus1.add(new SelectOption('DE','DE'));
        lststatus1.add(new SelectOption('FL','FL'));
        lststatus1.add(new SelectOption('GA','GA'));
        lststatus1.add(new SelectOption('HI','HI'));
        lststatus1.add(new SelectOption('ID','ID'));
        lststatus1.add(new SelectOption('IL','IL'));
        lststatus1.add(new SelectOption('IN','IN'));
        lststatus1.add(new SelectOption('IA','IA'));
        lststatus1.add(new SelectOption('KS','KS'));
        lststatus1.add(new SelectOption('KY','KY'));
        lststatus1.add(new SelectOption('LA','LA'));
        lststatus1.add(new SelectOption('ME','ME'));
        lststatus1.add(new SelectOption('MD','MD'));
        lststatus1.add(new SelectOption('MA','MA'));
        lststatus1.add(new SelectOption('MI','MI'));
        lststatus1.add(new SelectOption('MN','MN'));
        lststatus1.add(new SelectOption('MS','MS'));
        lststatus1.add(new SelectOption('MO','MO'));
        lststatus1.add(new SelectOption('MT','MT'));
        lststatus1.add(new SelectOption('NE','NE'));
        lststatus1.add(new SelectOption('NV','NV'));
        lststatus1.add(new SelectOption('NH','NH'));
        lststatus1.add(new SelectOption('NJ','NJ'));
        lststatus1.add(new SelectOption('NM','NM'));
        lststatus1.add(new SelectOption('NY','NY'));
        lststatus1.add(new SelectOption('NC','NC'));
        lststatus1.add(new SelectOption('ND','ND'));
        lststatus1.add(new SelectOption('OH','OH'));
        lststatus1.add(new SelectOption('OK','OK'));
        lststatus1.add(new SelectOption('OR','OR'));
        lststatus1.add(new SelectOption('PA','PA'));
        lststatus1.add(new SelectOption('RI','RI'));
        lststatus1.add(new SelectOption('SC','SC'));
        lststatus1.add(new SelectOption('SD','SD'));
        lststatus1.add(new SelectOption('TN','TN'));
        lststatus1.add(new SelectOption('TX','TX'));
        lststatus1.add(new SelectOption('UT','UT'));
        lststatus1.add(new SelectOption('VT','VT'));
        lststatus1.add(new SelectOption('VA','VA'));
        lststatus1.add(new SelectOption('WA','WA'));
        lststatus1.add(new SelectOption('WV','WV'));
        lststatus1.add(new SelectOption('WI','WI'));
        lststatus1.add(new SelectOption('WY','WY'));
    }
    
    Public string uniquekey(){

    String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
    Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
    String hexDigest = EncodingUtil.convertToHex(hash);
    return hexdigest;
    
    }
    
    Public String formatdate(string date1)
    {
        date1 = date1.replace('00:00:00', '');
        date1 = date1.trim();
        return date1;
    }


}