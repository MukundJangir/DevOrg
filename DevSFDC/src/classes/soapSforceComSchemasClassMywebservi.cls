//Generated by wsdl2apex

public class soapSforceComSchemasClassMywebservi {
    public class LogInfo {
        public String category;
        public String level;
        private String[] category_type_info = new String[]{'category','http://soap.sforce.com/schemas/class/MyWebService1','LogCategory','1','1','false'};
        private String[] level_type_info = new String[]{'level','http://soap.sforce.com/schemas/class/MyWebService1','LogCategoryLevel','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'category','level'};
    }
    public class makeAccountResponse_element {
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class AllowFieldTruncationHeader_element {
        public Boolean allowFieldTruncation;
        private String[] allowFieldTruncation_type_info = new String[]{'allowFieldTruncation','http://www.w3.org/2001/XMLSchema','boolean','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'allowFieldTruncation'};
    }
    public class DebuggingHeader_element {
        public soapSforceComSchemasClassMywebservi.LogInfo[] categories;
        public String debugLevel;
        private String[] categories_type_info = new String[]{'categories','http://soap.sforce.com/schemas/class/MyWebService1','LogInfo','0','-1','false'};
        private String[] debugLevel_type_info = new String[]{'debugLevel','http://soap.sforce.com/schemas/class/MyWebService1','LogType','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'categories','debugLevel'};
    }
    public class MyWebService1 {
        public String endpoint_x = 'https://na15.salesforce.com/services/Soap/class/MyWebService1';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        public soapSforceComSchemasClassMywebservi.AllowFieldTruncationHeader_element AllowFieldTruncationHeader;
        public soapSforceComSchemasClassMywebservi.DebuggingHeader_element DebuggingHeader;
        public soapSforceComSchemasClassMywebservi.SessionHeader_element SessionHeader;
        public soapSforceComSchemasClassMywebservi.DebuggingInfo_element DebuggingInfo;
        public soapSforceComSchemasClassMywebservi.CallOptions_element CallOptions;
        private String AllowFieldTruncationHeader_hns = 'AllowFieldTruncationHeader=http://soap.sforce.com/schemas/class/MyWebService1';
        private String DebuggingHeader_hns = 'DebuggingHeader=http://soap.sforce.com/schemas/class/MyWebService1';
        private String SessionHeader_hns = 'SessionHeader=http://soap.sforce.com/schemas/class/MyWebService1';
        private String DebuggingInfo_hns = 'DebuggingInfo=http://soap.sforce.com/schemas/class/MyWebService1';
        private String CallOptions_hns = 'CallOptions=http://soap.sforce.com/schemas/class/MyWebService1';
        private String[] ns_map_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1', 'soapSforceComSchemasClassMywebservi'};
        public void makeAccount() {
            soapSforceComSchemasClassMywebservi.makeAccount_element request_x = new soapSforceComSchemasClassMywebservi.makeAccount_element();
            soapSforceComSchemasClassMywebservi.makeAccountResponse_element response_x;
            Map<String, soapSforceComSchemasClassMywebservi.makeAccountResponse_element> response_map_x = new Map<String, soapSforceComSchemasClassMywebservi.makeAccountResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              '',
              'http://soap.sforce.com/schemas/class/MyWebService1',
              'makeAccount',
              'http://soap.sforce.com/schemas/class/MyWebService1',
              'makeAccountResponse',
              'soapSforceComSchemasClassMywebservi.makeAccountResponse_element'}
            );
            response_x = response_map_x.get('response_x');
        }
    }
    public class CallOptions_element {
        public String client;
        private String[] client_type_info = new String[]{'client','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'client'};
    }
    public class SessionHeader_element {
        public String sessionId;
        private String[] sessionId_type_info = new String[]{'sessionId','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'sessionId'};
    }
    public class DebuggingInfo_element {
        public String debugLog;
        private String[] debugLog_type_info = new String[]{'debugLog','http://www.w3.org/2001/XMLSchema','string','1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{'debugLog'};
    }
    public class makeAccount_element {
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/schemas/class/MyWebService1','true','false'};
        private String[] field_order_type_info = new String[]{};
    }
}