public class ProjectCalloutService1 {
    /*
    public static Id OpportunityId1;// we have to use static here to access this variable in the below methods and claass
    
    @Invocablemethod(label = 'Update Opportunity' description = 'Callout PMS')
    public static void postOpportunityToPMS(List<Id> OpportunityId){
       
       Opportunity Opty = [SELECT Id, Name, Account.Name, CloseDate, Amount FROM Opportunity WHERE Id = : OpportunityId];
       
       String token = ServiceTokens__c.getValues('ProjectServiceToken').Token__c;
       
       JSONGenerator gen = JSON.createGenerator(true); // JSONGenerator class is used to format the JSON string
        gen.writeStartObject();
        gen.writeStringField('opportunityId', Opty.Id);
        gen.writeStringField('opportunityName', Opty.Name);
        gen.writeStringField('accountName', Opty.Account.Name);
        gen.writeStringField('closeDate', String.ValueOf(Opty.CloseDate).mid(0,10));
        gen.writeNumberField('amount', Opty.Amount);            
        gen.writeEndObject();  
        String jsonInput1= gen.getAsString();
        System.debug('jsonReq: ' + jsonInput1);
       //String jsonBody=json.serialize(jsonInput);
       //request.setBody(jsonBody);
       //System.debug('first:'+jsonBody);
       System.enqueueJob(new QueueablePMSCall(jsonInput1,Opty.id,token));
       
    }
    
    public class QueueablePMSCall implements System.Queueable, Database.AllowsCallouts{  
        
        private String jsonBody;
        private Id oid;
        private String token;
        public QueueablePMSCall(String body,String Id, String serviceToken){
            jsonBody= body;
            oid=Id;
            token = serviceToken;
        }
        public void execute(queueableContext qc){
                 callOutToPms(jsonBody,oid,token);   
        }
    }
    @future (callout=true)
    public static void callOutToPms(String jsonBody,Id oid, String token){
            System.debug('now call out');
        
            
            HttpRequest req= new HttpRequest();
            req.setMethod('POST');
        	req.setTimeout(60000);
        	//ServiceTokens__c token= ServiceTokens__c.getValues('ProjectServiceToken');
        	//String token = ServiceTokens__c.
            req.setEndpoint('callout:ProjectService');
            req.setHeader('Content-Type', 'application/json;charset=UTF-8');
            //req.setHeader( 'Authorization', 'Bearer ' + ServiceTokens__c.getValues('ProjectServiceToken').Token__c );
            req.setHeader('token', token);
            //System.debug(token.Token__c);
            req.setBody(JSON.serialize(jsonBody));
            //req.setBody(jsonBody);
            Http http=new http();
            HttpResponse res=http.send(req);
        System.debug('Error from ' + req.getEndpoint() + ' : ' + res.getStatusCode() + ' ' + res.getStatus());
        
        opportunity result=new opportunity(Id=oid);
        //System.debug('result: '+result);
        if (res.getStatusCode()==201){
                result.StageName='Submitted Project';
                system.debug('success post');
        }else{
                result.StageName='Resubmit Project';
                system.debug('failed post, need resubmit');
                System.debug(res.getBody());
        }
        update result;
    }
    
       /*public class jsonStr{
        Id opportunityId;
        String opportunityName;
        String accountName;
        date closeDate;
        double amount;
        public jsonStr(Id iId,String iOName,String iAName,date iCloseDate,double iAmount){
            opportunityId=iId;
            opportunityName=iOName;
            accountName=iAName;
            closeDate=iCloseDate;
            amount=iAmount;
        }
    }*/
}