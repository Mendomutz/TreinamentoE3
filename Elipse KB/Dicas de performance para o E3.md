DICAS DE PERFORMANCE PARA O E3
=====================================================================================================

Eventos WhileRunning
-----------------------------------------------------------------------------------------------------

Evite a utilização de scripts cíclicos. Algumas vezes, scripts desta natureza são utilizados a fim de realizar alguma animação em tela, ou de obter o valor atual de determinada propriedade ou equação.

Ao invés de criar um evento cíclico para realizar essas funções (o que pode gerar uma baixa performance no aplicativo), na maioria das vezes pode-se utilizar associações, que farão o mesmo papel sem prejudicar o sistema.

Isto acontece porque as associações só são verificadas quando o valor da fonte (ou propriedade) é alterado.

Caso não seja possível utilizar associações para implementar o desejado, é recomendável criar um evento de usuário que somente seja executado quando uma condição seja satisfeita.

Acessando objetos do Servidor através do Viewer
-----------------------------------------------------------------------------------------------------

Toda vez que o valor de um tag ou de uma propriedade do Servidor é solicitado por script no Viewer através do método Application.GetObject, é feita uma comunicação com o Servidor.

Portanto, quanto mais vezes for utilizado este método, maior será o número de comunicações entre o Viewer e o Servidor, o que refletirá em uma queda de performance.

Porém, existem algumas maneiras de reduzir o número de Application.GetObject. Por exemplo:

* Substitua equações do script por links quando possível
* Use tags (demo, interno, crono, timer) do Viewer em vez de tags do Servidor
* Crie propriedades nos XControls para acessar propriedades dos XObjects

Outra sugestão para otimizar este acesso aos dados é utilizar o comando Set para criar uma referência ao objeto, e copiar o valor da propriedade para uma variável interna no início do script. Veja os exemplos a seguir.

Maneira não indicada:

    If Application.GetObject("Dados.TagInterno1").Value <= 10 then
        Application.GetObject("Dados.TagInterno1").Value = Application.GetObject("Dados.TagInterno1").Value +1
    Else
        Application.GetObject("Dados.TagInterno1").Value = 0
    End if

Maneira indicada:    

    Set Tag1 = Application.GetObject("Dados.TagInterno1")     
    Dim Valor     
    Valor = Tag1.Value    
    If Valor <= 10 then               
        Tag1.Value = Valor +1     
    Else               
        Tag1.Value = 0     
    End if

Animações de tela
-----------------------------------------------------------------------------------------------------

Nunca sobreponha vários objetos do tipo Figura para criar animações. A maneira correta é usar apenas um objeto Figura, e criar uma associação na propriedade FileName.

E sempre que for necessário um tag demo para animar algum objeto de tela, é indicado utilizar um tag do Viewer, pois desta forma o Viewer não precisa acessar constantemente o Servidor a fim de buscar o valor deste tag.

E3Chart histórico
-----------------------------------------------------------------------------------------------------

Configure a consulta para retornar apenas os campos que serão utilizados no Chart.

Dê preferência à utilização da opção de consulta automática do E3Chart, pois ela retorna apenas os dados necessários, considerando-se os limites de tempo configurados nos eixos horizontais.

Figuras complexas
-----------------------------------------------------------------------------------------------------

Alguns arquivos de imagem possuem um nível de complexidade muito grande. Este é o caso dos arquivos WMF, que podem acarretar uma baixa performance em animações, especialmente com relação a preenchimento ou cor.

É sempre recomendável simplificar esses objetos, a fim de deixar suas animações mais leves. Também é preferível usar arquivos de imagem pequenos e compactados (por exemplo, PNG ou JPG), pois quanto maior o arquivo, mais demorado será a transferência deste para o Viewer remoto.

Por fim, use criteriosamente o recurso de transparência, especialmente em figuras muito grandes, pois este é um recurso que exige muito processamento.

Tamanho de scripts
-----------------------------------------------------------------------------------------------------

Evite scripts muito grandes, dando preferência a scripts pequenos e enxutos. Entretanto, cabe salientar que nem sempre o número de linhas é indicador de performance, pois algumas operações de apenas uma linha (como um script que faça uma escrita síncrona num tag de comunicação, ou um acesso a banco de dados, por exemplo) podem significar um tempo grande de processamento.

Desfragmentação
-----------------------------------------------------------------------------------------------------

Utilize a opção de desfragmentação dos arquivos pertencentes ao Domínio, especialmente em aplicações muito grandes. A compactação pode ser significativa, trazendo também benefícios a performance.

Alterando links entre objetos de tela e objetos do Servidor em runtime

Esta tarefa exige muito processamento do Viewer, pois o obriga desativar e reativar associações com objetos do Servidor.

O local ideal para efetuar alterações de links entre objetos de tela e objetos do Servidor é o evento OnPreShow das telas, pois neste instante os links dos objetos da tela ainda não foram ativados.

Comunicação
-----------------------------------------------------------------------------------------------------

Alguns pontos devem ser observados com relação à configuração da comunicação:

* EnableDeadBand: 
    * desabilite esta propriedade somente quando for imprescindível o recebimento por parte do E3 de todas as leituras executadas pelo driver (mesmo quando não houver alteração de valor), como por exemplo na aquisição de eventos digitais.

* Scan: 
    * deve-se configurar o scan dos tags levando-se em consideração a importância desta informação à lógica de aplicação.
    
    * Ou seja, é necessário priorizar tags cuja variação é maior ou cuja utilização seja mais importante, utilizando tempos de scan menores.
    
    * Outro ponto a ser considerado é o tipo de grandeza que está sendo tratada, adequando o scan ao tempo de variação desta grandeza (por exemplo, a leitura de uma temperatura ambiente).

* Time-out:
    * verifique a ocorrência de time-outs durante a comunicação. O time-out é um intervalo de tempo perdido pelo driver tentando comunicar-se sem resposta; muitas vezes, isto se deve a problemas de hardware, como conexão, cabo, ruído etc.
    
    * Nem sempre a utilização da opção de retentativas é a melhor solução, pois este recurso não está agindo na fonte do problema.

* Blocos:
    * sempre que possível, utilize tags do tipo bloco, para otimizar a comunicação com o equipamento.
    
    * Além disso, deve-se procurar agrupar os blocos de acordo com a sua utilização em tela.
    
    * E quando disponível pelo driver, utilize a opção de superblocos (propriedade EnableReadGrouping).

* Escritas Síncronas: 
    * só utilize escritas síncronas quando realmente necessário. Este tipo de escrita força o script a aguardar por uma confirmação do equipamento antes de prosseguir com a sua execução.
    
    * O E3 permite que mesmo escritas realizadas por script sejam assíncronas, ou seja, a escrita será feita sem esperar por uma confirmação do equipamento, usando a propriedade WriteSyncMode no driver de comunicação e SyncWrite no tag de comunicação OPC.

* AdviseType:
    * altere esta propriedade para a opção AlwaysInAdvise somente quando for imprescindível que o valor do tag seja atualizado o tempo todo.
    
    * Se não, deixe-a em AdviseWhenLinked, e o E3 se encarregará de ativar a comunicação do tag quando necessário.

* BlockMode:
    * essa propriedade do Grupo de Tags OPC controla o modo de ativação e desativação dos tags OPC. 
    * Quando habilitada, os tags OPC são primeiramente agrupados e logo após cadastrados no Servidor OPC (ao fim da ativação do grupo).
    
    * Quando desabilitada, os tags são cadastrados um a um no Servidor, na medida em que vão sendo ativados, o que é mais demorado.
    
    * Na desativação acontece o mesmo: com o BlockMode ligado, os tags são removidos em conjunto ao fim da desativação do grupo OPC.
    
    * Quando desligado, os tags são removidos um por um, na medida em que cada tag é desativado.

* Pool de Processos IOServer:
    * em aplicativos com centenas de Drivers, os recursos necessários para executar os processos IOServer para cada Driver podem esgotar a capacidade do sistema operacional.
    
    * Nestes casos, pode ser necessário habilitar o Pool de Processos IOServer na aba Propriedades da configuração do Domínio.

Históricos
-----------------------------------------------------------------------------------------------------

Ao configurar o histórico, defina índices para acelerar a velocidade das consultas feitas na tabela. 

Caso a aplicação possua um grande número de históricos, existem algumas dicas para melhorar sua performance:

* Criação de mais de um servidor DB:
    * separe históricos em diferentes servidores DB quando a aplicação possui muitos históricos, e estes executam um grande número de escritas no banco.

* Conexão com tabelas já existentes:
    * crie a estrutura dos históricos pelo E3 e depois reconfigure o histórico para conectar-se a uma tabela já existente.
    
    * Isto resumirá o número de operações realizadas pelo histórico para se conectar à tabela, otimizando sua inicialização.

Consultas
-----------------------------------------------------------------------------------------------------

Consultas no Viewer:
* sempre que houver necessidade de utilizar uma consulta por script no Viewer (através do método GetADORecordset), e os dados retornados forem estáticos, é aconselhável que essa consulta seja realizada apenas uma vez, e que os dados retornados por ela sejam armazenados em tags do Viewer.

Por exemplo:

    Set Consulta = Application.GetObject("Dados.Consulta1")     
    Set Tag = Application.Item("TagInterno1")     
    Tag.Value = Consulta.GetADORecordSet()

* Consultas assíncronas:
    * uma boa opção para acessar os dados de uma Consulta por script (que retornam muitos dados, ou mesmo várias consultas) é a utilização do método GetAsyncADORecordset.
    
    * Este método, diferentemente do método GetADORecordSet, não trava o script enquanto o resultado da consulta não for carregado.
    
    * Ao invés disso, a execução do script prossegue, e o resultado da consulta será retornado no evento OnAsyncQueryFinish.

Stored Procedures
-----------------------------------------------------------------------------------------------------

Algumas vezes, devido à complexidade da consulta desejada, pode ser vantajoso criar uma stored procedure no banco de dados, ficando a cargo do E3 somente a função de executá-la.

Assim, todo o processamento gerado por essa consulta estará separado do E3.

O artigo [KB-102503: Substituindo consultas do Elipse E3 por Stored Procedures no banco de dados](https://kb.elipse.com.br/substituindo-consultas-por-stored-procedures-no-banco-de-dados-do-elipse-e3/), exemplifica como substituir determinada consulta por uma Stored Procedure em um banco SQL Server.