trigger CreateCasesForTMOpportunity on Opportunity (After Insert, After Update) {
    if(trigger.isAfter && trigger.isupdate)
    {
        for(Opportunity opp:trigger.new)
        {
           // String oppName = opp.Name;
           // List<String> res = oppName.split('_', 5);
           // For(String str:res){
          list<case>  caselist=[select id,casenumber, subject from case where Opportunity__c =:opp.id] ;   
            if((opp.EngagementType__c == 'Staff Aug') && (opp.Probability >10)&& (caselist.size()<=0)){
                    //system.debug('str::'+str);
                    CreateNumberOfCases.createCasesForOpenPositions(trigger.new);
                }
            
            if((opp.Probability>10)&&(caselist.size()<=0))
            {
    
                CreateNumberOfCases.createCaseForProjectcodeCreation(trigger.new);
             
            }
        }
        
    }
    
    if(trigger.isAfter && trigger.isInsert)
    {
        for(Opportunity opp:trigger.new)
        {
            Id RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Licenses').getRecordTypeId();

            if((opp.RecordTypeId != RecordTypeId) && (opp.System_Generated_Extension__c == false))
            {
                CreateRequirementAfterOppQualifies.createRequirementAfterOppUpdate(trigger.new); 
            }
            
        }   
    }
    
}