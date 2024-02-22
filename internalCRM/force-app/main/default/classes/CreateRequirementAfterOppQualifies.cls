public class CreateRequirementAfterOppQualifies {
    public static void createRequirementAfterOppUpdate(list<Opportunity> newopplist)
    {
        list<VLSF_Requirement__c> reqList = new list<VLSF_Requirement__c>();
       
         list<VLSF_Requirement__c> oldReqList = new list<VLSF_Requirement__c>();
        try
        {
                
                For(Opportunity opp:newopplist)
                {
                     VLSF_Requirement__c reqmnt = new VLSF_Requirement__c();
                    User usr =[select id, firstname,lastname from user where id =:opp.OwnerId];
                    Account acc = [select id,Name  from Account where id =:opp.AccountId];
                    String accName = acc.Name;
                    //list<string> AccNameList = accName.split(' ');
                    //system.debug('AccNameList  :'+ AccNameList);
                    string UsrInitials =usr.firstname.substring(0,1)+usr.lastname.substring(0,1);
                    String accInitials;
                     if(accName.length()>=4)
                    {
                    	accInitials =accName.substring(0, 4);
                    }
                    else
                    {
                        accInitials = accName;
                    }
                   // oldReqList=[select id ,VLSF_Opportunity__c from VLSF_Requirement__c where VLSF_Opportunity__c =:opp.id];
                   // system.debug('Old requirement list>>>>>>>>>'+oldReqList);
                    //if((oldop.StageName != Opp.StageName) &&(opp.StageName == 'E - Qualify Opportunity') )
                    //{
                        // reqmnt.Name = 'requirement for '+opp.Name;
                        reqmnt.VLSF_Opportunity__c = opp.Id;
                        reqmnt.VLSF_Client_Name__c = opp.AccountId;   
                        reqmnt.VLSF_Company__c ='none';
                        reqmnt.VLSF_Department__c ='---None---';
                        reqmnt.VLSF_Division__c ='none';
                        reqmnt.VLSF_Requirement_Status__c='Open';
                        reqmnt.VLSF_Location__c = 'pune';
                        reqmnt.VLSF_Pending_With__c = 'Delivery Team';
                    	//reqmnt.VLSF_Minimum_Duration_In_Months__c = opp.Project_duration_in_months__c;
                    	//reqmnt.VLSF_Required_Work_Experience__c = opp.Required_work_experience_in_years__c;
                    	reqmnt.VLSF_Requirement_Recieved_From_BD__c = system.today();
                        if(Opp.Req_BD_Delivery_Id__c != null){
                            reqmnt.VLSF_BD_Delievery_Owner__c = opp.Req_BD_Delivery_Id__c;
                        }
                        if(opp.Req_SharedBy_Id__c != null){
                        	reqmnt.VLSF_Shared_By__c = opp.Req_SharedBy_Id__c;  
                        }
                    
                        DateTime dT = System.today();
                        date  reqdate = date.newinstance(dT.year(), dT.month(), dT.day());
                        String dateString = String.valueOf(reqdate);
                        system.debug('dateString'+ dateString);
                        String ReqCreateDate = dateString.remove('-');
                        system.debug('ReqCreateDate:'+ReqCreateDate);
                        reqmnt.VLSF_No_of_Open_Position__c = opp.VLSF_No_Of_Positions_Open__c;
                        reqmnt.VLSF_Requirement_Code__c = UsrInitials.toUpperCase()+'/'+accInitials+'/'+ReqCreateDate+'/'+opp.ReqmntAutoNumber__c;
                        reqList.add(reqmnt);
                    //--} 
                }
            
            if(reqList.size()>0)
            {
                insert reqList;
                system.debug('Requirement list to insert >>'+reqList);
            }
        }
        catch(Exception e)
        {
            system.debug(' Exception occured >>>>>>>>>'+ e.getMessage()+ 'caused by'+e.getCause());
        }
    }
    
   

    }