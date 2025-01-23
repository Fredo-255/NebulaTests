@isTest
public with sharing class MyTestTests {
    
    @isTest
    static void test1() {
        MyTest.test1('tata');
        // MyTest.test2();
    }

    @isTest
    static void test2() {
        MyTest.test2();
    }

    @isTest
    static void test3() {
        MyTest.test3('titi',5);
        Assert.areEqual(4, [SELECT Count(Id) nbRecords FROM Account][0].get('nbRecords'), 'Expected only 4 accounts to be created with name "titi____"');
    }
} 