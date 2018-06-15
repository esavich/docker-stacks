#!/bin/bash
BITRIX_URL=`echo "https://www.1c-bitrix.ru/download/${BITRIX_REDACTION:-start}_encode_php5.tar.gz" | tr '[:upper:]' '[:lower:]'`
wget -qO- $BITRIX_URL | tar -xz -C .
chown -R www-data:www-data ./*
rm $0
apache2-foreground > /dev/null 2>&1
