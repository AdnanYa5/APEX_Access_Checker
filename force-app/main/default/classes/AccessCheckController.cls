public with sharing class AccessCheckController {
    /*
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
    */
    @AuraEnabled
    public static List<Account> checkAccess(Id recordId){
            List<Account> accList2 = new List<Account>();
            for(Integer i=0; i<2; i++){
                Account a = new Account();
                a.Name = 'Test '+i;
                a.AnnualRevenue = (i+1)*1000;
                a.BillingStreet = 'Kavanagh Street'+i;
                accList2.add(a);
            }
            AccessCheckUtility.AccessCheckWrapper acw = AccessCheckUtility.checkAccess('Account', AccessType.CREATABLE, accList2);
            if(acw.inAccessibleFields != null){
                throw new AuraHandledException('User does not have access to fields ----- '+acw.inAccessibleFields);
            } else {
                insert acw.records;
                return acw.records;
            }
            /*
            AccessCheckWrapper acw = AccessCheckUtility.checkAccess('Account', AccessType.READABLE, [SELECT Id, AnnualRevenue from account where id=:recordId]);
            if(acw.inAccessibleFields != null){
                throw new AuraHandledException('User does not have access to fields - '+acw.inAccessibleFields);
            } else {
                return acw.records;
            }*/
            //acw.inAccessibleFields != null ? throw new AuraHandledException('User does not have read access to fields - '+acw.inAccessibleFields); : return acw.records;
        }

}
