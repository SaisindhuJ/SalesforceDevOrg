import { LightningElement } from 'lwc';
import createEmployee from '@salesforce/apex/EmployeeDataController.createEmployee';
export default class HttpPostExampleInbound extends LightningElement {
    empdetails;
    resEmpData;
    showSpinner = false;
    handleChange(event){
        var tempLabel = event.target.label;
        empdetails[tempLabel] = event.target.value;
        console.log('Emp details -->'+empdetails);
    }
    handleCreate(){
        this.showSpinner = true;
        var tempDetails = JSON.stringify(this.empdetails);
        createEmployee({empdetails : tempDetails})
        .then(result => {
            if (result != undefined){
                this.resEmpData = JSON.parse(result.data);
            }
            this.showSpinner = false;
        })
        .catch(error => {
            this.showSpinner = false;
            console.log('Error -->'+error)
        })
    }
}