PRIORIZAÇÃO DE TAGS
=====================================================================================================

Normalmente, o driver requisita periodicamente (de acordo com o valor da propriedade Scan do tag) o valor de cada tag de comunicação.
Sempre que o valor ou a qualidade do tag for alterado, seu valor será repassado para o driver de comunicação.

Pode-se reservar um tempo menor de ciclo (scan) para as variáveis com necessidade de atualização mais veloz, e um tempo maior de ciclo para as variáveis com menos prioridade de atualização. Note, porém, que a performance da comunicação depende de uma série de outros fatores, incluindo o tipo de equipamento, o tipo de interface da comunicação utilizada, velocidade (baud rate), taxa de erros, etc.

Além disso, pode-se configurar a propriedade AdviseType como 0-AlwaysinAdvise, para que o valor do tag esteja sempre atualizado.