global class CP_AddressFinderBatchClassScheduler implements Schedulable {

    global void execute(SchedulableContext SC) 
    {
        CP_AddressFinderBatchClass objAddress = new CP_AddressFinderBatchClass();
        Database.executeBatch(objAddress, 1);
    }
   
    public void ScheduleThis()
    {
        CP_AddressFinderBatchClassScheduler addr = new CP_AddressFinderBatchClassScheduler();
        
        System.schedule('Job To Fetch Address 1', '0 0 * * * ?', addr);
        System.schedule('Job To Fetch Address 2', '0 10 * * * ?', addr);
        System.schedule('Job To Fetch Address 3', '0 20 * * * ?', addr);
        System.schedule('Job To Fetch Address 4', '0 30 * * * ?', addr);
        System.schedule('Job To Fetch Address 5', '0 40 * * * ?', addr);
        System.schedule('Job To Fetch Address 6', '0 50 * * * ?', addr);
    }
}