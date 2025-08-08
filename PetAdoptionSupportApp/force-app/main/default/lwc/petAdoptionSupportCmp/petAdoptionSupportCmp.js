import { LightningElement, track, wire } from 'lwc';
import getPets from '@salesforce/apex/PetController.getPets';

export default class PetAdoptionSupportCmp extends LightningElement {
    @track pets;
    selectedPetId;
    showForm = false;
    filter = 'All'

    connectedCallback() {
        this.loadPets('All')
    }

    loadPets(filter) {
        getPets({filterType: filter})
            .then(result => {
                this.pets = result;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: error.body?.message || 'Something went wrong with loading pets',
                        variant: 'error',
                        mode: 'dismissable'
                    })
                )
            })
    }

    handleAll() {
        this.loadPets('All');
        this.filter = 'All';
    }

    handleAdopted() {
        this.loadPets('Adopted');
        this.filter = 'Adopted';
    }

    handleForAdoption() {
        this.loadPets('For Adoption');
        this.filter = 'For Adoption';
    }

    handleAdoptPet(selectedPet) {
        this.selectedPetId = selectedPet.detail.petId;
        this.showForm = true;
    }

    handleFormClose() {
        this.showForm = false;
        
    }

    handleRefresh() {
        this.loadPets(this.filter);
    }
}