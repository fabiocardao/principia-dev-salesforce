public class OpportunityBO {
    public static void validarDuplicada(List<Opportunity> opportunities) {
        // Set para armazenar tipos de oportunidade por conta e etapa
        Set<String> existingOppTypes = new Set<String>();
        Set<String> existingAccountIds = new Set<String>();
    
        for (Opportunity opp : opportunities) {
            if (opp.StageName != 'Encerrado') {
                String key = opp.AccountId + '-' + opp.StageName + '-' + opp.Tipo__c;
                
                existingOppTypes.add(key);
                existingAccountIds.add(opp.AccountId);
            }
        }
        
        // Busca oportunidades existentes no banco de dados
        List<Opportunity> existingOpps = [
            SELECT Id, AccountId, StageName, Tipo__c
            FROM Opportunity 
            WHERE AccountId in :existingAccountIds
            AND StageName != 'Encerrado'
            AND Tipo__c != null
        ];
        
        for (Opportunity existingOpp : existingOpps) {
            String key = existingOpp.AccountId + '-' + existingOpp.StageName + '-' + existingOpp.Tipo__c;
            
            if (existingOppTypes.contains(key)) {
                for (Opportunity opp : opportunities) {
                    if (opp.Id != existingOpp.Id 
                            && opp.AccountId == existingOpp.AccountId 
                                && opp.StageName == existingOpp.StageName 
                                    && opp.Tipo__c == existingOpp.Tipo__c) {
                        opp.addError('Não é possível criar uma oportunidade enquanto houver outra do mesmo tipo estiver em andamento.');
                    }
                }
            }
        }
    }
}