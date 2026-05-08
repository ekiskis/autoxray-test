
## Рекомендованный скрипт
```
bash -c "$(curl -L https://raw.githubusercontent.com/ekiskis/autoxray-test/refs/heads/main/autoxray-t.sh)" -- поддомен1.Домен.Ком
```
Предоставлять ссылки на хостинг-провайдеров не буду, так как *** блокирует ip-адреса по /32


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

# Сборка с MTProto proxy FakeTLS для ТГ

В связи с начавшейся блокировкой Telegram выпускаю новую сборку с MTProxy на порту 443 и маскировкой под собственный сайт на основе [Telemt](https://github.com/telemt/telemt/blob/main/docs/QUICK_START_GUIDE.ru.md).

Всех дольше будут работать каскадные варианты подключения.

**Для моста (ru/kz VPS)**
```
bash -c "$(curl -L https://raw.githubusercontent.com/ekiskis/autoxray-test/refs/heads/main/autoxray-most.sh)" -- поддомен2.Домен.Ком "vless://xhttp"
```
Также теперь можно использовать несколько xhttp конфигов, все они будут добавлены в мост.


 -- поддомен2.Домен.Ком "vless://xhttp1" "vless://xhttp2" "vless://xhttp3"

**Как удалить Telemt**
```
systemctl stop telemt; systemctl disable telemt; rm -f /etc/systemd/system/telemt.service /bin/telemt; systemctl daemon-reload
```

**Принцип работы**

443 XRAY -> MTP TELEMT -> сайт заглушка

Конфигурация: /etc/telemt/telemt.toml
