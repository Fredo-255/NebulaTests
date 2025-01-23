public with sharing class MyTest {
    public static void test1(String name) {

        Account acc = new Account(
            Name = name 
        );
        
        insert acc;
        Logger.finest('Account inserted').setRecord(acc);

        Logger.warn('Warning', acc);
        //Logger.saveLog();
    }


    
    public static void test2() {

        Logger.error('Warning');

        Logger.saveLog();
    }

    public static void test3(String root, Integer nbAccs) {

        List<Account> accs = new List<Account>();
        Integer i = 0;
        do  {
            accs.add(new Account(
                Name = root + ' ' + ++i
            ));
        } while (i < nbAccs);

        
        Database.SaveResult[] srList = Database.insert(accs, false);

        for(Database.SaveResult sr : srList) {
            if(sr.isSuccess()) {
                Logger.finest('Record inserted', sr);
            } 
            else {
                Logger.error('Insert record failed', sr);
            }
        }
          
        Logger.saveLog();


    }
        
}