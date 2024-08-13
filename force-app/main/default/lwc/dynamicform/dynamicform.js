import { LightningElement } from 'lwc';

export default class Dynamicform extends LightningElement {
    selectedValue='';
    showName = false;
    showEmail = false;
    formOptions = [
        {'label' : 'Name', 'value' : 'name'},
        {'label' : 'Email', 'value' : 'email'}    
    ];
    handleChange(event){
        console.log('selected value -->' + event.target.value);
        this.selectedValue = event.target.value;
        this.showEmail = (this.selectedValue === 'email');
        this.showName = (this.selectedValue === 'name'); 
    }

    handleNameChange(){

    }
    
    

}