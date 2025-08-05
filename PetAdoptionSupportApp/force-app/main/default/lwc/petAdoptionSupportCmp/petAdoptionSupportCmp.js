import { LightningElement, track } from 'lwc';
import getPets from '@salesforce/apex/PetController.getPets';

export default class PetAdoptionSupportCmp extends LightningElement {
    @track pets;
    selectedPetId;

    connentedCallback() {
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
                        title: 'Błąd podczas ładowania zwierząt',
                        message: error.body?.message || 'Coś poszło nie tak',
                        variant: error,
                        mode: 'dismissable'
                    })
                )
            })
    }

    handleAll() {
        this.loadPets('All');
    }

    handleAdopted() {
        this.loadPets('Adopted');
    }

    handleForAdoption() {
        this.loadPets('For Adoption')
    }

    handleAdoptPet(selectedPet) {
        this.selectedPetId = selectedPet.detail.petId;
    }
}