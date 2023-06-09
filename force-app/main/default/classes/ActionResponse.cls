public with sharing class ActionResponse {
    public ActionResponse() {}

    public class Response {

        @AuraEnabled public Boolean HasError     {get; set;}
        @AuraEnabled public String Message       {get; set;}
        @AuraEnabled public String ResponseJSON  {get; set;}

        public Response() {}

        public Response(Boolean hasError, String message, String responseJSON) {
            this.HasError       = hasError;
            this.Message        = message;
            this.ResponseJSON   = responseJSON;
        }

        public Response(Exception e) {
            this.HasError       = true;
            this.Message        = e.getMessage();
            this.ResponseJSON   = '';
        }

        public Response(String exMessage) {
            this.HasError       = true;
            this.Message        = exMessage;
            this.ResponseJSON   = '';
        }
    }
}