import { LightningElement,api,track,wire } from 'lwc';
import getContactsOfAccount from '@salesforce/apex/AccountController.getContactsOfAccount';
//import updateContact from '@salesforce/apex/AccountController.updateContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ContactsParent extends LightningElement {
    @api recordId;
    @track contactList;
    @wire(getContactsOfAccount,{accountId:'$recordId'})
    wiredContacts({data,error}){
        if(data){
            this.contactList = data;
            console.log(data);
        } else{
            console.log(error);
        }
    } 
    handleUpdate(event){
        if(event.detail!=undefined){
            console.log("eventdetail-->"+event.detail);
            updateContact({c : event.detail})
            .then(result => {
                console.log("result -->"+JSON.stringify(result));
            }).catch(error => {
                console.log("error -->"+JSON.stringify(error));
            });
        }

    } 

}