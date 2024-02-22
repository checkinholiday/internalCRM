@isTest(SeeAllData = true)
public class Test_ChangeAccInactiveOwner {
    @isTest static void test() {
       
        // inserting lead record
         list<Account> acclist = [select id, name,ownerid from Account where name like'%test%' and owner.isActive = FALSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(Account ld :acclist)
        {
            ownerids.add(ld.id);
        }
    	list<user> userlist =[select id,name,isactive from user where id IN :ownerids];
    list<user> usrToUpdate = new list<user>();
    For( user usr : userlist)
    {
       usr.isActive = false;
        usrToUpdate.add(usr);
    }
	update usrToUpdate;    
        Test.startTest();
      
        ChangeAccInactiveOwner cr = new ChangeAccInactiveOwner();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,acclist);
		cr.finish(null);
        Test.stopTest();
        
        // after the testing stops, assert records were updated properly
       // System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }

}