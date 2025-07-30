public class ContactTriggerHandler {
    private static final Integer HUNDRED = 100;
    // if DummyJSON_Id__c is null, generate a random number between 0 and 100 and set this as the contact's DummyJSON_Id__c value
    public static void dummyJSONIdHandler(List<Contact> newList){
        for (Contact con : newList) {
            if (con.DummyJSON_Id__c == null) {
                con.DummyJSON_Id__c = String.valueOf(Integer.valueOf(Math.random()*100));
            }
        }
    }
    // if DummyJSON_Id__c is less than or equal to 100, call the getDummyJSONUserFromId API
    public static void callGetDummyJSONUserFromId(List<Contact> newList){
        for (Contact con : newList) {
            if (Integer.valueOf(con.DummyJSON_Id__c) <= HUNDRED
                && con.ContactInvoked__c == false) {
                System.enqueueJob(new DummyJSONCallout(con.DummyJSON_Id__c, null));
            }
        }
    }
    // if DummyJSON_Id__c is greater than 100, call the postCreateDummyJSONUser API
    public static void callPostCreateDummyJSONUser(List<Contact> newList){
        for (Contact con : newList) {
            if (Integer.valueOf(con.DummyJSON_Id__c) > HUNDRED
                && con.ContactPosted__c == false) {
                System.enqueueJob(new DummyJSONCallout(null, con.Id));
            }
        }
    }
}