#!/bin/bash

CTID=200 # Substitua pelo ID do seu contêiner
TEMPLATE_NAME="custom-ubuntu-2204"
STORAGE="SSD_NEW" # Substitua pelo seu storage
IP="192.168.0.2/24" # Substitua pelo IP desejado e máscara de sub-rede
GATEWAY="192.168.0.11" # Substitua pelo gateway correto
DNS="8.8.8.8" # Substitua pelos servidores DNS desejados

# Passo 1: Criar e personalizar o contêiner
pct create $CTID $STORAGE:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst --hostname meu-container --password secret --net0 name=eth0,bridge=vmbr0,ip=$IP,gw=$G>

# Passo 2: Instalar pacotes e configurar o contêiner
pct exec $CTID -- apt update
pct exec $CTID -- apt upgrade -y
pct exec $CTID -- apt install -y sudo openssh-server

# Adicionar usuário 'jonathan' ao grupo sudo
pct exec $CTID -- adduser jonathan --ingroup sudo

# Habilitar e iniciar o serviço SSH
pct exec $CTID -- systemctl enable ssh
pct exec $CTID -- systemctl start ssh

# Passo 3: Limpar contêiner
pct exec $CTID -- apt clean
pct exec $CTID -- rm -rf /var/log/*
pct exec $CTID -- rm -rf /tmp/*

# Passo 4: Desligar contêiner
pct stop $CTID

# Passo 5: Converter para template
pct template $CTID

# Passo 6: Renomear template
mv /var/lib/vz/template/cache/$CTID.tar.gz /var/lib/vz/template/cache/$TEMPLATE_NAME.tar.gz

echo "Template criado com sucesso: $TEMPLATE_NAME"