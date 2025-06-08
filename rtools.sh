#!/bin/bash

# Cores ANSI
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

# Ferramentas por categoria
declare -A categories
categories["Diagnóstico"]="ping traceroute mtr telnet netcat curl wget"
categories["Monitoramento"]="iftop nload iptraf bmon vnstat tcpdump"
categories["Interfaces"]="ip ifconfig ethtool nmcli iwconfig"
categories["DNS"]="dig nslookup host"
categories["Segurança"]="nmap arp-scan whois hping3 sslscan openssl"
categories["Complementares"]="ss netstat arp route"

# Comandos para cada ferramenta
declare -A tool_commands

# Diagnóstico
tool_commands["ping"]="ping google.com;ping -c 4 8.8.8.8"
tool_commands["traceroute"]="traceroute google.com;traceroute 8.8.8.8"
tool_commands["mtr"]="mtr google.com;mtr -rwzbc100 8.8.8.8"
tool_commands["telnet"]="telnet towel.blinkenlights.nl;telnet google.com 80"
tool_commands["netcat"]="nc -zv scanme.nmap.org 80;nc -lvp 1234"
tool_commands["curl"]="curl https://ifconfig.me;curl -I https://google.com"
tool_commands["wget"]="wget http://ipv4.download.thinkbroadband.com/10MB.zip;wget --spider google.com"

# Monitoramento
tool_commands["iftop"]="sudo iftop"
tool_commands["nload"]="sudo nload"
tool_commands["iptraf"]="sudo iptraf"
tool_commands["bmon"]="bmon"
tool_commands["vnstat"]="vnstat -d;vnstat -w"
tool_commands["tcpdump"]="sudo tcpdump -i any;sudo tcpdump port 80"

# Interfaces
tool_commands["ip"]="ip a;ip route"
tool_commands["ifconfig"]="ifconfig;ifconfig eth0"
tool_commands["ethtool"]="sudo ethtool eth0"
tool_commands["nmcli"]="nmcli dev status;nmcli con show"
tool_commands["iwconfig"]="iwconfig;iwconfig wlan0"

# DNS
tool_commands["dig"]="dig google.com;dig @8.8.8.8 google.com"
tool_commands["nslookup"]="nslookup google.com"
tool_commands["host"]="host google.com"

# Segurança
tool_commands["nmap"]="nmap 127.0.0.1;nmap -sS -p 1-1000 192.168.0.1"
tool_commands["arp-scan"]="sudo arp-scan --interface=eth0 --localnet"
tool_commands["whois"]="whois google.com"
tool_commands["hping3"]="sudo hping3 -S 192.168.0.1 -p 80 -c 3"
tool_commands["sslscan"]="sslscan google.com"
tool_commands["openssl"]="openssl s_client -connect google.com:443"

# Complementares
tool_commands["ss"]="ss -tulnp"
tool_commands["netstat"]="netstat -tulnp"
tool_commands["arp"]="arp -a"
tool_commands["route"]="route -n"

# Gera lista única de ferramentas
all_tools=()
for group in "${categories[@]}"; do
  for tool in $group; do
    all_tools+=("$tool")
  done
done

install_tool() {
  echo -ne "Instalando $1"
  for i in {1..3}; do echo -n "."; sleep 0.3; done
  echo
  if sudo apt install -y "$1"; then
    echo -e "${GREEN}[OK] Ferramenta $1 instalada com sucesso.${RESET}"
  else
    echo -e "${RED}[ERRO] Falha ao instalar $1.${RESET}"
  fi
}

manual_install_menu() {
  while true; do
    echo -e "\n${CYAN}Selecione uma ferramenta para instalar:${RESET}"
    idx=1
    for categoria in "${!categories[@]}"; do
      echo -e "${MAGENTA}--- $categoria ---${RESET}"
      for tool in ${categories[$categoria]}; do
        echo "[$idx] $tool"
        tool_index[$idx]="$tool"
        ((idx++))
      done
    done
    echo -e "${YELLOW}[0] Voltar${RESET}"
    read -p "Opção: " opt
    if [[ $opt == 0 ]]; then return; fi
    if [[ ${tool_index[$opt]} ]]; then
      install_tool "${tool_index[$opt]}"
    else
      echo -e "${RED}Opção inválida.${RESET}"
    fi
  done
}

auto_install_menu() {
  echo -e "\n${CYAN}Instalando todas as ferramentas...${RESET}"
  for tool in "${all_tools[@]}"; do
    install_tool "$tool"
  done
  echo -e "${GREEN}Todas as ferramentas foram instaladas.${RESET}"
}

install_menu() {
  while true; do
    echo -e "\n${BLUE}--- Menu de Instalação ---${RESET}"
    echo "[1] Instalar Manualmente"
    echo "[2] Instalar Todas Automaticamente"
    echo -e "${YELLOW}[0] Voltar${RESET}"
    read -p "Escolha uma opção: " choice
    case $choice in
      1) manual_install_menu ;;
      2) auto_install_menu ;;
      0) return ;;
      *) echo -e "${RED}Opção inválida.${RESET}" ;;
    esac
  done
}

use_tool() {
  tool="$1"
  IFS=';' read -ra commands <<< "${tool_commands[$tool]}"
  echo -e "\n${CYAN}Comandos para $tool:${RESET}"
  for i in "${!commands[@]}"; do
    echo "[$((i+1))] ${commands[$i]}"
  done
  echo "[C] Criar comando personalizado"
  echo -e "${YELLOW}[0] Voltar${RESET}"
  read -p "Escolha um comando para executar ou digite C para personalizado: " opt
  if [[ $opt == 0 ]]; then return; fi
  if [[ $opt == "C" || $opt == "c" ]]; then
    read -p "Digite o complemento do comando '$tool': " complemento
    custom_cmd="$tool $complemento"
    echo -e "\nExecutando: $custom_cmd\n"
    eval "$custom_cmd"
  else
    cmd_index=$((opt-1))
    if [[ ${commands[$cmd_index]} ]]; then
      echo -e "\nExecutando: ${commands[$cmd_index]}\n"
      eval "${commands[$cmd_index]}"
    else
      echo -e "${RED}Comando inválido.${RESET}"
    fi
  fi
}

use_tools_menu() {
  while true; do
    echo -e "\n${BLUE}--- Menu de Uso de Ferramentas ---${RESET}"
    idx=1
    for categoria in "${!categories[@]}"; do
      echo -e "${MAGENTA}--- $categoria ---${RESET}"
      for tool in ${categories[$categoria]}; do
        echo "[$idx] $tool"
        tool_index[$idx]="$tool"
        ((idx++))
      done
    done
    echo -e "${YELLOW}[0] Voltar${RESET}"
    read -p "Escolha uma ferramenta: " opt
    if [[ $opt == 0 ]]; then return; fi
    if [[ ${tool_index[$opt]} ]]; then
      use_tool "${tool_index[$opt]}"
    else
      echo -e "${RED}Opção inválida.${RESET}"
    fi
  done
}

banner() {
  clear
  echo -e "${RED}█████╗${RESET}  T  O  O  L  S"
  echo -e "${RED}██╔══██╗${RESET}  T  O  O  L  S"
  echo -e "${RED}███████║${RESET}  T  O  O  L  S"
  echo -e "${RED}██╔══██║${RESET}  T  O  O  L  S"
  echo -e "${RED}██║  ██║${RESET}  T  O  O  L  S"
  echo -e "${RED}╚═╝  ╚═╝${RESET}  T  O  O  L  S"
}

main_menu() {
  while true; do
    banner
    echo -e "\n${BLUE}=== MENU PRINCIPAL ===${RESET}"
    echo "[1] Instalar Ferramentas"
    echo "[2] Utilizar Ferramentas"
    echo -e "${YELLOW}[0] Sair${RESET}"
    read -p "Escolha uma opção: " choice
    case $choice in
      1) install_menu ;;
      2) use_tools_menu ;;
      0) echo "Saindo..."; exit 0 ;;
      *) echo -e "${RED}Opção inválida.${RESET}" ;;
    esac
  done
}

main_menu
