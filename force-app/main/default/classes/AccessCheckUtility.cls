public with sharing class AccessCheckUtility {
    public static AccessCheckWrapper1 checkAccess(String sObjectName, AccessType access, List<SObject> sobjectList){
        AccessCheckWrapper1 acw = new AccessCheckWrapper1();
        SObjectAccessDecision securityDecision = Security.stripInaccessible(access, sobjectList);
        if(securityDecision.getRemovedFields().get(sObjectName) != null){
            acw.inAccessibleFields = String.join((Iterable<String>)securityDecision.getRemovedFields().get(sObjectName), ', '); 
        }
        acw.records = securityDecision.getRecords();
        return acw;
    }

    public with sharing class AccessCheckWrapper1 {
        public String inAccessibleFields{get; set;}
        public List<SObject> records{get; set;}
    }
}
