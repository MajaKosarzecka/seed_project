//update contact - kiedys mial AccountId a teraz ktoś chce zmienic AccountId na null - wtedy error

public class ContactTriggerHandler {
    public static void beforeUpdate(List<Contact> newContacts, Map<Id, Contact> oldContacts) {
        for (Contact newContact : newContacts) {
            Contact oldContact = oldContacts.get(newContact.Id);

            if (newContact.AccountId == null && oldContact.AccountId != null) {
                newContact.addError('Unable to remove account field value');
            }
        }

        provideEmailOrPhone(newContacts);
    

    }

    public static void beforeInsert(List<Contact> newContacts) {
        provideEmailOrPhone(newContacts);
    }

    public static void afterInsert(List<Contact> newContacts) {
        List<Contact_History__c> contactHistory = new List<Contact_History__c>();

        for (Contact contact : newContacts) {
            contactHistory.add(new Contact_History__c(
                Contact__c = contact.Id,
                Name = 'Insert' + contact.FirstName + ' ' + contact.LastName + ' ' + contact.Id,
                Action__c = 'Insert',
                Timestamp__c = System.now()
            ));
        }
        if (!contactHistory.isEmpty()) {
            insert contactHistory;
        }
    }

    public static void afterDelete(List<Contact> oldContacts) {
        List<Contact_History__c> contactHistory = new List<Contact_History__c>();

        for (Contact contact : oldContacts) {
            contactHistory.add(new Contact_History__c(
                Name = 'Delete' + contact.FirstName + ' ' + contact.LastName + ' ' + contact.Id + ' ' + Datetime.now().getTime(),
                Action__c = 'Delete',
                Timestamp__c = System.now()
            ));
        };
         if (!contactHistory.isEmpty()) {
            insert contactHistory;
        }
    }

    public static void afterUpdate(List<Contact> newContacts, Map<Id, Contact> oldContacts) {
        List<Contact_History__c> contactHistory = new List<Contact_History__c>();

        for (Contact newContact : newContacts) {
            contact oldContact = oldContacts.get(newContact.Id);

            Map<String, Object> oldValues = new Map<String, Object>{
                'FirstName' => oldContact.FirstName,
                'LastName' => oldContact.LastName,
                'Email' => oldContact.Email,
                'Phone' => oldContact.Phone,
                'AccountId' => oldContact.AccountId
            };

            Map<String, Object> newValues = new Map<String, Object>{
                'FirstName' => newContact.FirstName,
                'LastName' => newContact.LastName,
                'Email' => newContact.Email,
                'Phone' => newContact.Phone,
                'AccountId' => newContact.AccountId
            };
            
        for (String keyName : oldValues.keySet()) {
            if (oldValues.get(keyName) != newValues.get(keyName)) {
                contactHistory.add(new Contact_History__c(
                    Contact__c = newContact.Id,
                    Name = newContact.FirstName + ' ' + newContact.LastName + ' ' + newContact.Id + 'Update',
                    Action__c = 'Update',
                    Timestamp__c = System.now(),
                    New_value__c = String.valueOf(newContact.get(keyName)),
                    Old_value__c = String.valueOf(oldContact.get(keyName)),
                    Edited_field_name__c = keyName
                ));
            };
        };

                
            };

        if (!contactHistory.isEmpty()) { 
            insert contactHistory;
            }
        }

    

    public static void provideEmailOrPhone(List<Contact> contactList) {
        for (Contact contactToInsert : contactList) {
            if (contactToInsert.Email == null && contactToInsert.Phone == null) {
                contactToInsert.addError('Please provide phone or email value');
            } 
        }
    }

    
}