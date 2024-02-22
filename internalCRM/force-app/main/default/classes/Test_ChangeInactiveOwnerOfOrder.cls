@isTest(SeeAllData = true)
public class Test_ChangeInactiveOwnerOfOrder {
    @isTest static void test() {
       
        // inserting lead record
         list<VLSF_Purchase_Order__c> orderlist = [select id,ownerid from VLSF_Purchase_Order__c where owner.isActive = FALSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(VLSF_Purchase_Order__c ld :orderlist)
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
      
        ChangeInactiveOwnerOfOrder cr = new ChangeInactiveOwnerOfOrder();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,orderlist);
		cr.finish(null);
        Test.stopTest();
        
        
    }

}