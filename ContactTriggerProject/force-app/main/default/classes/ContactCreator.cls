public class ContactCreator {
    public static void createContacts(Integer numberOfContacts, String contactName, String accountName) {
        List<Contact> contactToInsert = new List<Contact>();
        try{
             Account acc = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
            for (Integer i = 0; i < numberOfContacts; i++) {
                Contact newContact = new Contact();
                newContact.FirstName = contactName +(i + 1);
                newContact.LastName = 'Doe';
                newContact.AccountId = acc.Id;
                contactToInsert.add(newContact);
        }
        insert contactToInsert;
    } catch (QueryException e) {
            System.debug('No account found with the name: ' + accountName);
            return;
        }
        

    }

    public static String deleteContact(Id contactId) {
        try {
            Contact contactToDelete = [SELECT Id FROM Contact WHERE Id = :contactId LIMIT 1];
            delete contactToDelete;
            return 'Success';
        } catch (DmlException e) {
            return 'No contact found';
        } catch (QueryException e) {
            return 'No contact found';
        }
    }

    public static Integer getNumberOfContacts(String accountName) {
        try {
            Account acc = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
            Integer count = [SELECT COUNT() FROM Contact WHERE AccountId = :acc.Id];
            return count;
        } catch (QueryException e) {
            System.debug('No account found with the name: ' + accountName);
            return 0;
        }   catch (DmlException e) {
            System.debug('Error while counting contacts: ' + e.getMessage());
            return 0;
        }
    }
    public static Set<Id> getContactByLastName(String lastName) {
        Set<Id> contactIds = new Set<Id>();
        try {
            List<Contact> contacts = [SELECT Id, AccountId, FirstName, LastName, Email, Phone FROM Contact WHERE LastName = :lastName];
            for (Contact c : contacts) {
                contactIds.add(c.Id);
            }
            return contactIds;
        } catch (QueryException e) {
            System.debug('No contacts found with the last name: ' + lastName);
            return contactIds;
        } catch (DmlException e) {
            System.debug('Error while retrieving contacts: ' + e.getMessage());
            return contactIds;
        }
    }

    /*
    1. Create a static method within this class. Name it "createContacts"
        - input parameters: numberOfContacts, contactName, accountName
        - the method should create an amount of Contacts specified by the numberOfContacts parameter 
        - the Contacts should be related to an Account that has a Name equal to the accountName parameter value. For the relation use standard field
        - the Contacts' names should consist of contactName + order number. For example, if contactName equals "Doe" and the numberOfContacts is 3, the Contacts' names would be Doe1, Doe2, Doe3 (or Doe0, Doe1, Doe2, depending how You start counting)
        - save the Contacts in the database
    2. Create a static method called "deleteContact"
        - input parameters: contactId
        - the method should delete a Contact that has Id equal to contactId
        - implement error handling - if contact with the Id doesn't exist return 'No contact found' string. If it exists, delete it and return 'Success' string 
        - try to catch specific error type instead of generic Exception
    3. Create a static method called "getNumberOfContacts"
        - input parameters: accountName
        - return a number of contacts associated with the Account that has Name equal to accountName
    4. Create a static method called "getContactByLastName"
        - input parameters: lastName
        - query for contacts with a LastName equal to the value of lastName. The fields to retrieve: accountId, first and last name, email and phone number
        - return a Set of found contact Ids
    */
}