import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class Formsubmission extends LightningElement {
    userDetails = {};
    handleChange(event){
        //var label = event.target.label;
        this.userDetails[event.target.label] = event.target.value;
        console.log('userdetails--->'+this.userDetails);
    }
    handleSubmit(){
        const toastevnt = new ShowToastEvent({
            title: 'Success',
            message:'Form Submitted Successfully',
            variant: 'success'    
        });
        this.dispatchEvent(toastevnt);
    }
    handleCancel(){
        const evnt = new ShowToastEvent({
            title:'Warning',
            message: 'You Cancelled the Form',
            variant : 'warning'
        });
        this.dispatchEvent(evnt);
    }
}