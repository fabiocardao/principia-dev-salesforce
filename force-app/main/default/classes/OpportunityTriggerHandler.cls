public class OpportunityTriggerHandler {
    public static void handleBeforeInsert(List<Opportunity> opportunities) {
        OpportunityBO.validarDuplicada(opportunities);  
    }
}