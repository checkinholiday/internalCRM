@isTest(SeeAllData = true)
public class Test_ChangeInactiveOwnerOfInvoices {
    @isTest static void test() {
       
        // inserting lead record
         list<VLSF_Invoice__c> invoicelist = [select id,ownerid from VLSF_Invoice__c  where owner.isActive = FALSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(VLSF_Invoice__c ld :invoicelist)
        {
            ownerids.add(ld.id);
        }
    	/*list<user> userlist =[select id,name,isactive from user where id IN :ownerids];
    list<user> usrToUpdate = new list<user>();
    For( user usr : userlist)
    {
       usr.isActive = false;
        usrToUpdate.add(usr);
    }
	update usrToUpdate;    */
        Test.startTest();
      
        ChangeInactiveOwnerOfInvoices cr = new ChangeInactiveOwnerOfInvoices();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,invoicelist);
		cr.finish(null);
        Test.stopTest();
        
        
    }

}