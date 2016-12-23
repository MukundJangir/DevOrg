trigger OpportunityTrigger on Opportunity (before insert, after insert, before update) {

    Opportunity opt = Trigger.new[0];
   
      if(Trigger.isInsert && Trigger.isBefore){
          Account acc = [select id,Reservation_Available__c,OwnerId,Old_Owner_Id__c,Opportunity_Count__c  from Account where id =: opt.AccountId];
          System.debug('acc.Reservation_Available__c='+acc.Reservation_Available__c);

          if(acc.Reservation_Available__c == 'FREE' && acc.Opportunity_Count__c == 0){
              acc.Old_Owner_Id__c = acc.OwnerId;
              acc.OwnerId = opt.OwnerId;
              System.debug('acc.Old_Owner_Id__c ='+acc.Old_Owner_Id__c );
              System.debug('acc.OwnerId='+acc.OwnerId);
              List<Prolongation_Period_CS__c> ProCS= Prolongation_Period_CS__c.getall().values();
              System.debug('ProCS='+ProCS);
              System.debug('Prolong_Period__c='+ProCS[0].Prolong_Period__c);
              
              Integer period =  Integer.valueOf(1*ProCS[0].Prolong_Period__c);

              //Integer period  = 1;
              opt.Reservation_Period__c = Date.today()+period ;
              opt.Reservation_Flag__c = true;
              Date dToday = opt.Reservation_Period__c;  
              Datetime dt = datetime.newInstance(dToday.year(), dToday.month(),dToday.day());
             // DateTime d = Date.Today() ;
              String dateStr =  dt.format('MM/dd/yyyy') ;
              if(opt.CloseDate != opt.Reservation_Period__c) {
                  //opt.CloseDate = opt.Reservation_Period__c;
                  Trigger.new[0].CloseDate.addError('Please enter close date as '+dateStr );    
              }
             // opt.CloseDate = opt.Reservation_Period__c;
              update acc;
              
          }
          
          
      }
      if(Trigger.isUpdate && Trigger.isBefore){
       Opportunity oldOpt = Trigger.old[0];
       
       system.debug('------Mukund---------------'+Trigger.new[0].RecordTypeId);
       system.debug('------Mukund---------------'+Trigger.new[0].RecordType.DeveloperName);

      If(opt.Reservation_Flag__c == true && opt.Reservation_Period__c != oldOpt.Reservation_Period__c){
          opt.CloseDate = opt.Reservation_Period__c;
      }
  
        if(opt.Time_Based_WF_Run__c == true && opt.Reservation_Flag__c == true){
          
              List<Opportunity> opptyList = [select id, OwnerId,StageName from Opportunity where OwnerId =:opt.OwnerId ];
              System.debug('opptyList ='+opptyList );
              Account acc = [select id,Reservation_Available__c,OwnerId,Old_Owner_Id__c from Account where id =: opt.AccountId];
              System.debug('After insert acc.Old_Owner_Id__c ='+acc.Old_Owner_Id__c );
              acc.OwnerId = acc.Old_Owner_Id__c;
              acc.Old_Owner_Id__c = '';
              //opt.StageName = 'Closed Lost';
              update acc;
              
              for(Opportunity oppty:opptyList ){
                  oppty.StageName = 'Closed Lost';
              
              }
              update opptyList ;
          }
          
          if(opt.Time_Based_WF_Run__c == false && opt.StageName == 'Closed Lost' && opt.Reservation_Flag__c == true){
              List<Opportunity> opptyList = [select id, OwnerId,StageName from Opportunity where OwnerId =:opt.OwnerId and id !=:opt.Id];
              Account acc = [select id,Reservation_Available__c,OwnerId,Old_Owner_Id__c from Account where id =: opt.AccountId];
              System.debug('After insert acc.Old_Owner_Id__c ='+acc.Old_Owner_Id__c );
              acc.OwnerId = acc.Old_Owner_Id__c;
              acc.Old_Owner_Id__c = '';
              //opt.StageName = 'Closed Lost';
              update acc;
              
              for(Opportunity oppty:opptyList ){
                  oppty.StageName = 'Closed Lost';
              
              }
              update opptyList ;


          }
          
      }
      
      if(Trigger.isInsert && Trigger.isAfter){
          Account acc = [select id,Reservation_Available__c,OwnerId,Old_Owner_Id__c from Account where id =: opt.AccountId];
          System.debug('After insert acc.Old_Owner_Id__c ='+acc.Old_Owner_Id__c );
      }
      
if(Trigger.isInsert && Trigger.isBefore || Trigger.isUpdate && Trigger.isBefore){
    Map<String, Id> bhc_MapRecTypes = new Map<String, Id>();
    List<Opportunity> optyList = Trigger.new;
    
    List<Profile> PROFILE = [SELECT Id, Name FROM Profile WHERE Id=:userinfo.getProfileId() LIMIT 1];
    String MyProflieName = PROFILE[0].Name;
    
         List<RecordType> rectypes = [Select DeveloperName, Id From RecordType where sObjectType='Opportunity' and isActive=true];
            for(RecordType recType : rectypes) 
               bhc_MapRecTypes.put(recType.DeveloperName, recType.Id);
    
     Map<id,id> optyAccMap = new Map<id,id>();
     
      for(Opportunity opty:optyList){
     
        
         optyAccMap.put(opty.AccountId,opty.Id);
     }
     Map<id,String> optyUserMap = new Map<id,String>();
   
     
     for(Account acc:[select id, OwnerId, Owner.Profile.Name from Account where id IN :optyAccMap.keySet()]){
         optyUserMap.put(optyAccMap.get(acc.id),acc.Owner.Profile.Name);
         
         system.debug('Optyy Id='+optyAccMap.get(acc.id)+' ::Profile Name='+acc.Owner.Profile.Name);
     }
     
   
     
     for(Opportunity opty:optyList){
        system.debug('Opttry Profile ='+MyProflieName);
        system.debug('Acc Owner Profile ='+optyUserMap.get(opty.id));
        if(MyProflieName == 'BAG Agent'){
         
             if(optyUserMap.get(opty.id) == 'BAG Agent'){
                 opty.RecordTypeId = bhc_MapRecTypes.get('BAG_Sales_process');
             }else if(optyUserMap.get(opty.id) == 'Direct Sales Agent'){
                 opty.RecordTypeId = bhc_MapRecTypes.get('Direct_Sales_Process');
             }
             
         }
     }
   }
    

}