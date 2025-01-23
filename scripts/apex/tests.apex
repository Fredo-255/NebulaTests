MyTest.test1('tata');
MyTest.test2();


MyTest.test3('Another Test', 20);


Logger.debug('Nb Records Found ' + [SELECT Count(Id) nbRecords FROM Account WHERE Name LIKE 'titi%'][0].get('nbRecords'));
Logger.SaveLog();


MyTest.test3('titi',5);