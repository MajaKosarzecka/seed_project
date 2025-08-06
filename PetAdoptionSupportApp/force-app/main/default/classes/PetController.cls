public with sharing class PetController {
    @AuraEnabled(cacheable=true)
    public static List<Pet__c> getPets(String filterType) {
        if (filterType == 'Adopted') {
            return [SELECT Id, Name__c, Type__c, Birthday__c, Color__c, Description__c, Owner__r.Name FROM Pet__c WHERE For_Adoption__c = FALSE AND Owner__c != NULL];
        } else if (filterType == 'For Adoption') {
            return [SELECT Id, Name__c, Type__c, Birthday__c, Color__c, Description__c, For_Adoption__c FROM Pet__c WHERE For_Adoption__c = TRUE];
        } else {
            return [SELECT Id, Name__c, Type__c, Birthday__c, Color__c, Description__c, Owner__r.Name, For_Adoption__c FROM Pet__c];
        }
    }

    @AuraEnabled
    public static void adoptPet(String petId, Map<String, String> inputData) {
        Contact contact = new Contact(
            FirstName = inputData.get('firstName'),
            LastName = inputData.get('lastName'),
            Phone = inputData.get('phone'),
            Email = inputData.get('email'),
            Mailing_Street__c = inputData.get('street'),
            MailingPostalCode__c = inputData.get('postalCode'),
            MailingCity__c = inputData.get('city')

        );
    
        insert contact;

        Pet__c pet = [SELECT Id, For_Adoption__c, Owner__c FROM Pet__c WHERE Id = :petId LIMIT 1];

        pet.Owner__c = contact.Id;
        pet.For_Adoption__c = false;
        update pet;

    }
    

    
}