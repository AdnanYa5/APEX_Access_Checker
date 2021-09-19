public with sharing class AccessCheckUtility {
    public static AccessCheckWrapper checkAccess(String sObjectName, AccessType access, List<SObject> sobjectList){
        AccessCheckWrapper acw = new AccessCheckWrapper();
        SObjectAccessDecision securityDecision = Security.stripInaccessible(access, sobjectList);
        if(securityDecision.getRemovedFields().get(sObjectName) != null){
            acw.inAccessibleFields = String.join((Iterable<String>)securityDecision.getRemovedFields().get(sObjectName), ', '); 
        }
        acw.records = securityDecision.getRecords();
        return acw;
    }
}
