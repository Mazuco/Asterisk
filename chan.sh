#!/bin/bash
#
# Website     : http://vmzsolutions.com.br
# Autor       : Vitor Mazuco <contato@vmzsolutions.com.br>
# Versão      : 1.0
# Data        : 16/11/16
# -------------------------------------------------------------------------------------------------------------------
#  Esse script instala o Chan Dongle (para modens GSM da Huwaei em Asterisk 13.x) 
#

echo ""
echo "Instalando Pacotes e Dependências - Completo"
echo ""

# Instalando todas as depedencias necessárias para o Chan Dongle. 
apt-get install unzip usb-modeswitch automake bison openssl libssl-dev libasound2-dev libc6-dev libnewt-dev libncurses5-dev zlib1g-dev zlib-bin gcc g++ make build-essential sox libtiff4-dev subversion -y 

echo ""
echo "Baixando o Chan Dongle"
echo ""

# Baixando o Chan Dongle dentro do diretório /usr/src 
cd /usr/src
wget https://github.com/oleg-krv/asterisk-chan-dongle/archive/asterisk13.zip
unzip asterisk13.zip

echo ""
echo "Instalando o Chan Dongle"
echo ""

cd asterisk-chan-dongle* # Entra dentro do diretório Chan Dongle 

# Começa a instalação 
aclocal
autoconf
automake -a

# Roda todos os scripts para o Asterisk 13 
./configure  
make # Compilando 
make install # Instalando 
cp etc/dongle.conf /etc/asterisk/ # Copiando o arquivo dongle.conf dentro do diretório Asterisk 

echo ""
echo "Restart o Asterisk e inicializando"
echo ""

# Asterisk Restart 
invoke-rc.d asterisk restart 
sudo asterisk -vvvvvvvvvvvvvvvr  
