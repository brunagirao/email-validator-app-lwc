public with sharing class Ws_EmailValidatorIntegration {

    private static final String CUSTOM_SETTING_GET_EMAIL_VALIDATOR = 'GetEmailCheck';
    
    public Ws_EmailValidatorIntegration() {}

    @AuraEnabled
    public static ActionResponse.Response validateEmail(String emailToValidate) {
        System.debug('APEX emailToValidate => ' + emailToValidate);
        Email_Validator_Settings__c emailValidatorSetting = Email_Validator_Settings__c.getInstance(CUSTOM_SETTING_GET_EMAIL_VALIDATOR);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:EmailValidatorCredential' + emailValidatorSetting.Endpoint__c + emailToValidate);
        request.setMethod(emailValidatorSetting.Method__c);
        request.setHeader('X-RapidAPI-Key',  emailValidatorSetting.ApiKey__c);
        request.setHeader('X-RapidAPI-Host', emailValidatorSetting.ApiHost__c);

        try {
            HttpResponse response = http.send(request);
            Map<String, Object> result;
    
            if(response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
                result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());

                System.debug('result => ' + JSON.serialize(new EmailResponse(result)));

                return new ActionResponse.Response(
                    false, '', JSON.serialize(new EmailResponse(result))
                );
            } else {
                return new ActionResponse.Response(response.getBody());
            }

        } catch (Exception e) {
            return new ActionResponse.Response(e);
        }  
    }

    public class EmailResponse {
        @AuraEnabled public Boolean IsValid       {get; set;}
        @AuraEnabled public Boolean IsBlocked     {get; set;}
        @AuraEnabled public Boolean IsDisposable  {get; set;}
        @AuraEnabled public String  Domain        {get; set;}

        public EmailResponse(){}

        public EmailResponse(Map<String, Object> emailResult) {
            this.IsValid        = (Boolean) emailResult.get('valid');
            this.IsBlocked      = (Boolean) emailResult.get('block');
            this.IsDisposable   = (Boolean) emailResult.get('disposable');
            this.Domain         = (String)  emailResult.get('domain');
        }
    }


}