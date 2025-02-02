Escrita de tags
=====================================================================================================

A princípio, existem dois modos possíveis para a escrita nos tags de comunicação no Elipse E3:

* Escrita síncrona
* Escrita assíncrona.

Esta configuração pode ser feita na propriedade WriteSyncMode do Driver, que é a propriedade que determina como as escritas serão enviadas para o I/O Server. Os valores disponíveis são:

    0 – wsmDefault: Modo síncrono (padrão).
    1 – wsmSync: Modo síncrono (manual).
    2 – wsmAsyncUnconfirmed: Modo assíncrono.

Da mesma forma, também é possível configurar o tipo de escrita nos parâmetros dos métodos Write e WriteEx, via scripts. Ao escrever um valor no setpoint de uma tela, a escrita acompanha o que está configurado em WriteSyncMode.

Tanto a escrita síncrona quanto a escrita assíncrona vão ocorrer logo após a interação que está sendo feita (leitura ou escrita); em nenhum dos casos será esperada a varredura completa (um ciclo de leitura) do driver. Nos dois casos, o tempo de operação (envio do dado e resposta do equipamento) é o mesmo.

Na escrita assíncrona (sem confirmação), o E3Run envia o valor para o I/O Server e não aguarda o retorno; neste tipo de escrita, assume-se sempre que a escrita funcionou. Logo após, a aplicação será liberada imediatamente para seguir sua operação natural.

Já na escrita síncrona (com confirmação), o E3Run envia o valor para o I/O Server e aguarda o retorno do equipamento para confirmar o valor e liberar a aplicação. Esta opção é padrão no driver de comunicação, e será aplicada automaticamente.