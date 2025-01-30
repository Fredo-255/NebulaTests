public with sharing class MyTest {
    public static void test1(String name) {

        Account acc = new Account(
            Name = name 
        );
        
        insert acc;
        Logger.finest('Account inserted').setRecord(acc);

        Logger.warn('Warning', acc);
        Logger.saveLog();
    }

    public static void test1bis(String name) {

        Account acc = new Account(
            Name = name 
        );
        
        Logger.info('Account logged').setRecord(acc);

        Logger.saveLog();
    }

    


    
    public static void test2() {

        Logger.error('Warning');

        Logger.saveLog();
    }

    public static void test3libra(String root, Integer nbAccs, Boolean allOrNone) {
        List<Account> accs = new List<Account>();
        Integer i = 0;
        do  {
            accs.add(new Account(
                Name = root + ' ' + ++i
            ));
        } while (i < nbAccs);

        LoggingDatabaseService ds = new LoggingDatabaseService();
        ds.AllOrNone(allOrNone); 

        DML.Result[] results;
        try {
            results = ds.insertWithLogs(accs);
        } 
        catch (DmlException e) {
            Logger.error('Exception raised', e).setRecord(accs[e.getDmlIndex(0)]);
            Logger.saveLog();
            throw e;
        }
        catch (Exception e) {
            Logger.error('Exception raised', e);
            Logger.saveLog();
            throw e;
        }
          
        Logger.saveLog();


    }


    public static void test3(String root, Integer nbAccs, Boolean allOrNone) {
        List<Account> accs = new List<Account>();
        Integer i = 0;
        do  {
            accs.add(new Account(
                Name = root + ' ' + ++i
            ));
        } while (i < nbAccs);


        Database.SaveResult[] srList = Database.insert(accs, allOrNone);

        Integer index = 0;

        for(Database.SaveResult sr : srList) {

        
            if(sr.success) {
                Logger.info('Record inserted', sr);
            } 
            else {
                Logger.error('Insert record failed',sr).setRecord(accs[index]);
            }
            index++;
        }
          
        Logger.saveLog();


    }

    public static void initialTransaction() {

        String transactionId = Logger.getTransactionId();
        Logger.info('starting transaction');

        futureMethod(transactionId);
        Logger.saveLog();
    }

    @future static void futureMethod(String initialTransactionId) {
        
        Logger.setParentLogTransactionId(initialTransactionId);

        Logger.info('in future method');
        Logger.saveLog();
    }


    public static void scenario1() {
        Logger.setScenario('A feature I really want to log');
        Logger.finest('A log I want to see');
        Logger.saveLog();
    }


    public static void testHttp() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:animals');
        req.setMethod('GET');
        HttpResponse res = http.send(req);

        LogEntryEventBuilder log = Logger.info('Animals callout GET');


        log.setHttpRequestDetails(req);
        res.setBody(JSON.serializePretty(JSON.deserializeUntyped(res.getBody())));
        log.setHttpResponseDetails(res);
        

        Logger.saveLog();
    }

    
    public static void testHttpPost() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:animals');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"name":"little elephant"}');

        HttpResponse res = http.send(req);

        LogEntryEventBuilder log = Logger.info('Animals callout POST');


        log.setHttpRequestDetails(req);
        res.setBody(JSON.serializePretty(JSON.deserializeUntyped(res.getBody())));
        log.setHttpResponseDetails(res);
        
        Logger.saveLog();
    }

    public static void SendEmail() {
        Logger.saveLog();
    }

    public static void testMessage() {
        String body = 'Hello World';
        String subject = 'Test email';


        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

        message.setPlainTextBody(body);
        message.setSubject(subject);

        message.setSaveAsActivity(false);
        message.setTargetObjectId('003KO000004ytuMYAQ');

        Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);



        if(results[0]?.isSuccess()) {
            Logger.info('Message sent to contact', '003KO000004ytuMYAQ');
            Logger.saveLog();
            return;
        } 
       Logger.error('Unable to send email to contact : ' + JSON.serialize(results[0].errors));
       Logger.saveLog();

    }



}