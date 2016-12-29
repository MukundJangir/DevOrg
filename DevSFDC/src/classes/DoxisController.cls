public class DoxisController{

    public static String url = 'https://ap1.salesforce.com/services/apexrest/RestAPI';
    public String htmlString;
    
    public DoxisController(ApexPages.StandardController controller){
        
       
    }
    
     public DoxisController(){
        
        htmlString = getHtmlBody();
    }
     public static String getHtmlBody()
    {
        HttpRequest req = new HttpRequest();
        Http http = new Http();
        req.setMethod('GET');
        //String url = 'https://vikashtalanki-developer-edition.na12.force.com/services/apexrest/GetService?name='+name;        
        req.setEndpoint(url);
        req.setHeader('Authorization', 'OAuth '+UserInfo.getSessionId());
        HTTPResponse resp = http.send(req);
        system.debug('BODY='+resp.getBody());
        return resp.getBody();
     }
     
     


}