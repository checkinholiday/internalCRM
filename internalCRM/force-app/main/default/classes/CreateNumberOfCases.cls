public class CreateNumberOfCases {
    public static void createCasesForOpenPositions(list<opportunity> opplist)
    {
        system.debug('createCasesForOpenPositions:::'+opplist);
        decimal count=0;
        list<case> caselist = new list<case>();
        Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case- WFM- T & M').getRecordTypeId();
        // system.debug('Id::'+caseRecordTypeId);
      // Group wfmqueue = [SELECT Id, Name, DeveloperName, Email, Type FROM Group where Type='Queue' And Name ='VyomLabs_WFM' limit 1];
        list<Case> relatedCaseList =[select id, casenumber,subject,Opportunity__r.id from Case where Opportunity__r.id =:opplist];
       
        //list<Recordtype> TMrecordtypeid =[select id from recordtype where developername ='Case_WFM_T_M' and sobjecttype='Case'];
       
        For(Opportunity opp:opplist)
        {
             if(relatedCaseList.size()< opp.VLSF_No_Of_Positions_Open__c+1)
             {
            system.debug('opportunity '+ opp.name);
            system.debug('containes'+(opp.name.contains('T And M')));
			           
                system.debug(' In if condition for TM case creation');
                count=opp.VLSF_No_Of_Positions_Open__c;
                For(integer itr =0;itr< count; itr++)
                {
                    Case ca = new case();
                    ca.AccountId =opp.AccountId;
                    ca.ContactId=opp.ContactId;
                    ca.Subject='Staff Aug Opportunity  has been created. Please take further step as WFM requires >>>'+opp.Name;
                    ca.Priority='low';
                    ca.Status ='new';
                    ca.Origin ='phone';
                    ca.Opportunity__c=opp.id;
                    //ca.ParentId=opp.id;
                    ca.RecordTypeId=caseRecordTypeId;
                    //ca.OwnerId = wfmqueue.Id;
                    caselist.add(ca);
                    system.debug(' caselist>>>>>'+ caselist);
                }
             }
            
        }
        try
        {
            insert caselist;
        }
        catch(Exception e)
        {
            system.debug(' Exception occured>>>'+ e.getMessage());
        }
    }
    public static void createCaseForProjectcodeCreation(list<Opportunity> oplist)
    {
        Id caseRecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Case - WFM - License').getRecordTypeId();
           //Group wfmqueue = [SELECT Id, Name, DeveloperName, Email, Type FROM Group where Type='Queue' And Name ='VyomLabs_WFM' limit 1];
        
        system.debug('oplist '+ oplist);
        list<case> casetoInsert =new list<case>();
        for(Opportunity op:oplist)
        {
            Case ca = new case();
            ca.AccountId =op.AccountId;
            ca.ContactId=op.ContactId;
            ca.Subject='case for Project code creation >>>'+op.Name;
            ca.Priority='low';
            ca.Status ='new';
            ca.Origin ='phone';
            ca.Opportunity__c=op.id;
           // ca.OwnerId=wfmqueue.id;
            //ca.ParentId=op.id;  
            casetoInsert.add(ca);
        }
        try
        {
            insert casetoInsert;
        }
        catch(Exception e)
        {
            system.debug(' Exception occured while inserting the case>>>'+e.getMessage()+'cause by>>>'+e.getCause());
        }
    }
    
}