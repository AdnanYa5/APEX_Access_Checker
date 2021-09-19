import { LightningElement, api, wire } from 'lwc';
import checkAccess from '@salesforce/apex/AccessCheckController.checkAccess';

export default class AccessCheckButton extends LightningElement {
    @api recordId;

    btnClickHandler(event){
        console.log('Button Clicked');
        checkAccess({'recordId':this.recordId}).then(result=>{
            console.log('Result---'+JSON.stringify(result));
        }).catch(error =>{
            console.log('Error message--'+JSON.stringify(error.body.message));
        });
    }
}