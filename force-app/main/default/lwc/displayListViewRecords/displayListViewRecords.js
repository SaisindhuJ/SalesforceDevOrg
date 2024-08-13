import { LightningElement,wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class DisplayListViewRecords extends LightningElement {
    contactList = [];
    @wire(getListUi,{objectApiName:CONTACT_OBJECT,listViewApiName:'AllContacts'})
    handledata({data,error}){
        if(data){
            console.log('data from getlistui -->'+ JSON.stringify(data.records.records));
            this.contactList = data.records.records;
            console.log('contactlist -->'+ this.contactList);

        } else{
            console.log('error -->' + JSON.stringify(error));
        }
    }
}