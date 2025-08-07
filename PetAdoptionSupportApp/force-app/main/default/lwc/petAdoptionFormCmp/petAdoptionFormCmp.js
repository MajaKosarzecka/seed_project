import { LightningElement, track, api } from 'lwc';
import adoptPet from '@salesforce/apex/PetController.adoptPet';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PetAdoptionFormCmp extends LightningElement {
    @api petId;
    @track inputData ={};

    get disableAdopt() {
        return !this.inputData.firstName || !this.inputData.lastName;
    }
    handleInputChange(event) {
        const field = event.target.dataset.field;
        this.inputData[field] = event.target.value;
    }

    handleAdopt() {
        adoptPet({petId: this.petId, inputData: this.inputData})
            .then(() => {
                this.dispatchEvent(new CustomEvent('close'));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'success',
                        message: 'pet is adopted',
                        variant: 'success'
                    })
                );
                this.dispatchEvent(new CustomEvent('refresh'));
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'error',
                        message: error.body?.message || 'error with adoption',
                        variant: 'error',
                        mode: 'dismissable'
                    })
                )
            })
    }
}