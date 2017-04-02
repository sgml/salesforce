public with sharing class AccountReviewControllerExample {
    //AccountId and the Account_Review__c object
    public Map<String, List<Account_Review__c>> recordMap {get;set;}
    public Integer listSize{get;set;}
    //Constructor for class
    public AccountReviewControllerExample(){
        //this.dummyRecordMap = new Map<Id,Milestone__c>([select id,name from Milestone__c]);
        List<Account_Review__c> reviewList = new List<Account_Review__c>([select id,account__c,account__r.name,year__c,quarter__c,accountrank__c from Account_Review__c order by account__c,accountrank__c asc]);
        System.debug(LoggingLevel.DEBUG,'ReviewList size is '+reviewList.size());
        String id='';
        List<Account_Review__c> accountList = new List<Account_Review__c>();
        recordMap = new Map<String, List<Account_Review__c>>();
        for(Account_Review__c ar: reviewList){
            System.debug(ar);
            
        }
        
        
        for(Account_Review__c ar: reviewList){
            System.debug('Current Id '+id);
            if(String.isEmpty(id) ){
                System.debug(LoggingLevel.DEBUG,'id is empty');
                id=ar.account__r.name;
                accountList.add(ar);
                System.debug(LoggingLevel.DEBUG,'AccountListSize = '+accountList.size());
            }
            else if(id.equalsIgnoreCase(ar.account__r.name)){
                System.debug(LoggingLevel.DEBUG,'id matches '+ar.account__r.name);
                accountList.add(ar);
                System.debug(LoggingLevel.DEBUG,'specificAccount list size  ='+accountList.size());
                System.debug(LoggingLevel.DEBUG,'AccountListSize = '+accountList.size());
            }
            else if(!id.equalsIgnoreCase(ar.account__r.name) && id!=null){
                System.debug(LoggingLevel.DEBUG,'existing Id != or null ar.account'+ar.account__c + ' id='+id);
                recordMap.put(id, accountList);
                System.debug(LoggingLevel.DEBUG,'AccountListSize = '+accountList.size());
                accountList.clear();
                id=ar.account__r.name;
                accountList.add(ar);
                
            }
            else{
                recordMap.put(id,accountList);
                System.debug(LoggingLevel.DEBUG,'AccountListSize = '+accountList.size());
                
            }
            
        }recordMap.put(id,accountList);
    }
}