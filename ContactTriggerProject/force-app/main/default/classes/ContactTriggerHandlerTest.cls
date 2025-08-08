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

    private static Contact getContact() {
        return [SELECT Id, FirstName, LastName, Email, AccountId FROM Contact WHERE Email = 'jan.nowak@gmail.com' LIMIT 1];
    }

    @isTest
    static void SetAccountIdCantBeRemoved() {
        Contact contact = getContact();
        contact.AccountId = null;

        Test.startTest();
        try {
            update contact;
            System.assert(false, 'it does not catch addError properly');
        } catch (DmlException e) {
            System.assertEquals(true, e.getMessage().contains('Unable to remove account field value'));
        }

        Test.stopTest();

    }

    @isTest
    static void EmailOrPhoneRequiredBeforeInserting() {
        Contact contactNoEmailAndPhone = new Contact(FirstName = 'Jan', LastName = 'Nowak');
       

        Test.startTest();
        try {
            insert contactNoEmailAndPhone;
            System.assert(false, 'id does not catch addError properly');
        } catch (DmlException e) {
            System.assertEquals(true, e.getMessage().contains('Please provide phone or email value'));
        }
        Test.stopTest();
    }


    @isTest
    static void AddToContactHistoryInsertWithEmail() {
        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Email = 'jan.nowakowski@gmail.com');

        Test.startTest();
        insert contact;
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Contact_History__c WHERE Contact__c = :contact.Id AND Action__c = 'Insert'];
        System.assertEquals(1, count, 'it should create one insert record with this contact id');

    }

    @isTest
    static void AddToContactHistoryInsertWithPhone() {
        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Phone = '123456789');

        Test.startTest();
        insert contact;
        Test.stopTest();

        Integer count = [SELECT COUNT() FROM Contact_History__c WHERE Contact__c = :contact.Id AND Action__c = 'Insert'];
        System.assertEquals(1, count, 'it should create one insert record with this contact id');

    }

    @isTest
    static void DeleteMethodInContactHistory() {
        Contact contact = new Contact(FirstName = 'Jan', LastName = 'Nowak', Email = 'jan.nowakowski@gmail.com');

        Test.startTest();
        insert contact;
        delete contact;
        Test.stopTest();

        Integer findContactInHistory = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Delete'];
        System.assertEquals(1, findContactInHistory, 'it should create one delete record');
    }

    @isTest
    static void addTwoUpdatedValuesToContactHistory() {
        Contact oldContact = getContact();

        oldContact.FirstName = 'Ola';
        oldContact.LastName = 'Nowakowska';

        Test.startTest();
        update oldContact;
        Test.stopTest();

        Integer countUpdateMethods = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Update' AND Contact__c = :oldContact.Id];
        System.assertEquals(2, countUpdateMethods, 'it should create 2 update records');
    }

    @isTest
    static void addOneUpdatedValueToContactHistory() {
        Contact oldContact = getContact();

        oldContact.FirstName = 'Ola';

        Test.startTest();
        update oldContact;
        Test.stopTest();

        Integer countUpdateMethods = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Update' AND Contact__c = :oldContact.Id];
        System.assertEquals(1, countUpdateMethods, 'it should create 1 update records');
    }

     @isTest
    static void updateWithoutChanges() {
        Contact oldContact = getContact();

        Test.startTest();
        update oldContact;
        Test.stopTest();

        Integer countUpdateMethods = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Update' AND Contact__c = :oldContact.Id];
        System.assertEquals(0, countUpdateMethods, 'it should create 0 update records');
    }

    @isTest
    static void bulkInsert200Contacts() {
        List<Contact> listToBulk = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            listToBulk.add(new Contact(
                FirstName = 'Joanna' + i,
                LastName = 'Kowalewicz' + i,
                Email = i+'bulk@gmail.com'
            ));
        }
        Test.startTest();
        insert listToBulk;
        Test.stopTest();

        Integer countAddedContacts = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Insert' AND Contact__r.Email LIKE '%bulk@gmail.com'];
        System.assertEquals(200, countAddedContacts, 'it should create 200 insert history records');
    }

    @isTest
    static void bulkUpdate200Contacts() {
        List<Contact> listToBulk = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            listToBulk.add(new Contact(
                FirstName = 'Joanna' + i,
                LastName = 'Kowalewicz' + i,
                Email = i+'bulk@gmail.com'
            ));
        }
        insert listToBulk;
        
        for (Contact c : listToBulk) {
            c.LastName = 'Kowal';
        }

        Test.startTest();
        update listToBulk;
        Test.stopTest();

        Integer countUpdatedContacts = [SELECT COUNT() FROM Contact_History__c WHERE Action__c = 'Update'];
        System.assertEquals(200, countUpdatedContacts, 'it should create 200 update history records');
    }
}