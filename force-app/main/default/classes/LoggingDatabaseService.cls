public class LoggingDatabaseService extends DatabaseService {

    public LoggingDatabaseService() {
        super();
    }

    public DML.Result[] insertWithLogs(List<SObject> objects) {
        DML.Result[] results = super.insertRecords(objects);
        Integer index = 0;

        for(DML.Result dr : results) {

        
            if(dr.success) {
                dr.dmlType = null;
                Database.SaveResult dsr = (Database.SaveResult)JSON.deserialize(JSON.serialize(dr, true), Database.SaveResult.class);
                Logger.info('Record inserted', dsr);
            } 
            else {

                dr.dmlType = null;
                Database.SaveResult dsr = (Database.SaveResult)JSON.deserialize(JSON.serialize(dr, true), Database.SaveResult.class);

                Logger.error('Insert record failed',dsr).setRecord(objects[index]).setRecord(objects[index]);
            }
            index++;
        }

        return results;

    }

}