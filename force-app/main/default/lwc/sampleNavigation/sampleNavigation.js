import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import DESCRIPTION_FIELD from '@salesforce/schema/Account.Description';

export default class SampleNavigation extends NavigationMixin(LightningElement) {
    accDetails ={};

    handleChange(event){
        var tempLabel = event.target.label;
        this.accDetails[tempLabel] = event.target.value;
    }

    handleSave(){
        console.log("Account -->"+JSON.stringify(this.accDetails))
        this.createAccountRecord();
    }

    createAccountRecord(){
        const fields = {};
        fields[NAME_FIELD.fieldApiName] = this.accDetails.AccountName;
        fields[PHONE_FIELD.fieldApiName] = this.accDetails.Phone;
        fields[WEBSITE_FIELD.fieldApiName] = this.accDetails.Website;
        fields[DESCRIPTION_FIELD.fieldApiName] = this.accDetails.Description;
        
        const recordInput = {apiName : ACCOUNT_OBJECT.objectApiName,fields};
        createRecord(recordInput)
        .then(acc =>{
            this.accDetails.id = acc.id;
            console.log("Account Created -->"+JSON.stringify(acc));
            this.navigateToRecordPage();

        })
        .catch(error => {
            console.log("Error Occured" + JSON.stringify(error));
        })
    }

    navigateToRecordPage(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.accDetails.id,
                actionName: 'view',
            },
        });
    }
}