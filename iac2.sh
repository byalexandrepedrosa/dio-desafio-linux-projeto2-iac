#!/usr/bin/env bash


#######BEGIN SCRIPT##############
# Script criado para o Desafio de Projeto da DIO referente ao Bootcamp - Linux Experience
# (https://web.dio.me/)
#
# Requerimentos do Desafio:
# (Referente a funcionalidade do Script - ordem a seguir segue a do desafio e não a da execução)
#
# 1 - Atualizar o servidor;
# 2 - Instalar o apache2;
# 3 - Instalar o unzip;
# 4 - Baixar a aplicação disponível no endereço https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip no diretório /tmp;
# 5 - Copiar os arquivos da aplicação no diretório padrão do apache;
#
# //TDC -> = TODO Completado referenciado (leia pode se copiar o texto a seguir da flag e buscar no código usando search)
#


#######
# //TDC -> 1 - Atualizar o servidor;
#######

echo "Atualizando o servidor..."

apt-get update
apt-get upgrade -y


#######
# //TDC -> 2 - Instalar o apache2;
# //TDC -> 3 - Instalar o unzip;
#######

echo "Instalando os programas: apache / unzip / wget"

apt-get install apache2 unzip wget -y

STATUS_ACTIVE="$(systemctl is-active apache2.service)"
if ! [ "${STATUS_ACTIVE}" == "active" ]; then
	echo "Iniciando o serviço Apache."
	systemctl start apache2.service
fi

STATUS_ENABLED="$(systemctl is-enabled apache2.service)"
if ! [ "${STATUS_ENABLED}" == "enabled" ]; then
	echo "Configurando a inicialização automática do Apache."
	systemctl enable apache2.service
fi


#######
# //TDC -> 4 - Baixar a aplicação disponível no endereço https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip no diretório /tmp;
# //TDC -> 5 - Copiar os arquivos da aplicação no diretório padrão do apache;
#######

echo "Baixando e copiando os arquivos da aplicação..."

cd /tmp

wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip -O main.zip

unzip -o main.zip

rm -rf /var/www/html/*

mv -u /tmp/linux-site-dio-main/{.*,*} /var/www/html/ > /dev/null 2>&1

rm -fv /tmp/main.zip
rm -rf /tmp/linux-site-dio-main


# Limpa as variáveis
unset STATUS_ACTIVE
unset STATUS_ENABLED
