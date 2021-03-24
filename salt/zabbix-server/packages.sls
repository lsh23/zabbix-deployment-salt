install_zabbix_server_packages:
  pkg.installed:
    - pkgs:
      - zabbix-server-mysql
      - zabbix-frontend-php
      - zabbix-apache-conf