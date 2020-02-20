global class CP_DailyZipForecastSchedular implements Schedulable {

    global void execute(SchedulableContext SC) 
    {
        CP_DailyZipBatchClass objAddress = new CP_DailyZipBatchClass();
        Database.executeBatch(objAddress, 10);
    }
   
    
}