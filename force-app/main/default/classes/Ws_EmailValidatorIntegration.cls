public with sharing class Ws_EmailValidatorIntegration {

    private final String CUSTOM_SETTING_GET_EMAIL_VALIDATOR = 'GetEmailCheck';
    
    public Email_Validator_Settings__c emailValidatorSetting;
    
    public Ws_EmailValidatorIntegration() {
        this.emailValidatorSetting = Email_Validator_Settings__c.getInstance(CUSTOM_SETTING_GET_EMAIL_VALIDATOR);
    }

    public void validateEmail(String emailToValidate) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:EmailValidatorCredential' + this.emailValidatorSetting.Endpoint__c + emailToValidate);
        request.setMethod(this.emailValidatorSetting.Method__c);
        request.setHeader('X-RapidAPI-Key',  this.emailValidatorSetting.ApiKey__c);
        request.setHeader('X-RapidAPI-Host', this.emailValidatorSetting.ApiHost__c);

        try {
            HttpResponse response = http.send(request);
            Map<String, Object> result;
    
            if(response.getStatusCode() >= 200 && response.getStatusCode() < 300) {
                result = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            }

            System.debug('result => ' + result);

        } catch (Exception e) {
            //return some exception and store in a Apex Logs table.
        }
        
    }
}