
## Рекомендованный скрипт
```
bash -c "$(curl -L https://raw.githubusercontent.com/ekiskis/autoxray-test/refs/heads/main/autoxray.sh)" -- поддомен1.Домен.Ком
```


## Как удалить скрипт
**Удаляем nginx & certbot**
```
systemctl disable nginx certbot; systemctl stop nginx certbot; apt remove nginx certbot -y
```

**Удаляем WARP-cli**
```
echo -e "y" | bash <(curl -fsSL https://gitlab.com/fscarmen/warp/-/raw/main/menu.sh) u
```

**Удаляем XRAY**
```
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ remove --purge
```

Если вы хотите погрузиться в дело конфигурации xray есть отличный [справочник](https://xtls.github.io/ru/config/outbounds/vless.html) и [руководство](https://github.com/XTLS/Xray-core/discussions/3518).

Редактировать конфиг можно тут: **/usr/local/etc/xray/config.json**

После изменений ядро надо перезапустить: **systemctl restart xray**

## Настраиваем мост RU -> EU
Многие столкнулись с блокировками хостинг-сетей по TLS (особенно при использовании мобильного интернета). Существует решение — построение моста между серверами в разных локациях. Для этого необходимо:

1) На заблокированный чистый VPS ставим стандартный рекомендованный скрипт и берем получившийся vless XHTTP reality EXTRA
2) На ru VPS ставим новый скрипт (здесь нам понадобится vless XHTTP reality EXTRA):
```bash
bash -c "$(curl -L https://raw.githubusercontent.com/ekiskis/autoxray-test/main/autoxray-most.sh)" -- поддомен2.вашДОМЕН.com "vless://вашКонфигXHTTP"
```
Установится прокси мост между серверами, итоговая цепочка: конфиг клиента -> ru VPS -> eu VPS -> зарубежный сайт

