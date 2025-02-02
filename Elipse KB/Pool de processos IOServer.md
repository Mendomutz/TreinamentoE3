Pool de processos IOServer
=====================================================================================================

Em aplicativos com centenas de Drivers, os recursos necessários para executar os processos IOServer para cada Driver podem esgotar a capacidade do sistema operacional. Nestes casos, pode ser necessário habilitar o Pool de Processos IOServer na aba Propriedadesda configuração do Domínio.

Quando este Pool está habilitado, cada processo IOServer pode executar mais de um Driver, economizando desta forma recursos do sistema operacional e permitindo que um aplicativo chegue a executar milhares de Drivers.

Apenas Drivers que suportam a criação de novas instâncias dinâmicas (Drivers compilados com o IOKit v2.0.6 ou superior) podem ser utilizados no Pool. Se um Driver que não tem este suporte é adicionado ao Pool, este Driver não é executado, ou seja, falha. Para estes casos, configure a propriedade DisableIOServerPool do IODriver para True para que o Driver execute fora do Pool, em um processo IOServer exclusivo.

Na aba Propriedades da configuração do Domínio, pode-se controlar o número máximo de processos IOServer no Pool, bem como o número máximo de Drivers que executam em cada IOServer.

Opções de comportamento do Pool de Processos IOServer:
| Drivers por processo | Numero maximo de processos | Comportamento do Pool |
|:--------------------:|:--------------------------:|:---------------------:|
|           O          |              M             |           1           |
|           N          |              O             |           2           |
|           N          |              M             |           3           |

1.
    À medida que os Drivers do aplicativo forem ativados, é criado um processo IOServer para cada Driver, até atingir o número máximo M. Depois deste ponto, cada novo Driver que for ativado é adicionado ao IOServer do Pool que contém a menor quantidade de Drivers

2.
    À medida que os Drivers do aplicativo forem ativados, o E3 os adiciona a um processo IOServer do Pool que ainda não tenha atingido o número máximo N de Drivers executando dentro dele. Se todos os processos do Pool estiverem no limite máximo, então um novo IOServer é adicionado ao Pool

3.
    À medida que os Drivers do aplicativo forem ativados, o E3 os adiciona a um processo IOServer do Pool que ainda não tenha atingido o número máximo N de Drivers executando dentro dele. Se todos os processos do Pool estiverem no limite máximo, o comportamento depende da quantidade de processos no Pool, e se o número de processos do Pool for menor que o máximo M, então um novo processo é adicionado ao Pool, caso contrário o Driver é adicionado no processo que tiver menos Drivers executando.

    NOTA: Neste modo, o número máximo de Drivers por processo (N) pode ser ultrapassado caso o número total de Drivers do aplicativo exceda N * M

NOTAS:

Ao agrupar Drivers em um mesmo processo IOServer, perde-se o isolamento entre estes Drivers. Desta forma, se ocorrer uma falha em um destes Drivers, o IOServer é fechado e todos os Drivers que executavam naquele IOServer têm de ser reiniciados. Existe um limite no número de Drivers que podem executar em um processo IOServer. Este limite depende de diversas variáveis, tais como o sistema operacional em uso, a quantidade de memória, threads e recursos que cada Driver específico está ocupando. Em linhas gerais, não se deve adicionar mais do que 100 Drivers em um único IOServer, sob pena de exceder os limites do sistema operacional.