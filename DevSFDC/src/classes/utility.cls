public with sharing class utility{


@Future(callout=true)
    public static void GetData(Id id, String url) {
    String urlStr; 
    String docName;
        
    if(url != null){
       //tring str1 = url.substringAfterLast('.');
        //( str1  == 'pdf'){
            urlStr = url.substringBeforeLast('/');
            docName= url.substringAfterLast('/');
                    
    
      //} 
   
      } 
       system.debug('urlStr='+urlStr);
       system.debug('docName='+docName);
        

       
    string ResponseString = '';             
    HttpRequest Request = new HttpRequest();        
    Http DataHttp = new Http();                
    Request.setMethod('GET');                
                    
    Request.setEndpoint(urlStr);                                 
    HttpResponse DataResponse = DataHttp.send(Request);        
    ResponseString = DataResponse.getBody();               
    Blob ResponseAsBlob = blob.valueof(ResponseString);       
    attachment DataFile = new attachment();       
    DataFile.Name = docName;        
    DataFile.ParentId = id;                                    
    DataFile.body = ResponseAsBlob;     
    system.debug('DataFile.ParentId '+DataFile.ParentId );                         
    insert DataFile;  
    system.debug('Record inserted');                        
    } 


}