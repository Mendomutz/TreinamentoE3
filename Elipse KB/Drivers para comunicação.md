Drivers para comunicação
=====================================================================================================

Para que a aplicação tenha uma boa performance de comunicação, devemos avaliar uma série de fatores, incluindo o tipo de equipamento, o tipo de interface da comunicação utilizada, velocidade (baud rate), taxa de erros, etc. Além disso, algumas opções podem ser configuradas no driver, para obter um melhor desempenho.

Propriedade WriteSyncMode do driver: 
-----------------------------------------------------------------------------------------------------
    
* Determina como as escritas serão enviadas para o IOServer (modo síncrono ou assíncrono).

* Se por ventura uma aplicação apresentar uma baixa performance na comunicação, esta propriedade pode ser alterada para o modo assíncrono sem confirmação.

* Na escrita assíncrona (sem confirmação), o E3Run envia o valor para o I/O Server e não aguarda o retorno; neste tipo de escrita, assume-se sempre que a escrita funcionou.

* Logo após, a aplicação será liberada imediatamente para seguir sua operação natural.

Propriedade WriteFeedBackMode do driver:
-----------------------------------------------------------------------------------------------------
    
* Esta propriedade permite controlar a confirmação, ou feedback, das escritas em Tags de Comunicação.

* É aplicável somente a Tags de Comunicação que possam ser lidos, ou seja, possuam a propriedade AllowRead em Verdadeiro.

* Portanto, em casos de baixa performance, esta propriedade pode ser alterada para 0 – wfWaitNextRead (a leitura do Tag de Comunicação é realizada normalmente na próxima varredura).

Propriedade EnableReadGrouping do driver:
-----------------------------------------------------------------------------------------------------

* Permite otimizações de leitura ou agrupamento automático de Tags de Comunicação.

* Esta propriedade não pode ser alterada com o driver de comunicação ativo.

* O valor padrão desta propriedade é Verdadeiro. A otimização de leitura só acontece se o driver de comunicação suportar este recurso.

* Importante ressaltar, que o agrupamento (EnableReadGrouping) no E3 requer que o equipamento suporte os limites estabelecidos.

* Há equipamentos, entretanto, que suportam limites inferiores.

* Para que o agrupamento dos tags funcione nestes casos, alguns drivers (como por exemplo o Driver Modicon Modbus Master (ASC/RTU/TCP)) permitem personalizar o limite máximo suportado de bytes de dados em cada comunicação.

No Driver Modbus, esta configuração pode ser realizada na opção Customize Max. PDU Size, já no Driver BACnet em Maximum number of properties per ReadPropertyMultiple request, e no Driver Allen Bradley DF1 em Max Message Bytes. Portanto, deve-se verificar se o driver possui essa possibilidade de configuração.

Pool de Processos IOServer:
-----------------------------------------------------------------------------------------------------

* Em aplicativos com centenas de Drivers, os recursos necessários para executar os processos IOServer para cada Driver podem esgotar a capacidade do sistema operacional.

* Nestes casos, pode ser necessário habilitar o Pool de Processos IOServer na aba Propriedades da configuração do Domínio.