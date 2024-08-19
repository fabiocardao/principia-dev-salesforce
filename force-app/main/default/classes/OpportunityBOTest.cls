@IsTest
public class OpportunityBOTest {

    @IsTest
    static void testValidarDuplicada_NoDuplicate() {
        // Criação de Conta de Teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Criação de Oportunidades de Teste - Sem Duplicatas
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 100000,
            Tipo__c = 'A'
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount.Id,
            StageName = 'Demonstração de Valor',
            CloseDate = Date.today().addDays(30),
            Amount = 200000,
            Tipo__c = 'B'
        );

        insert new List<Opportunity> { opp1, opp2 };

        // Chamando o método para validar duplicatas
        OpportunityBO.validarDuplicada(new List<Opportunity>{opp1, opp2});
    }

    @IsTest
    static void testValidarDuplicada_WithDuplicate() {
        // Criação de Conta de Teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Criação de Oportunidade Inicial
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 300000,
            Tipo__c = 'A'
        );
        insert opp1;

        // Criação de uma nova oportunidade com o mesmo Tipo e Etapa - Deve ser identificada como duplicada
        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 400000,
            Tipo__c = 'A'
        );

        Test.startTest();
        // Chamando o método para validar duplicatas
        OpportunityBO.validarDuplicada(new List<Opportunity>{opp2});
        Test.stopTest();

        // Verificar se a duplicidade foi identificada corretamente
        System.assertEquals(1, opp2.getErrors().size(), 'O segundo registro deve ter um erro de duplicidade.');
    }

    @IsTest
    static void testValidarDuplicada_MultipleAccounts() {
        // Criação de Contas de Teste
        Account testAccount1 = new Account(Name = 'Test Account 1');
        Account testAccount2 = new Account(Name = 'Test Account 2');
        insert new List<Account>{testAccount1, testAccount2};

        // Criação de Oportunidades - Diferentes Contas, Mesma Etapa e Tipo
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount1.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 500000,
            Tipo__c = 'A'
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount2.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 600000,
            Tipo__c = 'A'
        );

        insert new List<Opportunity>{opp1, opp2};

        // Chamando o método para validar duplicatas
        OpportunityBO.validarDuplicada(new List<Opportunity>{opp1, opp2});

        // Verificar que não houve erros de duplicidade
        System.assertEquals(0, opp1.getErrors().size(), 'A primeira oportunidade não deve ter erro.');
        System.assertEquals(0, opp2.getErrors().size(), 'A segunda oportunidade não deve ter erro.');
    }

    @IsTest
    static void testValidarDuplicada_ClosedStage() {
        // Criação de Conta de Teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Criação de Oportunidades - Uma das quais em etapa Encerrada
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            StageName = 'Encerrado',
            CloseDate = Date.today().addDays(30),
            Amount = 100000,
            Tipo__c = 'A'
        );

        Opportunity opp2 = new Opportunity(
            Name = 'Test Opportunity 2',
            AccountId = testAccount.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 200000,
            Tipo__c = 'A'
        );

        insert new List<Opportunity>{opp1, opp2};

        // Chamando o método para validar duplicatas
        OpportunityBO.validarDuplicada(new List<Opportunity>{opp2});

        // Não deve haver erro, pois opp1 está em etapa 'Encerrado'
        System.assertEquals(0, opp2.getErrors().size(), 'O segundo registro não deve ter erro.');
    }

    @IsTest
    static void testValidarDuplicada_NullTipo() {
        // Criação de Conta de Teste
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Criação de Oportunidade sem o campo Tipo__c preenchido
        Opportunity opp1 = new Opportunity(
            Name = 'Test Opportunity 1',
            AccountId = testAccount.Id,
            StageName = 'Abordagem Inicial',
            CloseDate = Date.today().addDays(30),
            Amount = 100000
        );

        insert opp1;

        // Chamando o método para validar duplicatas
        OpportunityBO.validarDuplicada(new List<Opportunity>{opp1});

        // Não deve haver erro, pois Tipo__c é nulo
        System.assertEquals(0, opp1.getErrors().size(), 'O registro não deve ter erro pois o campo Tipo__c é nulo.');
    }
}