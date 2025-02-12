public with sharing class Updater {
    
    private DatabaseUnitOfWork uow;

    private static Map<Id, SObject> updates;

    public Updater(DatabaseUnitOfWork uow) {
        this.uow = uow;
        updates = new Map<Id, SObject>();
    }

    public void add(SObject record) {
        
        if(!updates.containsKey(record.Id)) {
            updates.put(record.Id, record);
            uow.updateRecord(record);
        } else {
            SObject rec = updates.get(record.Id);
            for(String key : record.getPopulatedFieldsAsMap().keySet()) {
                rec.put(key, record.get(key));
            }
        }
    }
}