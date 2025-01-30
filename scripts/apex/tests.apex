MyTest.test1('tata');
MyTest.test2();


MyTest.test3('AllOrNone', 20);


Logger.debug('Nb Records Found ' + [SELECT Count(Id) nbRecords FROM Account WHERE Name LIKE 'titi%'][0].get('nbRecords'));
Logger.SaveLog();



MyTest.test3('fred with class',10,false);


Logger.info('Testing 123').addTag('A Tag').addTag('A second Tag');
Logger.saveLog();


MyTest.initialTransaction();

MyTest.test1bis('Test2');



MyTest.testHttpPost();

MyTest.scenario1();

MyTest.testMessage();
