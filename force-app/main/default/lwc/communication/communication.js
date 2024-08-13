import { LightningElement,wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact'

export default class Communication extends LightningElement {
    contactsData={};
    contactList=[];
    @wire(getListUi,{objectApiName:CONTACT_OBJECT,listViewApiName:'AllContacts'})
    handleData({data,error}){
        if(data){
            console.log('data-->'+JSON.stringify(data));
            this.contactsData = data.records;
            this.contactList = data.records.records;
            console.log("data records -->"+ JSON.stringify(this.contactsData));
            console.log('records in recrds --->'+this.contactList);
            //console.log('record1 Id -->'+ this.contactList[0].id);
        } else {
            console.log('error -->'+JSON.stringify(error));
        }
    }
    
}