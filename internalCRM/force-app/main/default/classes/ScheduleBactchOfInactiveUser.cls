global class ScheduleBactchOfInactiveUser implements Schedulable {
    global void execute(SchedulableContext sc) {
        
        //execute lead batch
        ChangeRecordOwners leadbatch = new ChangeRecordOwners();
        Database.executeBatch(leadbatch);
        
        //execute Contract batch
        ChangeInactiveOwnerOfContract contractbatch = new ChangeInactiveOwnerOfContract();
        Database.executeBatch(contractbatch);
        
        //execute quote batch
        /*ChangeInactiveOwnerOfQuote quotebatch = new ChangeInactiveOwnerOfQuote();
        Database.executeBatch(quotebatch);*/
        
        //execute invoice batch
        ChangeInactiveOwnerOfInvoices invoicebatch = new ChangeInactiveOwnerOfInvoices();
        Database.executeBatch(invoicebatch);
        
        //execute order batch
        ChangeInactiveOwnerOfOrder orderbatch = new ChangeInactiveOwnerOfOrder();
        Database.executeBatch(orderbatch);
        
        //execute Account batch
        ChangeAccInactiveOwner accbatch = new ChangeAccInactiveOwner();
        Database.executeBatch(accbatch);
        
        //execute Opportunity batch
         ChangeOppOwnerOfInactiveUser oppbatch = new ChangeOppOwnerOfInactiveUser();
         Database.executeBatch(oppbatch);
        
    }
}