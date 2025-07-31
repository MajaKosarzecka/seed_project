@isTest
public class ContactTriggerHandlerTest {

    @testSetup
    static void setupData() {
        Account a = new Account(Name = 'Synechron');
        insert a;

        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Email = 'jan.nowak@gmail.com', AccountId = a.Id);
        insert contact; 
    }

    private static Account getAccount() {
        return [SELECT Id FROM Account LIMIT 1];
    }

    private static getContact() {
        return [SELECT Id, FirstName, LastName, Email, AccountId FROM Contact WHERE Email = 'jan.nowak@gmail.com' LIMIT 1];
    }

    @isTest
    static void SetAccountIdCantBeRemoved() {
        Contact contact = getContact();
        contact.AccountId = null;

        Test.startTest();
        try {
            update contact;
            System.debug(false, 'it does not catch addError properly');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Unable to remove account field value'));
        }

        Test.stopTest();

    }

    @isTest
    static void EmailOrPhoneRequiredBeforeInserting() {
        Account a = createAccount();
        Contact contactNoEmail = new Contact(FirstName = 'Jan', LastName = 'Nowak');
       

        Test.startTest();
        try {
            insert contactNoEmail;
            System.debug(false, 'id does not catch addError properly');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('Please provide phone or email value'));
        }
        Test.stopTest();
    }

    @isTest
    static void AddToContactHistoryAfterInsert() {
        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Email = 'jan.nowakowski@gmail.com');

        Test.startTest();
        insert contact;
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Contact_History__c WHERE Contact__c = :contact.Id AND Action__c == 'Insert'];
        System.assertEquals(1, count, 'it should find one insert method with this contact id');

    }

    @isTest
    static void DeleteMethodInContactHistory() {
        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Email = 'jan.nowakowski@gmail.com');

        Test.StartTest();
        insert contact:
        delete contact;
        Test.StopTest();

        findContactInHistory = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Delete' AND Email = :'jan.nowakowski@gmail.com'];
        System.assertEquals(1, findContactInHistory, 'it should find one contact with delete ')
    }

    @isTest
    static void addUpdatedValuesToContactHistory() {
        Contact oldContact = getContact();

        oldContact.FirstName = 'Ola';
        oldContact.LastName = 'Nowakowska';

        update oldContact;

        CountUpdateMethods = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Update' AND Contact__c = :oldContact.Id];
        System.assertEquals(2, CountUpdateMethods, 'it should find 2 update methods')
    }

    @isTest
    static void bulk200Contacts() {
        List<Contact> listToBulk = new List<Contact>()
        for (Integer i = 0; i < 200; i++) {
            listToBulk.add(new Contact(
                FirstName = 'Joanna' + i,
                LastName = 'Kowalewicz' + i,
                Email = i+'bulk@gmail.com',
            ));
        }
        insert listToBulk;

        countAddedContacts = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Insert'];
        System.assertEqual(200, countAddedContacts, 'it should find 200 insert contacts');
    }
}