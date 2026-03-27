#!/bin/bash
GRN='\033[1;32m'
RED='\033[1;31m'
YEL='\033[1;33m'
NC='\033[0m'
echo -e "${GRN}РЕЖИМ ТЕСТИРОВАНИЯ (БЕЗ УСТАНОВКИ)${NC}"
DOMAIN=$1
if [ -z "$DOMAIN" ]; then echo -e "${RED}❌ Ошибка: домен не задан.${NC}"; exit 1; fі
WEB_PATH="./test_web_$DOMAIN"
mkdir -p "$WEB_PATH"
xray_uuid_vrv="test-uuid-0000-1111-2222"
xray_publicKey_vrv="TEST_PUBLIC_KEY_EXAMPL_1234567890ABCDEF"
xray_privateKey_vrv="TEST_PRIVATE_KEY"
xray_shortIds_vrv="abcdef12"
path_xhttp="testpath"
path_subpage="secret_link_$(date +%s)"
socksUser="user$(date +%s | cut -c 8-)"
socksPasw="pass$(date +%s | cut -c 5-)"
MTProto="tg://proxy?server=$DOMAIN&port=443&secret=dd00000000000000000000000000000000"
subPageLink="https://$DOMAIN/$path_subpage.json"
linkRTY1="vless://${xray_uuid_vrv}@$DOMAIN:443?security=reality&type=tcp&flow=xtls-rprx-vision&sni=$DOMAIN&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}&spx=%2F#vlessRAWrealityVISION"
linkRTY2="vless://${xray_uuid_vrv}@$DOMAIN:443?security=reality&type=xhttp&path=%2F$path_xhttp&mode=stream-one&sni=$DOMAIN&fp=chrome&pbk=${xray_publicKey_vrv}&sid=${xray_shortIds_vrv}#vlessXHTTPrealityEXTRA"
linkTLS1="vless://${xray_uuid_vrv}@$DOMAIN:8443?security=tls&type=tcp&flow=xtls-rprx-vision&sni=$DOMAIN&fp=chrome#vlessRAWtlsVision"
linkTLS2="vless://${xray_uuid_vrv}@$DOMAIN:8443?security=tls&type=xhttp&path=%2F${path_xhttp}&mode=auto&sni=$DOMAIN&fp=chrome#vlessXHTTPtls"
linkTLS3="vless://${xray_uuid_vrv}@$DOMAIN:8443?security=tls&type=ws&path=%2F${path_xhttp}22&sni=$DOMAIN&fp=chrome#vlessWStls"
linkTLS4="vless://${xray_uuid_vrv}@$DOMAIN:8443?security=tls&type=grpc&serviceName=${path_xhttp}11&sni=$DOMAIN&fp=chrome#vlessGRPCtls"
SOCKS5_url="tg://socks?server=$DOMAIN&port=10443&user=${socksUser}&pass=${socksPasw}"
CONFIGS_ARRAY=("REALITY VISION|$linkRTY1" "REALITY XHTTP|$linkRTY2" "TLS RAW|$linkTLS1" "TLS XHTTP|$linkTLS2" "TLS WS|$linkTLS3" "TLS GRPC|$linkTLS4")
ALL_LINKS_TEXT=""
cat > "$WEB_PATH/$path_subpage.html" <<EOF
<!DOCTYPE html><html><head><meta charset="UTF-8"><title>Test Configs</title><style>body{background:#121212;color:#eee;font-family:monospace;padding:20px}.row{background:#1e1e1e;margin:10px 0;padding:10px;border-radius:5px}code{color:#c3e88d;word-break:break-all}</style></head><body><h2>Configs for $DOMAIN</h2>
EOF
for item in "${CONFIGS_ARRAY[@]}"; do
title="${item%%|*}"; link="${item#*|}"
ALL_LINKS_TEXT+="$link<br>"
echo "<div class='row'><b>$title:</b><br><code>$link</code></div>" >> "$WEB_PATH/$path_subpage.html"
done
echo "<h2>Raw Links File</h2>" >> "$WEB_PATH/$path_subpage.html"
{ echo "$linkRTY1"; echo "$linkRTY2"; echo "$linkTLS1"; echo "$linkTLS2"; echo "$linkTLS3"; echo "$linkTLS4"; echo "$SOCKS5_url"; echo "$MTProto"; } > "$WEB_PATH/$path_subpage"
echo "<div class='row'><b>Raw file content created at:</b> $WEB_PATH/$path_subpage</div>" >> "$WEB_PATH/$path_subpage.html"
echo "</body></html>" >> "$WEB_PATH/$path_subpage.html"
echo -e "\n${YEL}=== РЕЗУЛЬТАТЫ ТЕСТА ===${NC}"
echo -e "HTML файл: ${GRN}$WEB_PATH/$path_subpage.html${NC}"
echo -e "Файл со ссылками: ${GRN}$WEB_PATH/$path_subpage${NC}"
echo -e "\n${YEL}Пример первой ссылки:${NC}\n$linkRTY1"
