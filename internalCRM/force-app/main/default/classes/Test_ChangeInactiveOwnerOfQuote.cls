@isTest(SeeAllData = true)
public class Test_ChangeInactiveOwnerOfQuote {
@isTest static void test() {
       
        // inserting lead record
         list<Quote> qlist = [select id,ownerid from Quote limit 10];
    	set<id> ownerids = new set<id>();
    	for(Quote ld :qlist)
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
      
        ChangeInactiveOwnerOfQuote cr = new ChangeInactiveOwnerOfQuote();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,qlist);
		cr.finish(null);
        Test.stopTest();
        
        
    }
}