![logo_principia](https://github.com/user-attachments/assets/2f6d1f80-864d-4a00-bff0-1fd3a715f5a5)

Este repositório foi criado exclusivamente para o processo seletivo da princípia, vaga Desenvolvedor Salesforce.
O teste segue abaixo.

# Teste Prático Desenvolvedor Salesforce
Um funil de vendas do SalesForce é organizado por Contas (clientes ativos) e
composto pelas etapas:

* Abordagem Inicial;
* Demonstração de Valor;
* Emissão de Proposta;
* Negociação Final;
* Análise de Compliance;
* Contrato Enviado;
* Encerrado.

Nesse funil, cada Oportunidade pode estar presente em qualquer uma das etapas do funil. Toda Oportunidade será classificada em tipo A, B ou C.

Uma determinada Conta pode ter várias Oportunidades associadas. Porém, não se pode permitir que a mesma Conta tenha duas Oportunidades do mesmo tipo coexistindo na mesma etapa do funil de vendas, exceto na etapa “Encerrado”.

Oportunidades com valor de venda maior que R$500.000,00 precisam passar por uma análise de Compliance antes de seguir para a etapa de “Contrato Enviado”, com o objetivo de evitar riscos financeiros.
O resultado da Análise de Compliance pode ser “Aprovada” ou “Reprovada”.

Com base nas informações acima:

1. Crie uma automação (Apex Class) para validar que a Oportunidade não é duplicada quando o usuário clicar no botão “Criar nova Oportunidade”. Se já houver outra Oportunidade do mesmo tipo em uma etapa aberta, a
seguinte mensagem deverá aparecer para o usuário:
“Não é possível criar uma oportunidade enquanto houver outra do mesmo tipo estiver em andamento.”

2. Utilizando funcionalidades nativas, low-code ou no-code do SalesForce, proponha e construa um processo para que as Oportunidades com mais de R$500.000,00 em valor de venda sejam obrigadas a passar por uma etapa
chamada “Análise de Compliance”, e só possam avançar para a etapa de “Contrato Enviado” se o resultado da Análise de Compliance for “Aprovada”.

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## Resultado esperado e requisitos
Utilize uma instância pessoal do SalesForce e disponibilize o seu projeto num repositório GitHub ou GitLab.

Crie um vídeo explicando a sua solução e compartilhe conosco o seu vídeo.
