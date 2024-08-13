import { LightningElement,track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';

const columns = [
    { label: 'Name', fieldName: 'Name' },
    { label: 'Industry', fieldName: 'Industry' },
    { label: 'Phone', fieldName: 'phone', type: 'phone' },
    { label: 'Rating', fieldName: 'Rating' },
    { label: 'AnnualRevenue', fieldName: 'AnnualRevenue'},
];

export default class DisplayAccountsData extends LightningElement {
    @track data;
    @track columns;
    connectedCallback(){
        getAccounts().then(result =>{
            this.data = result;
            console.log(JSON.stringify(result));

        }).catch(error=>{
            console.log(error);
        })
    }
    columns = columns;

}