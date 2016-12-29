global class EmailToLead implements Messaging.InboundEmailHandler {
 
        global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
            Messaging.InboundEnvelope envelope) {
 
            Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
 
            Lead lead = new Lead();
            lead.FirstName = 'Lead';//email.fromname.substring(0,email.fromname.indexOf(' '));
            lead.LastName = ''+system.now();//email.fromname.substring(email.fromname.indexOf(' '));
            lead.Email = envelope.fromAddress;
            String textBody = email.plainTextBody;
            if(textBody.length() > 10 && textBody.contains('*Student:*')){
            String name = textBody.substring(textBody.indexOf('*Student:*')+10,textBody.indexOf('*Location Preference:*'));
            String[] names = name.split('\n');
            //lead.Description = names[0]+'::'+names[1]+'::'+names[2] ;
           // String str1 = '';
           // for(String str:names){
           //     str1 += str+'+';
           // }
            
            //String phone = name.substring(name.length() - 10),name.length());
            String mobile= names[names.size()-1];
            
           // lead.Description = str1 +' T '+names.size();
           if(mobile.isNumeric())
           lead.MobilePhone = mobile;
           
           }
            lead.Description = textBody ;
            
            
            
            
            lead.LeadSource = 'Email';
            
            /*String companyName;
            system.debug('-----CompanyName----' +textBody.indexOf('CompanyName:'));
            if(textBody.indexOf('CompanyName:') > 1 ) {
                system.debug('-----CompanyName----' +textBody.indexOf('CompanyName:'));
                Integer startPos = textBody.indexOf('CompanyName:');
                system.debug('-----startPos ----' +startPos );
                Integer endPos = textBody.indexOf('.',textBody.indexOf('CompanyName:'));
                system.debug('-----endPos ----' +endPos );
                system.debug('-----companyN----' + textBody.substring(startPos+'CompanyName:'.length(),endPos));
                companyName = textBody.substring(startPos+'CompanyName:'.length(),endPos);
                //system.debug('----companyName------' +companyName);
            }*/
            lead.Company = 'Capgemini';//email.plainTextBody;
           // lead.Company = companyName != NULL ? companyName : '(not provided)';
            lead.Status = 'Web';
            insert lead;
            return result;
 
        }
 
    }