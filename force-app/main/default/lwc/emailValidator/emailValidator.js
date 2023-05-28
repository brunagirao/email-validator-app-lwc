import { LightningElement, track }  from 'lwc';

import validateEmail                from '@salesforce/apex/Ws_EmailValidatorIntegration.validateEmail';

export default class EmailValidator extends LightningElement {

    @track emailToValidate;


    //HANDLES
    handleEmailChange (event) {
        this.emailToValidate = event.target.value;
    }

    handleValidateEmail () {
        console.log('handleValidateEmail');

        if(this.isAValidEmail(this.emailToValidate)) this.validateEmail();
    }

    //ASYNCS
    async validateEmail () {
        console.log('validateEmail');

        let response = await validateEmail ({
            emailToValidate : this.emailToValidate
        });
    
        let emailResponse = JSON.parse(response.ResponseJSON);

        if (response.HasError || emailResponse.length < 1) {
            console.log('Error');
        } else {
            console.log('Success', response.ResponseJSON);
        }

    }


    isAValidEmail(email) {
        console.log('email => ', email);
        return String(email)
        .toLowerCase()
        .match(
        /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
        );
    }
}