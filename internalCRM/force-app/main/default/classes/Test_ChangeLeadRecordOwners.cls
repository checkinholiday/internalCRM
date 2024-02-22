@isTest(SeeAllData = true)
public class Test_ChangeLeadRecordOwners {
@isTest static void test() {
       
        // inserting lead record
         list<lead> leadlist = [select id, lastname,ownerid from lead where owner.isActive = FALSE limit 10];
    	set<id> ownerids = new set<id>();
    	for(lead ld :leadlist)
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
	update usrToUpdate; */   
        Test.startTest();
      
        ChangeRecordOwners cr = new ChangeRecordOwners();
        //Id batchId = Database.executeBatch(uca);
		Database.QueryLocator ql = cr.start(null);
    	cr.execute(null,leadlist);
		cr.finish(null);
        Test.stopTest();
        
        // after the testing stops, assert records were updated properly
       // System.assertEquals(10, [select count() from contact where MailingCity = 'New York']);
    }
}