@isTest(SeeAllData = true)
public class Test_ChangeOppOwnerOfInactiveUser {
@isTest static void test() {
       
        // inserting lead record
         list<Opportunity> opplist = [select id,name,ownerid from Opportunity where owner.isActive = FAlSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(Opportunity ld :opplist)
        {
            ownerids.add(ld.id);
        }
    /*	list<user> userlist =[select id,name,isactive from user where id IN :ownerids];
    list<user> usrToUpdate = new list<user>();
    For( user usr : userlist)
    {
       usr.isActive = false;
        usrToUpdate.add(usr);
    }
	update usrToUpdate;    */
        Test.startTest();
      
        ChangeOppOwnerOfInactiveUser cr = new ChangeOppOwnerOfInactiveUser();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,opplist);
		cr.finish(null);
        Test.stopTest();
        
        // after the testing stops, assert records were updated properly
       // System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }
}