import { LightningElement,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { get ObjectInfo } from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import GENDER_IDENTITY_FIELD from '@salesforce/schema/Contact.GenderIdentity';

export default class AddMultipleContacts extends LightningElement {

    @wire getObjectInfo {objectApiName : CONTACT_OBJECT}
    contactObjectInfo;

    @wire getPicklistValues {recordTypeId : contactObjectInfo.data.defaultRecordTypeId , fieldApiName : GENDER_IDENTITY_FIELD }
    genderPicklistValues;

    get genderOptions(){
        return this.genderPicklistValues?.data?.values;
    }
}