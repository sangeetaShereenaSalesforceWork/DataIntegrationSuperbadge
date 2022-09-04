@isTest
public class TestDataFactory 
{
    //Create a method for data creation
    public static void setupdata()
    {
        ServiceTokens__c mytoken = new ServiceTokens__c();
    	mytoken.Name ='ProjectServiceToken';
    	mytoken.Token__c = 'TestToken';
        insert mytoken;
        
        Account acct = new Account();
      	acct.Name='test Account';
      	insert acct;
        
        List<Opportunity> oppsToInsert = new List<Opportunity>();
        Opportunity opp1 = new Opportunity();
      	opp1.Name = 'Opp1';
        opp1.Type='New Customer';
        opp1.AccountId = acct.id;
        opp1.amount=500;
        opp1.CloseDate = date.today();
        opp1.StageName = 'Resubmit Project';
        oppsToInsert.add(opp1);
          
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Opp2';
        opp2.Type='New Customer';
        opp2.AccountId = acct.id;
        opp2.amount=2500;
        opp2.CloseDate = date.today().addDays(-3);
        opp2.StageName = 'Prospecting';
        oppsToInsert.add(opp2);

        insert oppsToInsert;
    }
 		
}