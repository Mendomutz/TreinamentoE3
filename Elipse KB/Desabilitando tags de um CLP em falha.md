Desabilitando tags de um CLP em falha
=====================================================================================================

Em uma rede serial, é possível utilizar um único driver para comunicação com diversos equipamentos; dependendo do protocolo utilizado, seus tags são diferenciados apenas pelo valor do parâmetro N1 de cada tag.

Quando há uma falha de comunicação com um determinado equipamento (o que pode ser normal em uma grande rede), o driver continuará tentando ler os tags deste equipamento, e a demora ou falha na resposta causa lentidão na aplicação, o que pode ser erroneamente interpretado como um travamento.

Este artigo apresenta uma aplicação exemplo que desabilita a leitura dos tags de um equipamento quando este permanece em falha por um determinado tempo. A aplicação possui um tag de controle por cada equipamento; quando a qualidade de um dos tags não for boa, será iniciado um contador que verificará sua qualidade periodicamente. Caso a qualidade permaneça ruim após um determinado tempo, a leitura de todos os tags referentes ao equipamento será desabilitada.

O aplicativo busca três tags de comunicação e um bloco com dois elementos, de dois equipamentos distintos. O driver de comunicação utilizado no exemplo é o driver Modicon Modbus Master. Para simular os equipamentos, pode-se utilizar qualquer simulador Modbus que possibilite simular mais de um equipamento com IDs diferentes.

Neste aplicativo, a conexão do driver foi feita via ethernet (devido ao simulador utilizado, o que não interfere na solução proposta). Foi utilizado o simulador MOD_RSSIM, que está em anexo e pode ser baixado também deste site. [Desabilitando tags de um CLP em falha](https://kb.elipse.com.br/desabilitando-tags-de-um-clp-em-falha/)

Foi desenvolvida também uma biblioteca (desabilitaleituraemerro.lib) que contém apenas um XObject, chamado xoDisable. Nele estão os scripts para habilitar e desabilitar as leituras. Para cada equipamento a ser controlado, deve ser adicionada uma instância do xoDisable no servidor de dados (pasta de dados).

As seguintes propriedades do xoDisable devem ser preenchidas a cada instância adicionada no projeto principal:

* AppDriver: 
    Driver ao qual o equipamento pertence

* BancoDeDados:
    Objeto banco de dados onde serão gravadas mensagens de leitura desabilitada ou habilitada

* IDEquip:
    Identificação do equipamento na rede (valor do parâmetro N1 no driver de comunicação)

* Tabela:
    Nome da tabela onde serão gravados os eventos de leitura desabilitada ou habilitada

* TagdeControle:
    Tag utilizado para verificar se a comunicação está em falha.
    Este é o único tag onde a leitura não será desabilitada quando em falha

* ValorPreset:
    Intervalo de tempo (em segundos) no qual ocorre a verificação da comunicação quando está em falha

Para habilitar o tag contador da instância do xoDisable referente ao equipamento (N1) em falha, é preciso adicionar um script ao evento OnCommError do driver. Exemplo:

Codigo no Elipse E3:
-----------------------------------------------------------------------------------------------------

    Sub Driver_OnCommError(EvtType, Size, Element, N1, N2, N3, N4)
        'Script que verifica qual o N1 do tag com erro e habilita um contador.
        IF N1 = 1 THEN
            Application.GetObject("Dados.xoDriver1").TagContador.Enabled = True
        ELSEIF N1 = 2 THEN
            Application.GetObject("Dados.xoDriver2").TagContador.Enabled = True
        end if
    End Sub

Para utilizar esta aplicação, siga estes procedimentos:

1. Execute um simulador Modbus que simule dois CLPs na porta 502, ou então utilize dois CLPs, com IDs de rede 1 e 2, e que contenham variáveis do tipo Holding Register com endereços de 1 a 5.

2. Abra o aplicativo em modo de edição, confira o IP de conexão do driver e execute o aplicativo.

3. No simulador Modbus, desabilite apenas uma variável (de controle) de um dos CLPs, ou então desabilite totalmente um dos CLPs simuladores.

4. Aguarde a contagem de tempo no Elipse E3 e verifique se a leitura dos outros tags é desabilitada.

5. Habilite novamente a variável ou CLP que foi desabilitado anteriormente.

6. As leituras serão restabelecidas após uma leitura da variável de controle com boa qualidade.

OBS:
-----------------------------------------------------------------------------------------------------

A aplicação exemplo foi desenvolvida no Elipse E3 versão 4.6 build 162