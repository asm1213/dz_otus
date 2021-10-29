# Домашнее заданеи №24 
```
LDAP

Установить FreeIPA;
Написать Ansible playbook для конфигурации клиента;
3*. Настроить аутентификацию по SSH-ключам;
4**. Firewall должен быть включен на сервере и на клиенте.

Формат сдачи ДЗ - vagrant + ansible
```
Использовал коллецию ansible https://github.com/freeipa/ansible-freeipa

Все навтройки в инвентори hosts
```
[ipaserver:vars]
ipaadmin_password=ADMPassword1
ipadm_password=DMPassword1
ipaserver_domain=otus.local
ipaserver_realm=OTUS.LOCAL
ipaserver_setup_firewalld=yes
ipaserver_setup_dns=yes
ipaserver_no_host_dns=yes
ipaserver_no_forwarders=yes
ipaserver_no_reverse=yes

[ipaclients:vars]
ipaadmin_password=ADMPassword1
ipaserver_domain=otus.local
ipaserver_realm=OTUS.LOCAL
ipaclient_mkhomedir=yes
ipaclient_servers=dc.otus.local
```
Контроллер доступен с хоста по адресу 13.13.13.13
Для доступа в файл hosts на хосте нужно добавить запись

```13.13.13.13 dc.otus.local``` 
