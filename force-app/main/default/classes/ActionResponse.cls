public with sharing class ActionResponse {
    public ActionResponse() {}

    public class Response {

        public Boolean HasError     {get; set;}
        public String Message       {get; set;}
        public String ResponseJSON  {get; set;}

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