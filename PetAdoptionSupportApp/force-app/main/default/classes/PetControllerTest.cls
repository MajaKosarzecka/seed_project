@isTest
public class PetControllerTest {

    private static Id petForAdoptionId;
    private static Id petAdoptedId;

    @testSetup
    static void setUp() {
        Pet__c petForAdoption = new Pet__c(
            Name='TestName',
            Type__c='Dog',
            Birthday__c=Date.today(),
            Color__c='black',
            For_adoption__c = true );

            insert petForAdoption;
            petForAdoptionId = petForAdoption.Id;

        Pet__c petAdopted = new Pet__c(
            Name='TestAdopted',
            Type__c='Cat',
            Birthday__c=Date.today(),
            Color__c='white',
            For_adoption__c = false);

            insert petAdopted;

            Contact owner = new Contact(FirstName='Jan', LastName='Kowalski', email='jank@gmail.com');
            insert owner;

            petAdopted.Owner__c = owner.Id;
            update petAdopted;

            petAdoptedId = petAdopted.Id;
        
       
    }

    @isTest
    static void testGetPetsAdopted() {
       List<Pet__c> adopted = PetController.getPets('Adopted');
       System.Assert.areEqual(1, adopted.size(), 'there should be 1 adopted pet');
       System.Assert.areEqual(petAdoptedId, adopted[0].Id, 'Pet Id should be the same');
    }

    @isTest
    static void testGetPetsForAdoption() {
       List<Pet__c> forAdoption = PetController.getPets('For Adoption');
       System.Assert.areEqual(1, forAdoption.size(), 'there should be 1 for adoption pet');
       System.Assert.areEqual(petAdoptedId, forAdoption[0].Id, 'Pet Id should be the same');
    }

    @isTest
    static void testGetPetsAll() {
       List<Pet__c> forAdoption = PetController.getPets('All');
       System.Assert.areEqual(2, forAdoption.size(), 'there should be 2 pets');
    }

    @isTest
    static void testAdoptPetCreatesOwnerAndUpdatesPet() {
        Pet__c pet = [SELECT Id FROM Pet__c WHERE Id = :petForAdoptionId LIMIT 1];

        Map<String, String> inputData = new Map<String, String>{
            'firstName' => 'Anna',
            'lastName' => 'Kowalska',
            'phone' => '123123123',
            'email' => 'anna@gmail.com',
            'street' => 'Lodowa 1',
            'postalCode' => '82-500',
            'city' => 'Gdansk'
        };

        PetController.adoptPet(pet.Id, inputData);

        Pet__c updated = [SELECT For_Adoption__c FROM Pet__c WHERE Id = :pet.Id];

        System.Assert.isFalse(updated.For_Adoption__c, 'pet cannot be addopted');
    }
}