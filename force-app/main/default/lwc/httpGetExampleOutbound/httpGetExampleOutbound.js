import { LightningElement } from 'lwc';
import getEmployeeDetails from '@salesforce/apex/EmployeeDataController.getEmployeeDetails';

export default class HttpGetExampleOutbound extends LightningElement {

    allEmployees;
    showSpinner = false;

    getDetails(){
        this.showSpinner = true;
        getEmployeeDetails()
        .then(result => {
            if(result != undefined){
                var temp = JSON.parse(result);
                console.log('result-->'+result);
                if(temp.data != undefined){
                    this.allEmployees = temp.data;
                }
                this.showSpinner = false;
            }
        })
        .catch(error => {
            this.showSpinner = false;
            console.log('Error Occured -->'+error)
        })
    }
}