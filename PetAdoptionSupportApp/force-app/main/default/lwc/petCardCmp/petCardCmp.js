import { LightningElement, api } from 'lwc';

export default class PetCardCmp extends LightningElement {
    @api pet;

    get name() {return this.pet.Name__c;}
    get type() {return this.pet.Type__c;}
    get birthday() {return this.pet.Birthday__c;}
    get color() {return this.pet.Color__c;}
    get description() {return this.pet.Description__c;}
    get forAdoption() {return this.pet.For_Adoption__c;}
    get owner() {return this.pet.Owner__r;}
    get petUrl() {return '/' + this.pet.Id;}

    handleAdopt(petToAdopt) {
        const petId = this.pet.Id;
        const eventToSupport = new CustomEvent('adopt', {detail: {petId}});
        this.dispatchEvent(eventToSupport)
    }
}