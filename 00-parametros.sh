#!/bin/bash
#=============================================================================================
#                       VARIÁVEIS UTILIZADAS NO SCRIPT: 20-guacamole.sh                      #
#=============================================================================================
#
# Arquivos de configuração (conf) do sistema Guacamole utilizados nesse script
# 01. /etc/guacamole/guacamole.properties = arquivo de configuração do serviço do Guacamole Server
# 02. /etc/guacamole/user-mapping.xml = arquivo de configuração do usuário e acesso remoto
# 03. /etc/default/tomcat9 = arquivo de configuração do serviço do Apache Tomcat
#
# Arquivos de monitoramento (log) do Serviço do Guacamole utilizados nesse script
# 01. sudo systemctl status tomcat9 = status do serviço do Tomcat Server
# 02. sudo systemctl status guacd = status do serviço do Guacamole Server
# 03. sudo journalctl -t guacd = todas as mensagens referente ao serviço do Guacamole
# 04. tail -f /var/log/syslog | grep -i guacamole = filtrando as mensagens do serviço do Guacamole
# 05. tail -f /var/log/syslog | grep -i guacd = filtrando as mensagens do serviço do Guacamole
#
# Declarando as variáveis utilizadas nas configurações do sistema de acesso remoto Guacamole
#
# Variável de download do Apache Guacamole (Links atualizados no dia 14/09/2023)
GUACAMOLESERVER="https://archive.apache.org/dist/guacamole/1.5.5/source/guacamole-server-1.5.5.tar.gz"
GUACAMOLECLIENT="https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-1.5.5.war"
GUACAMOLEJDBC="https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-auth-jdbc-1.5.5.tar.gz"
GUACAMOLETOTP="https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-auth-totp-1.5.5.tar.gz"
GUACAMOLEHISTORY="https://archive.apache.org/dist/guacamole/1.5.5/binary/guacamole-history-recording-storage-1.5.5.tar.gz"
#
# Variável de download do Conector do MySQL em Java do Apache Guacamole (Link atualizado no dia 14/09/2023)
# Link para pesquisar a versão: https://dev.mysql.com/downloads/connector/j/ 
# Link das versões antigas: https://downloads.mysql.com/archives/c-j/
GUACAMOLEMYSQL="https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-j_8.0.33-1ubuntu20.04_all.deb"
#
# OBSERVAÇÃO: NO SCRIPT: 15-GUACAMOLE.SH É UTILIZADO AS VARIÁVEIS DO MYSQL DE USUÁRIO E SENHA
# DO ROOT DO MYSQL CONFIGURADAS NO BLOCO DAS LINHAS: 366 até 371, VARIÁVEIS UTILIZADAS NO SCRIPT: 
# 07-lamp.sh LINHAS: 261 até 262
DATABASE_GUACAMOLE="guacamole"
CREATE_DATABASE_GUACAMOLE="CREATE DATABASE guacamole;"
CREATE_USER_DATABASE_GUACAMOLE="CREATE USER 'guacamole' IDENTIFIED BY 'guacamole';"
GRANT_DATABASE_GUACAMOLE="GRANT USAGE ON *.* TO 'guacamole';"
GRANT_ALL_DATABASE_GUACAMOLE="GRANT ALL PRIVILEGES ON guacamole.* TO 'guacamole';"
FLUSH_GUACAMOLE="FLUSH PRIVILEGES;"
#
# Variável das dependências do laço de loop do Guacamole Server e Client
GUACAMOLEDEP="tomcat9 tomcat9-admin tomcat9-user bind9 mysql-server mysql-common"
#
# Variável de instalação das dependências do Guacamole Server
# opção do caractere: \ (contra barra): utilizado para quebra de linha em comandos grandes
GUACAMOLEINSTALL="libcairo2-dev libjpeg-dev libpng-dev libtool-bin libossp-uuid-dev \
libavcodec-dev libavformat-dev libavutil-dev libswscale-dev freerdp2-dev libpango1.0-dev \
libssh2-1-dev libtelnet-dev libvncserver-dev libwebsockets-dev libpulse-dev libssl-dev \
libvorbis-dev libwebp-dev gcc-10 g++-10 make libfreerdp2-2 freerdp2-x11 libjpeg8-dev \
libjpeg-turbo8-dev build-essential"
#
# Variável do usuário de serviço do Guacamole Server
GUACAMOLEUSER="guacd"
GUACAMOLELIB="/var/lib/guacd/"
#
# Variável da porta de conexão padrão do Guacamole Server
PORTGUACAMOLE="4822"