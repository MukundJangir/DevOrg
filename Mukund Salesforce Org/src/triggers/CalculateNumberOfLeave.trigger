trigger CalculateNumberOfLeave on Employee_Leave__c (before insert) {
    
    try{
    Employee_Leave__c[] empObject = Trigger.new;
    //PublicHoliday__c.Public_Holidays phObj = PublicHoliday__c;
    
    List<PublicHoliday__c> phObj = PublicHoliday__c.getall().values();
    
    
    
    Date startDate = empObject[0].Leave_Start_Date__c;
    Date endDate = empObject[0].Leave_End_Date__c;
    
    integer LeaveDays = startDate.daysBetween(endDate)+1;
    //System.debug('Number of leaves : ' + LeaveDays);
    integer totalLeaveDays = startDate.daysBetween(endDate)+1;
    
    String objId = empObject[0].Id;
    for(integer i=0;i<totalLeaveDays;i++){
        //System.debug('Next Date : ' + startDate.addDays(i));
        
        Datetime dt = DateTime.newInstance(startDate.addDays(i), Time.newInstance(0, 0, 0, 0));
        String dayOfWeek=dt.format('EEEE');
        //System.debug('Day of date: ' + dayOfWeek);
        if(dayOfWeek == 'Sunday' || dayOfWeek == 'Saturday' ||  startDate.addDays(i) == phObj[0].Public_Holiday1__c || startDate.addDays(i) == phObj[0].Public_Holiday2__c || startDate.addDays(i) == phObj[0].Public_Holiday3__c || startDate.addDays(i) == phObj[0].Public_Holiday4__c || startDate.addDays(i) == phObj[0].Public_Holiday5__c || startDate.addDays(i) == phObj[0].Public_Holiday6__c || startDate.addDays(i) == phObj[0].Public_Holiday7__c || startDate.addDays(i) == phObj[0].Public_Holiday8__c || startDate.addDays(i) == phObj[0].Public_Holiday9__c || startDate.addDays(i) == phObj[0].Public_Holiday10__c){
            LeaveDays--;
        }
    }
    //System.debug('Number of leaves after weekend: ' + LeaveDays);
    
    empObject[0].Number_of_Leave__c = LeaveDays;
    
    
    //TestExpt testCls = new testExpt();

	//testCls.exptTesting(LeaveDays);
	//integer inVal = 0;
	
	//integer val = LeaveDays/inVal;
    
    
    //update empObj;
    
    if(LeaveDays > 2 && startDate < Date.today()+28){
        empObject[0].Is_violated_the_leave_policy__c = 'Yes';
    }else{
        empObject[0].Is_violated_the_leave_policy__c = 'No';
    }
    
    }catch(System.Exception ex){
    //	ex.
    	
    	trigger.new[0].name.addError('Nice try'+ex);
    }
    
}