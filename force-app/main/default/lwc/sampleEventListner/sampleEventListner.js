import { LightningElement,wire } from 'lwc';
import { publish,subscribe,unsubscribe,createMessageContext,releaseMessageContext, MessageContext } from 'lightning/messageService';
import SAMPLELMC from "@salesforce/messageChannel/sampleLMC__c";

export default class SampleEventListner extends LightningElement {
    
    receivedValue1;
    receivedValue2;
    subscription = null;

    @wire(MessageContext)
    messageContext;

    connectedCallback(){
        this.subscribeChannel();
    }

    subscribeChannel(){
        this.subscription = subscribe(this.messageContext,SAMPLELMC,(message)=>{
            message.FirstValue ? this.receivedValue1 = message.FirstValue : "No meesage Payload";
            message.SecondValue ? this.receivedValue2 = message.SecondValue : "No meesage Payload";
        });
    }

}