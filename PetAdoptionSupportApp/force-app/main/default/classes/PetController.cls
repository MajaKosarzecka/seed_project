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
}