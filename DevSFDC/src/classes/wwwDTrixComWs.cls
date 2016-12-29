//Generated by wsdl2apex

public class wwwDTrixComWs {
    public class DTrixSoap {
        public String endpoint_x = 'https://www.d-trix.com/ws/DTrix.asmx';
        public Map<String,String> inputHttpHeaders_x;
        public Map<String,String> outputHttpHeaders_x;
        public String clientCertName_x;
        public String clientCert_x;
        public String clientCertPasswd_x;
        public Integer timeout_x;
        private String[] ns_map_type_info = new String[]{'www.d-trix.com/ws', 'wwwDTrixComWs'};
        public wwwDTrixComWs.runResult_element run(wwwDTrixComWs.input_element input) {
            wwwDTrixComWs.run_element request_x = new wwwDTrixComWs.run_element();
            wwwDTrixComWs.runResponse_element response_x;
            request_x.input = input;
            Map<String, wwwDTrixComWs.runResponse_element> response_map_x = new Map<String, wwwDTrixComWs.runResponse_element>();
            response_map_x.put('response_x', response_x);
            WebServiceCallout.invoke(
              this,
              request_x,
              response_map_x,
              new String[]{endpoint_x,
              'www.d-trix.com/ws/run',
              'www.d-trix.com/ws',
              'run',
              'www.d-trix.com/ws',
              'runResponse',
              'wwwDTrixComWs.runResponse_element'}
            );
            response_x = response_map_x.get('response_x');
            return response_x.runResult;
        }
    }
    public class runResponse_element {
        public wwwDTrixComWs.runResult_element runResult;
        private String[] runResult_type_info = new String[]{'runResult','www.d-trix.com/ws','runResult_element','0','1','false'};
        private String[] apex_schema_type_info = new String[]{'www.d-trix.com/ws','false','false'};
        private String[] field_order_type_info = new String[]{'runResult'};
    }
    public class run_element {
        public wwwDTrixComWs.input_element input;
        private String[] input_type_info = new String[]{'input','www.d-trix.com/ws','input_element','0','1','false'};
        private String[] apex_schema_type_info = new String[]{'www.d-trix.com/ws','false','false'};
        private String[] field_order_type_info = new String[]{'input'};
    }
    public class runResult_element {
        private String[] apex_schema_type_info = new String[]{'www.d-trix.com/ws','false','false'};
        private String[] field_order_type_info = new String[]{};
    }
    public class input_element {
        private String[] apex_schema_type_info = new String[]{'www.d-trix.com/ws','false','false'};
        private String[] field_order_type_info = new String[]{};
    }
}