public with sharing class AccessCheckController {
    @AuraEnabled
    public static List<Account> checkAccess(Id recordId){
            System.debug('recordId---'+recordId);
            List<Account> accList = [SELECT Id, AnnualRevenue from account where id=:recordId];
            SObjectAccessDecision securityDecision = 
            Security.stripInaccessible(AccessType.READABLE,
            accList);
            System.debug('removed Fields ---'+securityDecision.getRemovedFields().get('Account'));
            if(securityDecision.getRemovedFields().get('Account') != null){
                throw new AuraHandledException('User does not have read access to fields - '+String.join((Iterable<String>)securityDecision.getRemovedFields().get('Account'), ', '));
            } else {
                return securityDecision.getRecords();
            }
        }
}
