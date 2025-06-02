import { LightningElement, wire } from 'lwc';
import getMyLeaves from '@salesforce/apex/LeaveRequstController.getMyLeaves';

const COLUMNS = [
    { label:'RequestorId', fieldName:'Name', cellAttributes: {class: {fieldName : 'cellClass'}}},
    { label:'FromDate', fieldName:'From_Date__c',cellAttributes: {class: {fieldName : 'cellClass'}}},
    { label:'ToDate', fieldName:'To_Date__c',cellAttributes: {class: {fieldName : 'cellClass'}}},
    { label:'Reason', fieldName:'Reason__c',cellAttributes: {class: {fieldName : 'cellClass'}}},
    { label:'Status', fieldName:'Status__c',cellAttributes: {class: {fieldName : 'cellClass'}}},
    { label:'ManagerComment', fieldName:'Manager_Comment__c',cellAttributes: {class: {fieldName : 'cellClass'}}},
    {type: 'button' , typeAttributes: {
        label : 'Edit',
        name: 'Edit',
        title : 'Edit',
        Value :'edit',
        disabled : {fieldName : 'isEditDisabled'}
        } , cellAttributes: {class: {fieldName : 'cellClass'}}
    },
    {type: Action , typeAttributes: {
        label" Edit,
        
    }}
];
   
export default class MyLeaves extends LightningElement {
    myLeaves = [];
    columns=COLUMNS;


    @wire(getMyLeaves)
    getMyLeavesInfo(result){
        if(result.data){
            this.myLeaves = result.data.map(a=>({
                ...a,
                cellClass: a.Status__c == 'Approved' ? 'slds-theme_success' : a.Status__c == 'Rejected' ? 'slds-theme_warning' : '' ,
                isEditDisabled: a.Status__c == 'Pending' 
            }));
        } if(result.error){
            console.log('error occured while fetching getMyLeaves ',result.error);
        }
    }

    getNorecordFound() {
        return this.myLeaves.length == 0;
    }
    
}