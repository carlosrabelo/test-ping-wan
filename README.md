# test-ping-wan

Este script foi criado para ser executado no cron do pfSense, um sistema operacional de firewall baseado em FreeBSD. Ele lida com problemas de conectividade de rede, utilizando o ping para verificar a disponibilidade de determinados endereços IP.

O script é escrito na linguagem de script Shell e pode ser agendado para ser executado periodicamente pelo cron do pfSense.

Na inicialização, são definidos os endereços IP a serem pingados e a interface de rede a ser monitorada. Além disso, uma variável de contador é estabelecida para controlar o número de iterações.

Dentro do loop principal, o script itera sobre cada endereço IP na lista e executa o comando ping para enviar uma única solicitação de eco ICMP para o endereço. A saída e as mensagens de erro são redirecionadas para /dev/null para evitar a exibição desnecessária de informações no console.

Se o ping for bem-sucedido (código de saída 0), o script é finalizado com um status de 0, indicando uma conexão bem-sucedida. Isso é útil para garantir que o pfSense esteja ciente da conectividade de rede durante a execução.

Se todos os endereços IP falharem em responder ao ping, o script verifica o valor do contador. Se for menor ou igual a 1, o script executa uma série de comandos para redefinir a interface de rede. Ele desativa a interface usando o comando /sbin/ifconfig, aguarda 5 segundos utilizando sleep e, em seguida, reativa a interface. Essa sequência de comandos tem como objetivo resolver problemas temporários de conectividade.

Se o contador atingir 2 (indicando múltiplas tentativas sem sucesso), o script executa o comando /sbin/shutdown -r now para reiniciar o sistema pfSense. O status de saída do script é definido como 1, indicando uma falha na conexão.

Após cada iteração, o contador é incrementado em 1. O loop continua até que o contador atinja o valor máximo de 2.

Este script é especialmente útil no contexto do pfSense, permitindo a detecção e o tratamento de problemas de conectividade de rede de forma automática. Ele pode ser personalizado modificando os endereços IP, a interface de rede e as ações executadas durante as falhas de conexão.

Para utilizar o script no pfSense, agende sua execução no cron, garantindo que ele seja executado regularmente para monitorar e solucionar problemas de conectividade de rede.
