import { LightningElement,wire } from 'lwc';
import { publish,subscribe,unsubscribe,createMessageContext,releaseMessageContext, MessageContext } from 'lightning/messageService';
import SAMPLELMC from "@salesforce/messageChannel/sampleLMC__c";

export default class SampleEventSender extends LightningElement {
    
    @wire(MessageContext)
    messageContext;

    FirstValue;
    SecondValue;

    handleChage1(event){
        this.FirstValue = event.target.value;
        console.log("First Value-->"+ this.FirstValue);
    }

    handleChange2(event){
        this.SecondValue = event.target.value;
        console.log("Second Value-->"+ this.SecondValue);
    }

    handleSend(){
        var tempUserValues = {
            FirstValue : this.FirstValue,
            SecondValue : this.SecondValue
        }
        publish(this.messageContext,SAMPLELMC,tempUserValues);        
    }
}