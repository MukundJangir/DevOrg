public with sharing class savePdf{

    public Id canId;
    public String pdfUrl { get ; set;}
    public ApexPages.StandardController pdf_controller;
   // public String bhc_title { get ; set;}
    public savePdf(ApexPages.StandardController controller){
        pdf_controller = controller;
        canId = ApexPages.CurrentPage().getParameters().get('vId');
        System.debug('ID='+canId);
        Candidate__c can = [select id,PDF_Path__c from Candidate__c where id=:canId];
        pdfUrl = can.PDF_Path__c;        
        System.debug('can ='+can );
        System.debug('pdfUrl='+pdfUrl);
    
     //  utility.GetData(canId ,pdfUrl);
        goBack();
    }
    
    public pagereference goBack(){
        return new pagereference('/'+canId);
     }

   
}