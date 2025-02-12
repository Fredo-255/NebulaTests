public with sharing class TestUow {
    public static void testUpdate() {
        DatabaseUnitOfWork uow = new DatabaseUnitOfWork();
        Updater updater = new Updater(uow);

        Account acc = [SELECT Id FROM Account WHERE Name = 'Test3'];


        acc.Industry = 'Energy';
        updater.add(acc);
        
        acc.Industry = 'Other';
        updater.add(acc);
        
        uow.commitWork();
    }

}