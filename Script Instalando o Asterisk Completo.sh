#!/bin/bash
#
# Website     : http://vmzsolutions.com.br
# Autor       : Vitor Mazuco <contato@vmzsolutions.com.br> -------------------------------------------------------------------------------------------------------------------
#  Esse script instala o Asterisk 13.10 em sistemas operacionais Debian 7/8 e Ubuntu Server 14/16, juntamente com o Dahdi em versão estável e o libpri.

# VMZ Solutions - Soluções em Telefonia Open Sources

echo ""
echo "Instalando Pacotes e Dependências - Completo"
echo ""

# Instalando todas as depedencias necessárias para o Asterisk 13. 
apt-get install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r) libsqlite3-dev uuid-dev git-core subversion libjansson-dev sqlite autoconf automake libtool libncurses5-dev -y

echo ""
echo "Limpando o Ubuntu/Debian"
echo ""

# Lipando todos os programas obsoletos do sistema operacional.
apt-get autoremove -y && apt-get autoclean -y

echo ""
echo "Install lib DAHDI"
echo ""

# Entrando do diretório */usr/src*
cd /usr/src/

# Baixando o Dahdi na versão 2.10.2 
wget downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-2.10.2+2.10.2.tar.gz

# Descompactando o Dahdi
tar zxvf dahdi-linux-complete*

# Entrando no diretório do Dahdi 
cd dahdi-linux-complete*

# Instalando o Driver Dahdi
make && make install && make config

echo ""
echo "Instalando o libpri na versão 1.4"
echo ""

# Entrando do diretório */usr/src*
cd /usr/src/

# Baixando a versão 1.4 do LibPri
wget downloads.asterisk.org/pub/telephony/libpri/old/libpri-1.4.15.tar.gz  

# Descompactando o libpri
tar zxvf libpri*

# Entrando no diretório libpri 
cd libpri*

# Instalando o libpri
make && make install 

echo ""
echo "Instalando o Asterisk 13.10 em Ubuntu/Debian"
echo ""

# Entrando do diretório */usr/src*
cd /usr/src/

# Baixando a versão 13.10 do Asterisk
wget downloads.asterisk.org/pub/telephony/asterisk/old-releases/asterisk-13.10.0.tar.gz

# Descompactando o Asterisk
tar zxvf asterisk*  

# Entrando no diretório Asterisk
cd asterisk* 

#  Compilação e instalação completa do Asterisk
./configure &&  make menuselect && make && make install && make config

#  Criando exemplos de Arquvios de configurações do Asterisk em /etc/asterisk como sip.conf, extensions.conf, entre todos os outros.(comando opcional) 
make samples && cd 

echo ""
echo "Iniciando os drivers DAHDI"
echo ""

# Iniciando o Dahdi no sistema operacional
/etc/init.d/dahdi start

echo ""
echo "Iniciando o Asterisk e entrando no modo CLI"
echo ""

# Iniciando o Asterisk 13
/etc/init.d/asterisk start

# Entrando em modo verbose do Asterisk
#asterisk -vvvvvvc
asterisk -vvvvvvvvvvvvr

