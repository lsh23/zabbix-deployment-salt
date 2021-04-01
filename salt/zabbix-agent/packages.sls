install_zabbix-agent_packages:
  pkg.installed:
    - pkgs:
      - zabbix-agent

zabbix-agent:
  file.managed:
    - names:
      - /etc/zabbix/zabbix_agentd.conf:
        - source: salt://zabbix-agent/conf/zabbix_agentd.conf
    - template: jinja
  service.running:
    - enable: True
    - watch:
      - file: /etc/zabbix/zabbix_agentd.conf