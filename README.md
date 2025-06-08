Script de Gerenciamento de Ferramentas de Rede
Este script é uma solução prática para instalar e utilizar diversas ferramentas de rede diretamente pelo terminal. Ele facilita tanto a instalação manual ou automática das ferramentas quanto a execução rápida de comandos úteis para diagnóstico, monitoramento, segurança e análise de redes.

O que ele faz?
Permite instalar ferramentas essenciais de rede no seu sistema (como ping, traceroute, nmap, tcpdump, entre outras), tanto individualmente quanto todas de uma vez.

Oferece menus simples para você escolher a ferramenta que quer usar e executar comandos básicos pré-configurados, ou até criar comandos personalizados para rodar na hora.

Organiza as ferramentas em categorias como Diagnóstico, Monitoramento, Segurança, e Complementares, deixando o uso mais intuitivo.

Apresenta uma interface amigável via terminal, com cores para facilitar a leitura e navegação.

Por que usar este script?
Se você trabalha com administração de redes, segurança da informação, ou simplesmente gosta de ter um kit de ferramentas à mão, este script economiza seu tempo ao evitar instalações e buscas manuais. Além disso, o menu interativo ajuda a não precisar decorar todos os comandos — basta escolher o que quer fazer e executar.

Como usar
1- Clone este repositório para sua máquina:
git clone https://github.com/feaguilera/rtools.git
cd rtools

2- Dê permissão de execução para o script:
chmod +x rtools.sh

3- Execute o script:
./rtools.sh

4- No menu principal, escolha entre instalar ferramentas ou usá-las diretamente.

5- Se optar por instalar, pode instalar manualmente uma ferramenta de cada vez ou todas de uma vez.

6- Para usar, selecione a ferramenta e escolha o comando desejado, ou crie um comando personalizado.

Requisitos
Sistema Linux baseado em Debian/Ubuntu (devido ao uso do apt para instalação)

Permissões de sudo para instalar ferramentas e executar comandos que exigem privilégios

Conexão com a internet para baixar os pacotes

Ferramentas incluídas
Diagnóstico: ping, traceroute, mtr, telnet, netcat, curl, wget

Monitoramento: iftop, nload, iptraf, bmon, vnstat, tcpdump

Interfaces: ip, ifconfig, ethtool, nmcli, iwconfig

DNS: dig, nslookup, host

Segurança: nmap, arp-scan, whois, hping3, sslscan, openssl

Complementares: ss, netstat, arp, route

Personalização
Você pode facilmente adicionar novos comandos para qualquer ferramenta, alterando o array tool_commands dentro do script. Também pode adaptar o script para usar outros gerenciadores de pacotes conforme sua distribuição.

Contribuições
Se quiser sugerir melhorias, novas ferramentas ou comandos, fique à vontade para abrir uma issue ou enviar um pull request. Toda ajuda é bem-vinda!

![image](https://github.com/user-attachments/assets/3bfee137-a173-4d33-9d75-ecea69f7959d)

![3](https://github.com/user-attachments/assets/f1b92718-d035-4b67-9009-b04a94f462d0)
