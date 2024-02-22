global class ChangeAccInactiveOwner implements Database.Batchable<SObject> {
     public Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext context) {
        
        // Query Leads, Opportunities, Contacts, and Accounts with the old owner being deactivated.
     list<User> inactiveusr =[select id, managerId from User where isActive = FALSE];
        String query = 'SELECT Id, OwnerId FROM Account where OwnerId IN :inactiveusr';
        //query += 'VLSF_Requirement__c,VLSF_Trainee_Resource__c,VLSF_Evolution__c,VLSF_Training_Plan__c,VLSF_Training_Catalogue__c,VLSF_External_Resource__c,VLSF_Employee_Information__c,VLSF_Resource__c,Lead,Account,Contact,Opportunity,VLSF_Purchase_Order__c,Quote,Contract,VLSF_Invoice__c WHERE OwnerId IN (SELECT ManagerID FROM User WHERE Is_Active__c = false)';
        return Database.getQueryLocator(query);
       
    }

    global void execute(Database.BatchableContext context, List<Account> scope) {
        List<Account> recordsToUpdate = new List<Account>();
        list <User> inactiveUser = new list<User>();
        inactiveUser =[select id, managerId from User where isActive = FALSE];
        Map<Id, Id> userToManagerMap = new Map<Id, Id>();
        for (User userRecord : inactiveUser) {
    userToManagerMap.put(userRecord.Id, userRecord.ManagerId);
}
        system.debug('usermanager map-------------'+userToManagerMap);
        for (Account record : scope) {
            string ownrID =record.OwnerId;
            system.debug( 'ownerid string'+ownrID);
            // Check if the NewOwnerId__c field has a value (the new owner).
            //if (userToManagerMap.containsKey(ownrID)) {
                // Update the OwnerId with the new owner's ID.
                id newowner = userToManagerMap.get(ownrID);
				system.debug (' New Owner ________>'+newowner);
                record.put('OwnerId',newowner );
                recordsToUpdate.add(record);
                recordsProcessed = recordsProcessed + 1;
            
        }
        
        if (!recordsToUpdate.isEmpty()) {
            update recordsToUpdate;
            system.debug ('recordsToUpdate'+recordsToUpdate);
        }
    }

    global void finish(Database.BatchableContext bc) {
        // You can add any cleanup or logging logic here.
        System.debug(recordsProcessed + ' records processed.');
        /*AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];*/
        //System.debug('Job details >>>>>>>>>>>>'+job);
    }
}