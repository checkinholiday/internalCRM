@isTest(SeeAllData=true)
public class CreateCasesForTMOpportunityTest {

    @isTest
    public static void testCaseCreation()     
    {
        Account acc = new Account();
        acc.AccountNumber ='2548976476';
        acc.AnnualRevenue = 485796445;
        acc.Name = 'Test Account';
         Opportunity opp = new Opportunity();
        opp.Name ='Cloud360-DxSherpa-_Cloud360_ROW_ITSM_Staff Aug';
        opp.CloseDate = system.today()+10;
        //opp.Standard_Lead__c = ld.Id;
        opp.StageName = 'F - Identify Opportunity';
        opp.VLSF_No_Of_Positions_Open__c = 1;
        opp.Area_of_Interest__c='Software(license)';
        opp.BEENU__c='Backlog';
        opp.Required_work_experience_in_years__c = '0-2';
        
        
        // 
        
        //opp.AccountId = ld.ConvertedAccountId;
        
        //Opportunity opp=[select id, name, stagename from Opportunity where name='Cloud360-DxSherpa-_Cloud360_ROW_ITSM_T And M'];
        test.startTest();
        Insert acc;
        opp.AccountId = acc.Id;
        insert opp;
        opp.StageName ='E - Qualify Opportunity';
        update opp;
        test.stopTest();
    }
    @isTest
    public static void CheckShortAccount()
    {
        User usr = new User();
        usr.Firstname ='Test';
  		usr.LastName  ='test';
        usr.Username ='testusersne@vyomlabs.com';
        usr.email ='testusersne@vyomlabs.com';
        usr.Alias ='tst';
        usr.ProfileId=[select id from Profile where name ='ALL ACCESS SALES_WFM'].id;
        usr.CommunityNickname = 'test12';
        usr.LocaleSidKey = 'en_US';
        usr.TimeZoneSidKey = 'GMT';
        //usr.ProfileID = '00e90000000oyi5';
        usr.LanguageLocaleKey = 'en_US';
        usr.EmailEncodingKey = 'UTF-8';
        
        Account acc = new Account();
        acc.AccountNumber ='2548976476';
        acc.AnnualRevenue = 485796445;
        acc.Name = 'ABC';
         Opportunity opp = new Opportunity();
        opp.Name ='Cloud360_Staff Aug';
        opp.CloseDate = system.today()+10;
        //opp.Standard_Lead__c = ld.Id;
        opp.StageName = 'F - Identify Opportunity';
        opp.VLSF_No_Of_Positions_Open__c = 1;
        opp.Area_of_Interest__c='Software(license)';
        opp.BEENU__c='Backlog';
        opp.Required_work_experience_in_years__c = '0-2';
        Id RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        opp.RecordTypeId =RecordTypeId;
        opp.System_Generated_Extension__c = true;
        
         Opportunity opp1 = new Opportunity();
        opp1.Name ='Cloud360_Staff Aug';
        opp1.CloseDate = system.today()+10;
        //opp.Standard_Lead__c = ld.Id;
        opp1.StageName = 'F - Identify Opportunity';
        opp1.VLSF_No_Of_Positions_Open__c = 1;
        opp1.Area_of_Interest__c='Software(license)';
        opp1.BEENU__c='Backlog';
        opp1.Required_work_experience_in_years__c = '0-2';
        //Id RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        opp1.RecordTypeId =RecordTypeId;
        opp1.System_Generated_Extension__c = False;
        
        
        test.startTest();
        Insert usr;
        Insert acc;
        opp.AccountId = acc.Id;
        opp.OwnerId = usr.Id;
        opp1.AccountId = acc.Id;
        opp1.OwnerId =usr.id;
        insert opp;
        insert  opp1;
        opp.StageName ='E - Qualify Opportunity';
        update opp;
        test.stopTest();
    }
}