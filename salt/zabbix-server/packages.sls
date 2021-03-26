install_zabbix_server_packages:
  pkg.installed:
    - pkgs:
      - mysql-server
      - python-pymysql
      - zabbix-server-mysql
      - zabbix-frontend-php
      - zabbix-apache-conf

zabbix create db:
  mysql_database.present:
    - name: zabbix
    - character_set: utf8
    - collate: utf8_bin

zabbix grant localhost:
  mysql_user.present:
    - name: zabbix
    - password: {{ pillar['DBPassword'] }}
    - host: localhost
  mysql_grants.present:
    - grant: all privileges
    - database: zabbix.*
    - user: zabbix
    - host: localhost

exprot_schema:
  cmd.run:
    - name: zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz > /usr/share/doc/zabbix-server-mysql/create.sql
    - creates: /usr/share/doc/zabbix-server-mysql/create.sql

import_schema:
  mysql_query.run_file:
    - database: zabbix
    - query_file: /usr/share/doc/zabbix-server-mysql/create.sql

zabbix-server:
  file.managed:
    - names:
      - /etc/zabbix/zabbix_server.conf:
        - source: salt://zabbix-server/conf/zabbix_server.conf
    - template: jinja
  service.running:
    - enable: True
    - watch:
      - file: /etc/zabbix/zabbix_server.conf

apache2:
  service.running:
    - reload: True
    - watch:
      - file: web_installation_skip

web_installation_skip:
  file.managed:
    - names:
      - /etc/zabbix/web/zabbix.conf.php:
        - source: salt://zabbix-server/conf/zabbix.conf.php
    - template: jinja