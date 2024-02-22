@isTest
public class Test_ScheduleBactchOfInactiveUser {
    @isTest
    public static void testScheduledBatch() {
        // Setup test data if needed

        // Schedule the job
        String cronExp = '0 0 0 ? * *'; // Example: Run daily at midnight
        Test.startTest();
        System.schedule('TestMyBatchSchedulerJob', cronExp, new ScheduleBactchOfInactiveUser());
        Test.stopTest();

        // Add assertions or queries to verify the expected behavior
        // For example, you can check if the batch job ran successfully
        // and verify the results in the database
        // You may need to query the AsyncApexJob object to get job details

        List<AsyncApexJob> jobs = [SELECT Id, Status FROM AsyncApexJob WHERE JobType = 'Batch Apex' AND Status = 'Completed'];
        //System.assert(jobs.size() > 0, 'Batch job should have been executed');
    }

}