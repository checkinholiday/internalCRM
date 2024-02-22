@isTest(SeeAllData = true)
public class Test_changeInactiveContractOwner {
@isTest static void test() {
       
        // inserting lead record
         list<Contract> Contractlist = [select id,ownerid from Contract where owner.isActive =FALSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(Contract ld :Contractlist)
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
      
        ChangeInactiveOwnerOfContract cr = new ChangeInactiveOwnerOfContract();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,Contractlist);
		cr.finish(null);
        Test.stopTest();
        
        // after the testing stops, assert records were updated properly
       // System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }
}