@IsTest
public class ContactCreatorTest {

    private static Account createTestAccount(String accName) {
        Account acc = new Account(Name = accName);
        insert acc;
        return acc;
    }

    @IsTest
    static void testCreateContactsSuccess() {
        Account acc = createTestAccount('TestAccount');

        Test.startTest();
        ContactCreator.createContacts(3, 'John', acc.Name);
        Test.stopTest();

        List<Contact> createdContacts = [
            SELECT FirstName, LastName, AccountId FROM Contact WHERE AccountId = :acc.Id];
        System.assertEquals(3, createdContacts.size(), '3 contact should be created');
        System.assertEquals('John1', createdContacts[0].FirstName);
        System.assertEquals('Doe', createdContacts[0].LastName);
    }

    @IsTest
    static void testCreateContactsNoAccountFound() {

        Test.startTest();
        ContactCreator.createContacts(2, 'John', 'AccountNotExist');
        Test.stopTest();

        Integer countContacts = [SELECT COUNT() FROM Contact];
        System.assertEquals(0, countContacts, 'Contacts should not be created because account does not exist');
    }

    @IsTest
    static void testDeleteContactSuccess() {
        Account acc = createTestAccount('DeleteAcc');
        Contact c = new Contact(FirstName = 'Jan', LastName = 'Doe', AccountId = acc.Id);
        insert c;

        Test.startTest();
        String result = ContactCreator.deleteContact(c.Id);
        Test.stopTest();

        System.assertEquals('Success', result);
        System.assertEquals(0, [SELECT COUNT() FROM Contact WHERE Id = :c.Id]);
    }

    @IsTest
    static void testDeleteContactNotFound() {
        Id fakeId = '12345678910';

        Test.startTest();
        String result = ContactCreator.deleteContact(fakeId);
        Test.stopTest();

        System.assertEquals('No contact found', result);
    }

    @IsTest
    static void testGetNumberOfContactsSuccess() {
        Account acc = createTestAccount('CountAcc');

        insert new Contact(FirstName='A', LastName='Doe', AccountId=acc.Id);
        insert new Contact(FirstName='B', LastName='Doe', AccountId=acc.Id);

        Test.startTest();
        Integer count = ContactCreator.getNumberOfContacts('CountAcc');
        Test.stopTest();

        System.assertEquals(2, count, 'should be 2 contacts account releated');
    }

    @IsTest
    static void testGetNumberOfContactsNoAccount() {
        Test.startTest();
        Integer count = ContactCreator.getNumberOfContacts('NoneExisting');
        Test.stopTest();

        System.assertEquals(0, count, 'For none existing account should return 0');
    }

    @IsTest
    static void testGetContactByLastNameFound() {
        Account acc = createTestAccount('LastNameAcc');

        Contact contact1 = new Contact(FirstName='Jan', LastName='Kowalski', AccountId=acc.Id);
        Contact contact2 = new Contact(FirstName='Adam', LastName='Kowalski', AccountId=acc.Id);
        insert new List<Contact>{contact1, contact2};

        Test.startTest();
        Set<Id> ids = ContactCreator.getContactByLastName('Kowalski');
        Test.stopTest();

        System.assertEquals(2, ids.size(), 'should be 2 contacts with LastName Kowalski');
        System.assert(ids.contains(contact1.Id));
        System.assert(ids.contains(contact2.Id));
    }

    @IsTest
    static void testGetContactByLastNameNotFound() {
        Test.startTest();
        Set<Id> ids = ContactCreator.getContactByLastName('NoneLastName');
        Test.stopTest();

        System.assertEquals(true, ids.isEmpty(), 'No contacts with this LastName');
    }
}
