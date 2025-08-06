import { LightningElement, track, wire } from 'lwc';
import getPets from '@salesforce/apex/PetController.getPets';

export default class PetAdoptionSupportCmp extends LightningElement {
    @track pets;
    selectedPetId;
    showForm = false;
    filter = 'All'

    connentedCallback() {
        this.loadPets('All')
    }

    @wire(getPets, {filter: '$filter'})
    wiredPets({error, data}) {
        if (data) {
            this.pets = data;
            console.log('pets data:', data);
        } else if (error) {
            console.error('error while fetching pets', error);
            this.pets = []
        }
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
        this.showForm = true;
    }

    handleFormClose() {
        this.showForm = false;
        this.loadPets(this.pets ? "All" : "All")
    }
}