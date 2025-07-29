public class SoqlLearning {

    public static List<Contact> getContactsWithAccountsFields() {
        return [SELECT Name, Email, Account.Name, Account.AnnualRevenue, Account.Industry FROM Contact LIMIT 100];
    }

    public static List<Contact> getContactsWithAccountsOwnersFields() {
        return [SELECT Name, Account.Name, Account.Owner.Name, Account.Owner.Email FROM Contact LIMIT 100];
    }

    public static List<Opportunity> getOpportunitiesWithDetails() {
        return [SELECT Name, StaageName, Account.Type, Account.OwnerUserRoleName,
                (SELECT Name, UnitPrice FROM OpportunityLineItems) FROM Opportunity LIMIT 100];
    }

    public static List<Account> getAccountRelaetedCases() {
        return [SELECT Name, (SELECT CaseNumber, Status, Priority FROM Cases) FROM Account LIMIT 100];
    }

    public ststic List<Account> getAccountsWithRecentOpportunities() {
        return [SELECT Name FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE CloseDate = LAST_N_DAYS:30)LIMIT 100];
    }
    }




// Write a static method for each of the following queries.
// Name them accordingly, for example getContactsWithAccountFields, getAccountsWithChildContacts etc. Return the query results. 

// 1. Query on Contact object. Select Name, Email. Select Name, AnnualRevenue and Industry of the related Account. 
// 2. Query on Contact object. Select Name. Select Name of the related Account and select the related Account's Owner's Name and Email. 
// 3. Query on Opportunity object. Select Name, StageName. Select the related Account's Type and the Account's Owner's UserRole's Name. 
//     Select the Opportunity's related OpportunityLineItems - their Name and UnitPrice. 
// 4. Query on Account object. Select Name. Select the Account's related Cases - their CaseNumber, Status and Priority. 
// 5.* Query on Account. Select only those that have related Opportunities where the CloseDate is within the last 30 days. 

// To test the queries easily and to see the related objects' fields properly, You can use Salesforce Inspector plugin in Chrome. Use the Data Export option. 
