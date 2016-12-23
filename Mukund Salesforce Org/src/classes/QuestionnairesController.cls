public class QuestionnairesController{
     /* 
    public List<MobiQuestion__c> questionsList = new List<MobiQuestion__c>();
    public map<MobiQuestion__c,AnsWrapperClass> qaMap{get;set;}
    public string text{get;set;}
    public MobiQuestion__c qObj{get;set;}
    public List<QuestionFeedback__c> qfList;
    public List<QuestionAnswer__c> qaList;
    public map<MobiQuestion__c,MobiAnswer__c> allQAMap{get;set;}
    public boolean isLastQ{get;set;}
    public String objId{get;set;}
    public String formType;
    public String comments{get;set;}
    public String decs{get;set;} 
    public List<MProduct__c> productListMaster{get;set;}
    public List<Accessory__c> accessory;
    public Map<Id,List<Accessory__c>> accessoryMapMaster;
    
     
  public QuestionnairesController(ApexPages.StandardController controller){
    
       // getProductAndAccessory();
    
        String callingObj =  ApexPages.CurrentPage().getParameters().get('callingObj');
        objId = ApexPages.CurrentPage().getParameters().get('objectId');
        if(callingObj  == 'account'){
            formType = 'Hardware Advising';
            getQueAnsMap();
        
        }else if(callingObj  == 'lead'){
            formType = 'Qualify Sales Lead';
            getQueAnsMap();
        
        }
    
       system.debug('formType ='+formType +' ::::objId ='+objId );
        
    }
    
    private void getQueAnsMap(){
         allQAMap = new map<MobiQuestion__c,MobiAnswer__c>();
     //   isFirst = true;
        qObj = new MobiQuestion__c();
        text='Mukund';
         
        qaMap = new map<MobiQuestion__c,AnsWrapperClass>();
        questionsList = [select id,Is_First_Question__c,Is_Last_Question__c,Question_Description__c,Answer_Type__c,Order__c,Radio_Answer__c from MobiQuestion__c where Form_Type__c=:formType and Is_First_Question__c=true];
        system.debug('QuesitonList='+questionsList);
        
        List<MobiAnswer__c> answList = [select id,Answer_Description__c,is_Selected_Answer__c,Question__c from MobiAnswer__c where Question__r.Form_Type__c =:formType  order by Order__c ];
        system.debug('answList ==========='+answList );
        for(MobiQuestion__c quest:questionsList){ 
            AnsWrapperClass ansWrapper = new AnsWrapperClass();
            List<SelectOption> options = new List<SelectOption>();
            List<MobiAnswer__c> ansList = [select id,Answer_Description__c,is_Selected_Answer__c from MobiAnswer__c where Question__c =: quest.id order by Order__c];
            
            for(MobiAnswer__c anLis:ansList){
                options.add(new SelectOption(anLis.id,anLis.Answer_Description__c));
            }
            ansWrapper.answerList = ansList ;
            ansWrapper.optionsList = options;
            
            ansWrapper.isText = false;
            ansWrapper.isCheckBox = false;
            ansWrapper.isRadio = false;
            system.debug('quest.Answer_Type__c = '+quest.Answer_Type__c);
            if(quest.Answer_Type__c == 'Text'){
                ansWrapper.isText = true;
                ansWrapper.mobiAns = new MobiAnswer__c();
            }else if(quest.Answer_Type__c == 'Check Box'){
                ansWrapper.isCheckBox = true;
            }else if(quest.Answer_Type__c == 'Radio Botton'){
                ansWrapper.isRadio = true;
            }
            system.debug('ansWrapper.isText = '+ansWrapper.isText+'::ansWrapper.isCheckBox = '+ansWrapper.isCheckBox+' ::ansWrapper.isRadio = '+ansWrapper.isRadio);
            
            qaMap.put(quest,ansWrapper);
            system.debug('qaMap='+quest.id);
            
            
            
        }
        system.debug('qaMap='+qaMap);
    
    }
    
   
    
    
    public class AnsWrapperClass{
    
        public List<MobiAnswer__c> answerList{get;set;}
        public List<SelectOption> optionsList{get;set;}
        public String selectedAnswer{get;set;}
        public boolean isCheckBox{get;set;}
        public boolean isRadio{get;set;}
        public boolean isText{get;set;}
        public MobiAnswer__c mobiAns{get;set;}        
              
    }
    
    public void getNextQuestion(){
        Id qId;
        Id aId;
      
        for (MobiQuestion__c theKey:qaMap.keySet() )
        {
           
           system.debug('Question Id='+theKey.id);
           qId = theKey.id;
           AnsWrapperClass obj = qaMap.get(theKey);
           
           
           for(MobiAnswer__c ans:obj.answerList){
           
             
               
               if(ans.id == obj.selectedAnswer){
                   
                   allQAMap.put(theKey,ans);
                   
                   aId =  ans.id;
               }
           }
           
        }
        
        qaMap = null;
        qaMap = new map<MobiQuestion__c,AnsWrapperClass>();
        system.debug('Quset Id='+qId+'  AnswerId='+aId);
        
        String queryStr = '';
        MobiQuestion__c mobiQuTemp = [select id,Is_First_Question__c,Is_Last_Question__c,Question_Description__c,Answer_Type__c,Order__c,Radio_Answer__c,PrevMobiAnswer__c  from MobiQuestion__c where Form_Type__c=:formType  and (PrevMobiQuestion__c=:qId or PreMobiQuestionTwo__c=:qId)limit 1];
        system.debug('Before condition*******');
        MobiQuestion__c mobiQu;
        if(mobiQuTemp.PrevMobiAnswer__c != null){
            system.debug('Inside conditions************'+mobiQuTemp.PrevMobiAnswer__c);
            mobiQu = [select id,Question_Description__c,Answer_Type__c,Order__c,Radio_Answer__c,Is_First_Question__c,Is_Last_Question__c,PrevMobiAnswer__c from MobiQuestion__c where Form_Type__c=:formType and ((PrevMobiQuestion__c=:qId and PrevMobiAnswer__c =:aId) or (PreMobiQuestionTwo__c=:qId and PreMobiAnswerTwo__c=:aId)) limit 1];
        
        }else{ 
            mobiQu = mobiQuTemp;
        }
        
        //mobiQu = [select id,Question_Description__c,Answer_Type__c,Order__c,Radio_Answer__c,Is_Last_Question__c from MobiQuestion__c where Form_Type__c='Hardware Advising' and PrevMobiQuestion__c=:qId and PrevMobiAnswer__c =:aId limit 1];
        isLastQ = mobiQu.Is_Last_Question__c;
        system.debug('Previous Q Id='+mobiQu.Question_Description__c);
        
        
         List<MobiAnswer__c> ansList = [select id,Answer_Description__c,is_Selected_Answer__c from MobiAnswer__c where Question__c =: mobiQu.id order by Order__c];
             AnsWrapperClass ansWrObj = new AnsWrapperClass();
            system.debug('ansList=+_+_+_+_+_+__+_+_+'+ansList);
            ansWrObj.answerList = ansList ;
            
            ansWrObj.isText = false;
            ansWrObj.isCheckBox = false;
            ansWrObj.isRadio = false;
            
             if(mobiQu.Answer_Type__c == 'Text'){
                ansWrObj.isText = true;
                
            }else if(mobiQu.Answer_Type__c == 'Check Box'){
                ansWrObj.isCheckBox = true;
            }else if(mobiQu.Answer_Type__c == 'Radio Botton'){
                ansWrObj.isRadio = true;
            }
            
            List<SelectOption> options = new List<SelectOption>();
             for(MobiAnswer__c anLis:ansList){
                options.add(new SelectOption(anLis.id,anLis.Answer_Description__c));
            }
            ansWrObj.optionsList = options ;
            qaMap.put(mobiQu,ansWrObj);
            system.debug('qaMap=============++_+_+_'+qaMap);
          system.debug('isLastQ ----------------'+isLastQ );  
        
        
    
    }
    
    public PageReference submitDetail(){
    
       for (MobiQuestion__c theKey:qaMap.keySet() )
        {           
           system.debug('Question Id='+theKey.id);
           AnsWrapperClass obj = qaMap.get(theKey);                      
           for(MobiAnswer__c ans:obj.answerList){               
               if(ans.id == obj.selectedAnswer){                   
                   allQAMap.put(theKey,ans);
               }
           }           
        }
         system.debug('allQAMap----------------'+allQAMap);  
      /* qfList = new List<QuestionFeedback__c>();
       Double randomNumber = Math.random();
       Questionniere__c quest = new Questionniere__c();
       if(formType == 'Hardware Advising'){
           quest.Account__c = objId;
       }else if(formType == 'Qualify Sales Lead'){
           quest.Lead__c = objId;
       }
       quest.Random_Number__c = String.valueOf(randomNumber);
       quest.Questionnaire_Description__c = comments;
       insert quest;
       
       Questionniere__c questObj = [select id from Questionniere__c where Random_Number__c =:String.valueOf(randomNumber) limit 1];
       
       
       
       map<String,List<QuestionAnswer__c>> answerMap = new map<String,List<QuestionAnswer__c>>();
       List<String> randNumList = new List<String>();
       for (MobiQuestion__c theKey:allQAMap.keySet() )
        {
           system.debug('Question Id='+theKey.id);
    

           QuestionFeedback__c qObj = new QuestionFeedback__c();
           qObj.Question__c = theKey.id;
           qObj.Answer__c = allQAMap.get(theKey).id;
           qObj.Questionnaire__c = questObj.id;
           
           qfList.add(qObj);

         } 
     
         system.debug('qfList$$$$$$$$$$$==='+qfList);

         insert qfList;--------
    
        return new PageReference('/apex/QuestionnairesThankyou');
    }
    
    public void getProductAndAccessory(){
        productListMaster  = new List<MProduct__c>();
        accessoryMapMaster = new Map<Id,List<Accessory__c>>();
        
        productListMaster = [select id,name,Description__c,Image__c,Model_Number__c,Name__c,Operating_System__c,Price__c,Screen_Size__c from MProduct__c];
        List<Accessory__c> accessory = [select id,name,Accessory_Name__c,Description__c,Image__c,Product__c from Accessory__c];
        
        for(MProduct__c prod:productListMaster){
            List<Accessory__c> accList = new List<Accessory__c>();
            for(Accessory__c acc:accessory){
            
                if(prod.id == acc.Product__c){
                    accList.add(acc);                     
                
                }
            }
            accessoryMapMaster.put(prod.id,accList );  
        
        }
        system.debug('accessoryMap='+accessoryMapMaster);
         
    }*/
    

}