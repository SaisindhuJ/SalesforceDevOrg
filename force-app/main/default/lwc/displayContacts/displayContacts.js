import { LightningElement,api } from 'lwc';

export default class DisplayContacts extends LightningElement {
    @api contactsData;
    isEditFlow = false;
    updatedContact = {};
    handleEdit(){
        this.isEditFlow =  (this.isEditFlow === false) ? true : false;
        console.log("isEdit-->"+this.isEditFlow);
    }
    handleChange(event){
        if(event.detail != undefined){
            this.updatedContact.Id = this.contactsData.Id;
            this.updatedContact[event.target.label] = event.target.value;
            console.log("updatedcontact -->"+ JSON.stringify(this.updatedContact));
        }

    }
    handleCancel(){
        this.isEditFlow = false;
        this.updatedContact = {}; 
    }
    handleSave(){
        const updateEvent = new CustomEvent("updatecontact",{ detail : this.updatedContact});
        this.dispatchEvent(updateEvent);

    }
}